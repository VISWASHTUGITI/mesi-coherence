// ============================================================
// Module : mesi_controller
// Purpose: One cache controller per core. Handles processor
//          requests, drives bus transactions, snoops all bus
//          activity, and updates MESI states accordingly.
// ============================================================

module mesi_controller #(
    parameter CORE_ID = 0
)(
    input  wire        clk,
    input  wire        rst,

    // ── Processor Interface ───────────────────────────────────
    input  wire        pr_req,
    input  wire        pr_we,
    input  wire [7:0]  pr_addr,
    input  wire [7:0]  pr_wdata,
    output reg         pr_ack,
    output reg  [7:0]  pr_rdata,

    // ── Bus drive interface ───────────────────────────────────
    output reg         bus_req,
    input  wire        bus_grant,
    output reg  [7:0]  bus_addr,
    output reg  [2:0]  bus_cmd,
    output reg  [63:0] bus_wdata,
    output reg         bus_data_valid,
    output reg         bus_shared,

    // ── Bus snoop (broadcast from bus_interface) ──────────────
    input  wire [7:0]  snoop_addr,
    input  wire [2:0]  snoop_cmd,
    input  wire        snoop_valid,
    input  wire [63:0] snoop_data,
    input  wire        snoop_data_ready,
    input  wire        any_shared,

    // ── Cache array interface — core's own pipeline ───────────
    output reg  [7:0]  ca_lookup_addr,
    input  wire        ca_hit,
    input  wire [1:0]  ca_hit_mesi,
    input  wire        ca_hit_way,
    input  wire [63:0] ca_hit_data,
    input  wire        ca_lru_way,

    // NEW: Free-way indicators for the set under ca_lookup_addr.
    // Used on a miss to prefer an empty way over evicting a valid
    // line, instead of blindly following ca_lru_way regardless of
    // whether a free way already exists in this set.
    input  wire        way0_free,
    input  wire        way1_free,

    // Cache array interface — dedicated snoop lookup port.
    // Always driven live with snoop_addr; lets this core answer a
    // foreign snoop with a cache lookup even while fsm_state is busy
    // servicing its own request on the port above.
    output wire [7:0]  ca_snoop_lookup_addr,
    input  wire        ca_snoop_hit,
    input  wire [1:0]  ca_snoop_hit_mesi,
    input  wire        ca_snoop_hit_way,
    input  wire [63:0] ca_snoop_hit_data,

    // Single write port — arbitrated below between the core's own
    // write and a live snoop-driven write before reaching this port.
    output reg         ca_write_en,
    output reg  [7:0]  ca_write_addr,
    output reg         ca_write_way,
    output reg  [1:0]  ca_write_mesi,
    output reg  [63:0] ca_write_data,

    output reg  [1:0]  ca_evict_set,
    output reg         ca_evict_way,
    input  wire [1:0]  ca_evict_mesi,
    input  wire [7:0]  ca_evict_addr,
    input  wire [63:0] ca_evict_data
);

    // MESI states
    localparam INVALID   = 2'b00;
    localparam SHARED    = 2'b01;
    localparam EXCLUSIVE = 2'b10;
    localparam MODIFIED  = 2'b11;

    // Bus commands
    localparam CMD_IDLE    = 3'b000;
    localparam CMD_BUSRD   = 3'b001;
    localparam CMD_BUSRDX  = 3'b010;
    localparam CMD_BUSUPGR = 3'b011;
    localparam CMD_BUSWB   = 3'b100;

    // Controller FSM states
    // Snoop response — both the data supply AND the MESI state write —
    // is handled live, every cycle, independent of fsm_state, using the
    // dedicated snoop port (see below). The old FSM_SNOOP_PROC /
    // FSM_SNOOP_RESUME / snoop_pending mechanism has been removed;
    // deferring a busy core's snoop response was too late for the
    // data-supply half of the job (the live snoop window in
    // bus_interface only lasts a few cycles).
    localparam FSM_IDLE         = 4'd0;
    localparam FSM_TAG_CHECK    = 4'd1;
    localparam FSM_WAIT_BUS     = 4'd2;
    localparam FSM_BUS_DRIVE    = 4'd3;
    localparam FSM_WAIT_DATA    = 4'd4;
    localparam FSM_WRITEBACK    = 4'd5;
    localparam FSM_UPDATE_CACHE = 4'd6;
    localparam FSM_COMPLETE     = 4'd8;

    reg [3:0]  fsm_state;
    reg        saved_we;
    reg [7:0]  saved_addr;
    reg [7:0]  saved_wdata;
    reg        alloc_way;
    reg [63:0] fill_data;
    reg        need_wb;       // pending writeback before fill
    // Latch any_shared when fill data arrives
    reg        saved_any_shared;

    // FIX: ignore our own bus transactions broadcast back to us
    wire foreign_snoop = snoop_valid && !bus_grant;

    // ------------------------------------------------------------
    // NEW: Free-way-preferred allocation decision for a miss.
    //
    // This is the fix for the bug where FSM_TAG_CHECK's miss branch
    // went straight to ca_lru_way with no check for whether a way in
    // this set is simply empty — a purely-history-based LRU bit can
    // point at an occupied way even when the other way is free,
    // causing an unnecessary eviction (and unnecessary writeback if
    // that evicted line happened to be Modified).
    //
    // Priority: an empty way always wins over LRU. LRU is only the
    // fallback when BOTH ways are already occupied.
    // ------------------------------------------------------------
    wire pick_way0_free = way0_free;
    wire pick_way1_free = !way0_free && way1_free;
    wire pick_lru        = !way0_free && !way1_free;

    wire tag_check_alloc_way = pick_way0_free ? 1'b0 :
                                pick_way1_free ? 1'b1 :
                                ca_lru_way;

    // ------------------------------------------------------------
    // State-independent snoop response — data-supply half.
    //
    // ca_snoop_lookup_addr is always driven with snoop_addr, live,
    // every cycle — this uses cache_array's dedicated snoop port, so
    // it never competes with whatever the core's own FSM is doing on
    // the main lookup port.
    // ------------------------------------------------------------
    assign ca_snoop_lookup_addr = snoop_addr;

    // Does a live snoop need a response from this cache, right now,
    // regardless of fsm_state?
    wire snoop_live_hit = foreign_snoop && ca_snoop_hit;

    // What the snoop response wants to write into the cache (state
    // update), computed combinationally, live. This does NOT yet decide
    // whether it actually gets to write this cycle — that arbitration
    // happens further down against the core's own FSM_UPDATE_CACHE write.
    reg        snoop_wr_en;
    reg  [1:0] snoop_wr_mesi;
    reg        snoop_bus_data_valid;
    reg [63:0] snoop_bus_wdata;
    reg        snoop_bus_shared;

    always @(*) begin
        snoop_wr_en          = 1'b0;
        snoop_wr_mesi        = ca_snoop_hit_mesi;
        snoop_bus_data_valid = 1'b0;
        snoop_bus_wdata      = 64'b0;
        snoop_bus_shared     = 1'b0;

        if (snoop_live_hit) begin
            case (snoop_cmd)
                CMD_BUSRD: begin
                    case (ca_snoop_hit_mesi)
                        EXCLUSIVE: begin
                            snoop_bus_data_valid = 1'b1;
                            snoop_bus_wdata       = ca_snoop_hit_data;
                            snoop_bus_shared      = 1'b1;
                            snoop_wr_en           = 1'b1;
                            snoop_wr_mesi         = SHARED;
                        end
                        MODIFIED: begin
                            // Cache-to-cache transfer
                            snoop_bus_data_valid = 1'b1;
                            snoop_bus_wdata       = ca_snoop_hit_data;
                            snoop_bus_shared      = 1'b1;
                            snoop_wr_en           = 1'b1;
                            snoop_wr_mesi         = SHARED;
                        end
                        SHARED: begin
                            snoop_bus_shared = 1'b1;
                            // already SHARED — no write needed
                        end
                        default: ;
                    endcase
                end
                CMD_BUSRDX: begin
                    case (ca_snoop_hit_mesi)
                        MODIFIED: begin
                            snoop_bus_data_valid = 1'b1;
                            snoop_bus_wdata       = ca_snoop_hit_data;
                            // FIX (RC4, preserved): bus_shared=0 for BusRdX —
                            // requester gets exclusive ownership, not shared.
                            snoop_bus_shared      = 1'b0;
                            snoop_wr_en           = 1'b1;
                            snoop_wr_mesi         = INVALID;
                        end
                        EXCLUSIVE, SHARED: begin
                            snoop_wr_en   = 1'b1;
                            snoop_wr_mesi = INVALID;
                        end
                        default: ;
                    endcase
                end
                CMD_BUSUPGR: begin
                    if (ca_snoop_hit_mesi == SHARED) begin
                        snoop_wr_en   = 1'b1;
                        snoop_wr_mesi = INVALID;
                    end
                end
                default: ;
            endcase
        end
    end

    // Does the snoop actually want the write port THIS cycle?
    // Used both to arbitrate the write port and to tell the core's own
    // FSM_UPDATE_CACHE whether it must stall and retry.
    wire snoop_wants_write = snoop_wr_en;

    // ── Sequential: state register + latch requests ──────────
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            fsm_state        <= FSM_IDLE;
            saved_we         <= 1'b0;
            saved_addr       <= 8'b0;
            saved_wdata      <= 8'b0;
            alloc_way        <= 1'b0;
            fill_data        <= 64'b0;
            need_wb          <= 1'b0;
            saved_any_shared <= 1'b0;
        end
        else begin
            case (fsm_state)

                FSM_IDLE: begin
                    if (pr_req) begin
                        saved_we    <= pr_we;
                        saved_addr  <= pr_addr;
                        saved_wdata <= pr_wdata;
                        fsm_state   <= FSM_TAG_CHECK;
                    end
                    // NOTE: foreign_snoop no longer needs handling here —
                    // it is answered live, every cycle, by the
                    // state-independent block above, regardless of
                    // fsm_state. FSM_IDLE only needs to react to pr_req.
                end

                FSM_TAG_CHECK: begin
                    if (ca_hit) begin
                        // FIX (RC1, preserved): Always latch ca_hit_way for
                        // ALL hit paths so FSM_UPDATE_CACHE writes to the
                        // correct way.
                        alloc_way <= ca_hit_way;
                        need_wb   <= 1'b0;
                        case (ca_hit_mesi)
                            MODIFIED, EXCLUSIVE: begin
                                if (!saved_we) begin
                                    // Read hit → complete
                                    fsm_state <= FSM_COMPLETE;
                                end else begin
                                    // Write hit on M/E → silent upgrade to M
                                    fsm_state <= FSM_UPDATE_CACHE;
                                end
                            end
                            SHARED: begin
                                if (!saved_we) begin
                                    // Read hit on S → complete
                                    fsm_state <= FSM_COMPLETE;
                                end else begin
                                    // Write hit on S → need BusUpgr
                                    fsm_state <= FSM_WAIT_BUS;
                                end
                            end
                            default: fsm_state <= FSM_WAIT_BUS;
                        endcase
                    end
                    else begin
                        // NEW: Miss — prefer an empty way over evicting a
                        // valid one. tag_check_alloc_way already encodes
                        // "free way if one exists, else ca_lru_way" (see
                        // the combinational block above). need_wb is only
                        // asserted when we're actually falling back to
                        // LRU eviction (pick_lru) AND that way is Modified
                        // — a free way never needs a writeback, since
                        // there's nothing valid there to save.
                        alloc_way <= tag_check_alloc_way;
                        need_wb   <= pick_lru && (ca_evict_mesi == MODIFIED);
                        fsm_state <= FSM_WAIT_BUS;
                    end
                end

                FSM_WAIT_BUS: begin
                    if (bus_grant)
                        fsm_state <= FSM_BUS_DRIVE;
                end

                FSM_BUS_DRIVE: begin
                    if (need_wb) begin
                        // Do writeback first, then re-request
                        need_wb   <= 1'b0;
                        fsm_state <= FSM_WRITEBACK;
                    end
                    else if (ca_hit && ca_hit_mesi == SHARED && saved_we) begin
                        // BusUpgr path
                        fsm_state <= FSM_UPDATE_CACHE;
                    end
                    else begin
                        // BusRd / BusRdX path
                        fsm_state <= FSM_WAIT_DATA;
                    end
                end

                FSM_WRITEBACK: begin
                    // Writeback done in 1 cycle (memory absorbs it)
                    fsm_state <= FSM_WAIT_BUS;
                end

                FSM_WAIT_DATA: begin
                    if (snoop_data_ready) begin
                        fill_data        <= snoop_data;
                        saved_any_shared <= any_shared;  // latch before it clears
                        fsm_state        <= FSM_UPDATE_CACHE;
                    end
                end

                FSM_UPDATE_CACHE: begin
                    // Write-port priority + stall-and-retry.
                    // A live snoop write always wins the write port (it
                    // has a hard deadline — the live snoop window — the
                    // core's own write does not). If the snoop wants the
                    // port this cycle, stay here and retry next cycle;
                    // the combinational block below keeps driving the
                    // exact same write request every cycle we're in this
                    // state, so nothing is lost — it just waits its turn.
                    if (snoop_wants_write) begin
                        fsm_state <= FSM_UPDATE_CACHE;   // retry next cycle
                    end
                    else begin
                        fsm_state <= FSM_COMPLETE;
                    end
                end

                FSM_COMPLETE: begin
                    fsm_state <= FSM_IDLE;
                end

                default: fsm_state <= FSM_IDLE;
            endcase
        end
    end

    // ── Combinational outputs ─────────────────────────────────
    always @(*) begin
        // Safe defaults
        pr_ack          = 1'b0;
        pr_rdata        = 8'b0;
        bus_req         = 1'b0;
        bus_addr        = 8'b0;
        bus_cmd         = CMD_IDLE;
        bus_wdata       = 64'b0;
        bus_data_valid  = 1'b0;
        bus_shared      = 1'b0;
        ca_lookup_addr  = saved_addr;
        ca_evict_set    = saved_addr[4:3];
        ca_evict_way    = alloc_way;

        case (fsm_state)

            FSM_IDLE: begin
                ca_lookup_addr = pr_addr;
            end

            FSM_TAG_CHECK: begin
                ca_lookup_addr = saved_addr;
                // NEW: drive ca_evict_way from the SAME-cycle allocation
                // decision (tag_check_alloc_way), not the stale, previous
                // transaction's alloc_way register. This ensures
                // ca_evict_mesi (read combinationally via evict_set/
                // evict_way) reflects the way we are actually about to
                // use, so need_wb's decision in the sequential block
                // above is based on the correct candidate.
                ca_evict_way = tag_check_alloc_way;
            end

            FSM_WAIT_BUS: begin
                bus_req  = 1'b1;
                bus_addr = saved_addr;
                if (need_wb) begin
                    // Issue writeback for dirty evictee
                    bus_req        = 1'b1;
                    bus_cmd        = CMD_BUSWB;
                    bus_wdata      = ca_evict_data;
                    bus_data_valid = 1'b1;
                    bus_addr       = ca_evict_addr;
                end
                else if (ca_hit && ca_hit_mesi == SHARED && saved_we) begin
                    bus_cmd = CMD_BUSUPGR;
                end
                else begin
                    bus_cmd = saved_we ? CMD_BUSRDX : CMD_BUSRD;
                end
            end

            FSM_BUS_DRIVE: begin
               // ONLY decisions, no outputs
            end

            FSM_WRITEBACK: begin
             // just wait / transition
            end

            FSM_WAIT_DATA: begin
                // Waiting — nothing to drive
            end

            FSM_COMPLETE: begin
                pr_ack   = 1'b1;
                pr_rdata = ca_hit ?
                    ca_hit_data[saved_addr[2:0]*8 +: 8] :
                    fill_data  [saved_addr[2:0]*8 +: 8];
            end

            default: ;
        endcase

        // ------------------------------------------------------------
        // bus_data_valid / bus_wdata / bus_shared — live snoop
        // response overrides whatever the case block above set. The
        // case block never sets these for anything other than the
        // FSM_WAIT_BUS writeback path, so the only real collision is a
        // core issuing its own writeback while simultaneously being
        // snooped — the snoop still wins, since its deadline is harder.
        // ------------------------------------------------------------
        if (snoop_live_hit && (snoop_bus_data_valid || snoop_bus_shared)) begin
            bus_data_valid = snoop_bus_data_valid;
            bus_wdata      = snoop_bus_wdata;
            bus_shared     = snoop_bus_shared;
        end

        // ------------------------------------------------------------
        // Write-port priority mux. Snoop write wins outright; the
        // core's own FSM_UPDATE_CACHE write only reaches the port when
        // no live snoop write is pending this cycle. FSM_UPDATE_CACHE's
        // sequential block (above) already knows to stall and retry
        // when it loses, so nothing here needs to "remember" a lost
        // write — the FSM state itself is the memory of that intent.
        // ------------------------------------------------------------
        if (snoop_wants_write) begin
            ca_write_en   = 1'b1;
            ca_write_addr = snoop_addr;
            ca_write_way  = ca_snoop_hit_way;
            ca_write_mesi = snoop_wr_mesi;
            ca_write_data = ca_snoop_hit_data;
        end
        else if (fsm_state == FSM_UPDATE_CACHE) begin
            ca_write_en   = 1'b1;
            ca_write_addr = saved_addr;
            ca_write_way  = alloc_way;
            ca_write_data = saved_we
                ? ((ca_hit ? ca_hit_data : fill_data) & ~(64'hFF << (saved_addr[2:0]*8)))
                  | ({56'b0, saved_wdata} << (saved_addr[2:0]*8))
                : fill_data;
            // Determine new MESI state
            if (saved_we)
                ca_write_mesi = MODIFIED;
            else if (saved_any_shared || any_shared)
                ca_write_mesi = SHARED;
            else
                ca_write_mesi = EXCLUSIVE;
        end
        else begin
            ca_write_en   = 1'b0;
            ca_write_addr = 8'b0;
            ca_write_way  = 1'b0;
            ca_write_mesi = INVALID;
            ca_write_data = 64'b0;
        end
    end

endmodule
