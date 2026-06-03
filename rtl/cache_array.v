// ============================================================
// Module : cache_array
// Purpose: Stores cache lines with MESI state, tag, valid bit,
//          and data. 2-way set associative, 4 sets, 8B blocks.
//          Address: [7:5]=tag [4:3]=index [2:0]=offset
// ============================================================

module cache_array (
    input  wire        clk,
    input  wire        rst,

    // Lookup port (combinational)
    input  wire [7:0]  lookup_addr,
    output reg         hit,
    output reg  [1:0]  hit_mesi,
    output reg         hit_way,
    output reg  [63:0] hit_data,

    // Write port (sequential)
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

    // Address decomposition
    wire [2:0] lookup_tag   = lookup_addr[7:5];
    wire [1:0] lookup_index = lookup_addr[4:3];
    wire [2:0] write_tag    = write_addr[7:5];
    wire [1:0] write_index  = write_addr[4:3];

    // ── Combinational lookup ──────────────────────────────────
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

    // LRU way: if lru[index]=0 → way0 was recent → evict way1; else evict way0
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
