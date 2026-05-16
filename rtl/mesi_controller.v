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

    // ── Cache array interface ─────────────────────────────────
    output reg  [7:0]  ca_lookup_addr,
    input  wire        ca_hit,
    input  wire [1:0]  ca_hit_mesi,
    input  wire        ca_hit_way,
    input  wire [63:0] ca_hit_data,
    input  wire        ca_lru_way,

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
    localparam FSM_IDLE         = 4'd0;
    localparam FSM_TAG_CHECK    = 4'd1;
    localparam FSM_WAIT_BUS     = 4'd2;
    localparam FSM_BUS_DRIVE    = 4'd3;
    localparam FSM_WAIT_DATA    = 4'd4;
    localparam FSM_WRITEBACK    = 4'd5;
    localparam FSM_UPDATE_CACHE = 4'd6;
    localparam FSM_SNOOP_PROC   = 4'd7;
    localparam FSM_COMPLETE     = 4'd8;

    reg [3:0]  fsm_state;
    reg        saved_we;
    reg [7:0]  saved_addr;
    reg [7:0]  saved_wdata;
    reg        alloc_way;
    reg [63:0] fill_data;
    reg        need_wb;       // pending writeback before fill

    // ── Sequential: state register + latch requests ──────────
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            fsm_state  <= FSM_IDLE;
            saved_we   <= 1'b0;
            saved_addr <= 8'b0;
            saved_wdata<= 8'b0;
            alloc_way  <= 1'b0;
            fill_data  <= 64'b0;
            need_wb    <= 1'b0;
        end
        else begin
            case (fsm_state)

                FSM_IDLE: begin
                    if (pr_req && !snoop_valid) begin
                        saved_we    <= pr_we;
                        saved_addr  <= pr_addr;
                        saved_wdata <= pr_wdata;
                        fsm_state   <= FSM_TAG_CHECK;
                    end
                    else if (snoop_valid) begin
                        fsm_state <= FSM_SNOOP_PROC;
                    end
                end

                FSM_TAG_CHECK: begin
                    if (ca_hit) begin
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
                                    alloc_way <= ca_hit_way;
                                    need_wb   <= 1'b0;
                                    fsm_state <= FSM_WAIT_BUS;
                                end
                            end
                            default: fsm_state <= FSM_WAIT_BUS;
                        endcase
                    end
                    else begin
                        // Miss: check if evict candidate is Modified
                        alloc_way <= ca_lru_way;
                        need_wb   <= (ca_evict_mesi == MODIFIED);
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
                        fill_data <= snoop_data;
                        fsm_state <= FSM_UPDATE_CACHE;
                    end
                end

                FSM_UPDATE_CACHE: begin
                    fsm_state <= FSM_COMPLETE;
                end

                FSM_COMPLETE: begin
                    fsm_state <= FSM_IDLE;
                end

                FSM_SNOOP_PROC: begin
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
        ca_write_en     = 1'b0;
        ca_write_addr   = 8'b0;
        ca_write_way    = 1'b0;
        ca_write_mesi   = INVALID;
        ca_write_data   = 64'b0;
        ca_evict_set    = saved_addr[4:3];
        ca_evict_way    = alloc_way;

        case (fsm_state)

            FSM_IDLE: begin
                ca_lookup_addr = pr_addr;
            end

            FSM_TAG_CHECK: begin
                ca_lookup_addr = saved_addr;
            end

            FSM_WAIT_BUS: begin
                bus_req  = 1'b1;
                bus_addr = saved_addr;
            end

            FSM_BUS_DRIVE: begin
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

            FSM_WRITEBACK: begin
                bus_req        = 1'b0;
                bus_cmd        = CMD_BUSWB;
                bus_wdata      = ca_evict_data;
                bus_data_valid = 1'b1;
                bus_addr       = ca_evict_addr;
            end

            FSM_WAIT_DATA: begin
                // Waiting — nothing to drive
            end

            FSM_UPDATE_CACHE: begin
                ca_write_en   = 1'b1;
                ca_write_addr = saved_addr;
                ca_write_way  = alloc_way;
                ca_write_data = saved_we ? {56'b0, saved_wdata} : fill_data;
                // Determine new MESI state
                if (saved_we)
                    ca_write_mesi = MODIFIED;
                else if (any_shared)
                    ca_write_mesi = SHARED;
                else
                    ca_write_mesi = EXCLUSIVE;
            end

            FSM_COMPLETE: begin
                pr_ack   = 1'b1;
                pr_rdata = ca_hit ?
                    ca_hit_data[saved_addr[2:0]*8 +: 8] :
                    fill_data  [saved_addr[2:0]*8 +: 8];
            end

            FSM_SNOOP_PROC: begin
                ca_lookup_addr = snoop_addr;
                if (ca_hit) begin
                    case (snoop_cmd)
                        CMD_BUSRD: begin
                            case (ca_hit_mesi)
                                EXCLUSIVE: begin
                                    bus_shared    = 1'b1;
                                    ca_write_en   = 1'b1;
                                    ca_write_addr = snoop_addr;
                                    ca_write_way  = ca_hit_way;
                                    ca_write_mesi = SHARED;
                                    ca_write_data = ca_hit_data;
                                end
                                MODIFIED: begin
                                    bus_req        = 1'b1;
                                    bus_cmd        = CMD_BUSWB;
                                    bus_wdata      = ca_hit_data;
                                    bus_data_valid = 1'b1;
                                    bus_shared     = 1'b1;
                                    ca_write_en    = 1'b1;
                                    ca_write_addr  = snoop_addr;
                                    ca_write_way   = ca_hit_way;
                                    ca_write_mesi  = SHARED;
                                    ca_write_data  = ca_hit_data;
                                end
                                SHARED: begin
                                    bus_shared = 1'b1;
                                end
                                default: ;
                            endcase
                        end
                        CMD_BUSRDX: begin
                            case (ca_hit_mesi)
                                MODIFIED: begin
                                    bus_req        = 1'b1;
                                    bus_cmd        = CMD_BUSWB;
                                    bus_wdata      = ca_hit_data;
                                    bus_data_valid = 1'b1;
                                    ca_write_en    = 1'b1;
                                    ca_write_addr  = snoop_addr;
                                    ca_write_way   = ca_hit_way;
                                    ca_write_mesi  = INVALID;
                                    ca_write_data  = ca_hit_data;
                                end
                                EXCLUSIVE, SHARED: begin
                                    ca_write_en   = 1'b1;
                                    ca_write_addr = snoop_addr;
                                    ca_write_way  = ca_hit_way;
                                    ca_write_mesi = INVALID;
                                    ca_write_data = ca_hit_data;
                                end
                                default: ;
                            endcase
                        end
                        CMD_BUSUPGR: begin
                            if (ca_hit_mesi == SHARED) begin
                                ca_write_en   = 1'b1;
                                ca_write_addr = snoop_addr;
                                ca_write_way  = ca_hit_way;
                                ca_write_mesi = INVALID;
                                ca_write_data = ca_hit_data;
                            end
                        end
                        default: ;
                    endcase
                end
            end

            default: ;
        endcase
    end

endmodule
