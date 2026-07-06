// ============================================================
// Module : cache_array
// Purpose: Stores cache lines with MESI state, tag, valid bit,
//          and data. 2-way set associative, 4 sets, 8B blocks.
//          Address: [7:5]=tag [4:3]=index [2:0]=offset
// ============================================================

module cache_array (
    input  wire        clk,
    input  wire        rst,

    // Lookup port (combinational) — core's own pipeline
    input  wire [7:0]  lookup_addr,
    output reg         hit,
    output reg  [1:0]  hit_mesi,
    output reg         hit_way,
    output reg  [63:0] hit_data,

    // NEW: Free-way indicators for the SET currently addressed by
    // lookup_addr. Lets the controller prefer an empty way over
    // evicting a valid line on a miss, instead of blindly following
    // LRU regardless of whether a free way already exists.
    output wire        way0_free,
    output wire        way1_free,

    // Second lookup port (combinational) — dedicated to live
    // snoop processing. Reads the exact same storage arrays as the
    // port above, but on its own address input, so a core that is
    // busy with its own tag check (via lookup_addr) can still answer
    // a foreign snoop on this address the same cycle. This is just
    // duplicated read/compare logic, not duplicated storage — no
    // second copy of valid/mesi/tag/data is created.
    input  wire [7:0]  snoop_lookup_addr,
    output reg         snoop_hit,
    output reg  [1:0]  snoop_hit_mesi,
    output reg         snoop_hit_way,
    output reg  [63:0] snoop_hit_data,

    // Write port (sequential) — still single-ported. Arbitration
    // between "core's own write" and "snoop-driven write" happens
    // one level up, in mesi_controller, before reaching this port.
    input  wire        write_en,
    input  wire [7:0]  write_addr,
    input  wire        write_way,
    input  wire [1:0]  write_mesi,
    input  wire [63:0] write_data,

    // Eviction inspection port (combinational)
    input  wire [1:0]  evict_set,
    input  wire        evict_way,
    output wire [1:0]  evict_mesi,
    output wire [7:0]  evict_addr_out,
    output wire [63:0] evict_data,

    // LRU way to evict (combinational, based on lookup_addr index)
    output wire        lru_way_out
);

    // MESI encoding
    localparam INVALID   = 2'b00;
    localparam SHARED    = 2'b01;
    localparam EXCLUSIVE = 2'b10;
    localparam MODIFIED  = 2'b11;

    // Storage: [set 0..3][way 0..1]
    reg        valid [0:3][0:1];
    reg [1:0]  mesi  [0:3][0:1];
    reg [2:0]  tag   [0:3][0:1];
    reg [63:0] data  [0:3][0:1];
    reg        lru   [0:3];       // 0=way0 recent, 1=way1 recent

    // Address decomposition — core's own lookup port
    wire [2:0] lookup_tag   = lookup_addr[7:5];
    wire [1:0] lookup_index = lookup_addr[4:3];
    wire [2:0] write_tag    = write_addr[7:5];
    wire [1:0] write_index  = write_addr[4:3];

    // Address decomposition — dedicated snoop lookup port
    wire [2:0] snoop_tag   = snoop_lookup_addr[7:5];
    wire [1:0] snoop_index = snoop_lookup_addr[4:3];

    // NEW: Free-way check for the set currently under the core's own
    // lookup_addr — purely combinational, reads the same valid[] bits
    // the hit-detection loop below already uses.
    assign way0_free = ~valid[lookup_index][0];
    assign way1_free = ~valid[lookup_index][1];

    // ── Combinational lookup — core's own pipeline ────────────
    integer w;
    always @(*) begin
        hit      = 1'b0;
        hit_mesi = INVALID;
        hit_way  = 1'b0;
        hit_data = 64'b0;
        for (w = 0; w < 2; w = w + 1) begin
            if (valid[lookup_index][w]
                && (tag[lookup_index][w] == lookup_tag)
                && (mesi[lookup_index][w] != INVALID)) begin
                hit      = 1'b1;
                hit_mesi = mesi[lookup_index][w];
                hit_way  = w[0];
                hit_data = data[lookup_index][w];
            end
        end
    end

    // Combinational lookup — dedicated snoop path. Identical
    // logic to the block above, just reading the same arrays on the
    // snoop address, so it can run every cycle independent of what
    // the core's own FSM is doing on the port above.
    integer sw;
    always @(*) begin
        snoop_hit      = 1'b0;
        snoop_hit_mesi = INVALID;
        snoop_hit_way  = 1'b0;
        snoop_hit_data = 64'b0;
        for (sw = 0; sw < 2; sw = sw + 1) begin
            if (valid[snoop_index][sw]
                && (tag[snoop_index][sw] == snoop_tag)
                && (mesi[snoop_index][sw] != INVALID)) begin
                snoop_hit      = 1'b1;
                snoop_hit_mesi = mesi[snoop_index][sw];
                snoop_hit_way  = sw[0];
                snoop_hit_data = data[snoop_index][sw];
            end
        end
    end

    // LRU way: if lru[index]=0 → way0 was recent → evict way1; else evict way0
    // NOTE: this is only consulted by mesi_controller when NEITHER way is
    // free (see way0_free/way1_free above) — it is the fallback policy,
    // not the first choice, after the fix.
    assign lru_way_out = ~lru[lookup_index];

    // ── Sequential write ──────────────────────────────────────
    integer i, j;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 4; i = i + 1) begin
                for (j = 0; j < 2; j = j + 1) begin
                    valid[i][j] <= 1'b0;
                    mesi [i][j] <= INVALID;
                    tag  [i][j] <= 3'b0;
                    data [i][j] <= 64'b0;
                end
                lru[i] <= 1'b1;  // FIX: ~lru gives way=0 on first alloc
            end
        end
        else if (write_en) begin
            mesi [write_index][write_way] <= write_mesi;
            tag  [write_index][write_way] <= write_tag;
            data [write_index][write_way] <= write_data;
            if (write_mesi == INVALID) begin
                // Invalidation: mark this way as LEAST recent so it
                // gets reused first on next allocation (correct LRU behavior)
                valid[write_index][write_way] <= 1'b0;
                lru  [write_index]            <= ~write_way;
            end else begin
                // Valid fill: mark this way as MOST recent
                valid[write_index][write_way] <= 1'b1;
                lru  [write_index]            <= write_way;
            end
        end
    end

    // ── Eviction inspection ───────────────────────────────────
    assign evict_mesi     = mesi[evict_set][evict_way];
    assign evict_data     = data[evict_set][evict_way];
    assign evict_addr_out = {tag[evict_set][evict_way], evict_set, 3'b000};

endmodule
