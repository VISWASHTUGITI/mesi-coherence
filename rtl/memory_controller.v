// ============================================================
// Module : memory_controller
// Purpose: Models main memory with configurable latency.
//          Responds to BusRd/BusRdX with block data after
//          MEM_LATENCY cycles. Absorbs BusWB writebacks.
//          256 bytes, byte-addressable, 8-byte line fill.
// ============================================================

module memory_controller #(
    parameter MEM_LATENCY   = 10,
    parameter WB_FIFO_DEPTH = 4   // NEW: depth of the writeback buffer
)(
    input  wire        clk,
    input  wire        rst,

    // From bus_interface
    input  wire [7:0]  mem_addr,
    input  wire [2:0]  mem_cmd,
    input  wire [63:0] mem_wdata,
    input  wire        mem_req,

    // To bus_interface
    output reg  [63:0] mem_data,
    output reg         mem_data_valid,
    output reg         mem_wb_ack,
    // NEW: address tag sent back with mem_data_valid, so bus_interface
    // can verify the response actually belongs to its active transaction
    output reg  [7:0]  mem_resp_addr
);

    localparam CMD_IDLE    = 3'b000;
    localparam CMD_BUSRD   = 3'b001;
    localparam CMD_BUSRDX  = 3'b010;
    localparam CMD_BUSUPGR = 3'b011;
    localparam CMD_BUSWB   = 3'b100;

    localparam MEM_IDLE    = 3'd0;
    localparam MEM_DECODE  = 3'd1;
    localparam MEM_WAIT    = 3'd2;
    localparam MEM_RESPOND = 3'd3;
    localparam MEM_WRITE   = 3'd4;

    // 256-byte memory array
    reg [7:0] mem_array [0:255];

    reg [2:0] mem_fsm;
    reg [7:0] saved_addr;
    reg [2:0] saved_cmd;
    reg [63:0]saved_wdata;
    reg [3:0] lat_count;   // counts up to MEM_LATENCY

    // ------------------------------------------------------------
    // NEW: Writeback buffer (FIFO), replacing the old single-slot
    // wb_pending/wb_addr/wb_data.
    //
    // Why: the old single slot could be silently overwritten if a
    // second BusWB arrived before the first one was drained (mem_fsm
    // still busy elsewhere). A FIFO lets multiple writebacks queue up
    // safely instead of colliding.
    //
    // Priority rule: reads are latency-critical (a core is stalled
    // waiting on them) — writebacks are not (the dirty data is already
    // safely captured here once pushed). So MEM_IDLE always services a
    // pending read before draining a queued writeback. Writebacks only
    // drain during "gaps" with no read waiting, which the bus protocol
    // above guarantees will occur (only one transaction in flight at a
    // time, with a SNOOP window between transactions).
    // ------------------------------------------------------------
    localparam WB_PTR_W = $clog2(WB_FIFO_DEPTH);

    reg [7:0]          wb_fifo_addr [0:WB_FIFO_DEPTH-1];
    reg [63:0]         wb_fifo_data [0:WB_FIFO_DEPTH-1];
    reg [WB_PTR_W-1:0] wb_head;              // read pointer
    reg [WB_PTR_W-1:0] wb_tail;              // write pointer
    reg [WB_PTR_W:0]   wb_count;             // entries currently queued (extra bit to count up to DEPTH)

    // NEW: Read override — capture BusRd/BusRdX even when memory is busy.
    // Kept as a single slot (not a FIFO): the bus protocol above this
    // module only ever allows one transaction in flight at a time, so a
    // second read cannot legally arrive before the first is serviced.
    // A FIFO would be extra headroom, not a correctness requirement, as
    // long as that single-transaction serialization holds.
    reg        rd_pending;
    reg [7:0]  rd_addr;
    reg [2:0]  rd_cmd;

    // NEW: combinational push/pop conditions for the FIFO. Declared as
    // wires so wb_count/wb_head/wb_tail are each updated exactly once per
    // cycle, correctly handling the case where a push and a pop happen on
    // the same cycle (a new writeback arrives while an old one drains).
    wire wb_push = mem_req && (mem_cmd == CMD_BUSWB) && (wb_count < WB_FIFO_DEPTH);
    wire wb_pop  = (mem_fsm == MEM_IDLE) && !rd_pending && (wb_count > 0);

    integer b, base_addr;

    integer init_i;
    integer wbf_i;   // NEW: loop var for FIFO reset

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Initialize: mem_array[i] = i
            for (init_i = 0; init_i < 256; init_i = init_i + 1)
                mem_array[init_i] <= init_i[7:0];

            mem_fsm        <= MEM_IDLE;
            mem_data       <= 64'b0;
            mem_data_valid <= 1'b0;
            mem_wb_ack     <= 1'b0;
            mem_resp_addr  <= 8'b0;   // NEW
            saved_addr     <= 8'b0;
            saved_cmd      <= CMD_IDLE;
            saved_wdata    <= 64'b0;
            lat_count      <= 4'b0;

            // NEW: writeback FIFO reset
            wb_head        <= 0;
            wb_tail        <= 0;
            wb_count       <= 0;
            for (wbf_i = 0; wbf_i < WB_FIFO_DEPTH; wbf_i = wbf_i + 1) begin
                wb_fifo_addr[wbf_i] <= 8'b0;
                wb_fifo_data[wbf_i] <= 64'b0;
            end

            rd_pending     <= 1'b0;   // NEW
            rd_addr        <= 8'b0;   // NEW
            rd_cmd         <= CMD_IDLE; // NEW
        end
        else begin
            mem_data_valid <= 1'b0;
            mem_wb_ack     <= 1'b0;

            // ------------------------------------------------------------
            // NEW: push logic for the writeback FIFO. Runs unconditionally
            // every cycle (outside the mem_fsm case), same reasoning as the
            // original wb_pending capture — mem_req is a 1-cycle pulse and
            // must never be missed regardless of what mem_fsm is doing.
            //
            // Guarded against overflow: if the FIFO is already full
            // (wb_push stays low), the incoming writeback is dropped —
            // visibly bounded by WB_FIFO_DEPTH, rather than silently
            // overwriting an existing entry the way the old single-slot
            // version could. Deepen WB_FIFO_DEPTH if this is ever hit.
            // ------------------------------------------------------------
            if (wb_push) begin
                wb_fifo_addr[wb_tail] <= mem_addr;
                wb_fifo_data[wb_tail] <= mem_wdata;
                wb_tail <= wb_tail + 1'b1;
            end
            // Always capture a BusRd/BusRdX request — even if memory is
            // busy. Same reasoning as the BusWB capture above: mem_req is
            // a 1-cycle pulse, and without this, a read arriving while
            // mem_fsm is not in MEM_IDLE would be silently dropped.
            else if (mem_req && (mem_cmd == CMD_BUSRD || mem_cmd == CMD_BUSRDX)) begin
                rd_pending <= 1'b1;
                rd_addr    <= mem_addr;
                rd_cmd     <= mem_cmd;
            end

            // NEW: single, combined FIFO occupancy update — handles a
            // push and a pop landing in the same cycle correctly, since
            // wb_push/wb_pop are independent combinational conditions.
            if (wb_push && wb_pop)
                wb_count <= wb_count;            // one in, one out — net zero
            else if (wb_push)
                wb_count <= wb_count + 1'b1;
            else if (wb_pop)
                wb_count <= wb_count - 1'b1;

            if (wb_pop)
                wb_head <= wb_head + 1'b1;

            case (mem_fsm)

                MEM_IDLE: begin
                    if (rd_pending) begin
                        // NEW: read takes priority over any queued
                        // writeback — the processor is stalled waiting on
                        // this, whereas writeback data is already safely
                        // sitting in the FIFO and can wait.
                        saved_addr  <= rd_addr;
                        saved_cmd   <= rd_cmd;
                        rd_pending  <= 1'b0;
                        lat_count   <= 4'b0;
                        mem_fsm     <= MEM_DECODE;
                    end
                    else if (wb_pop) begin
                        // NEW: no read waiting — safe to drain one queued
                        // writeback from the FIFO head. (wb_pop already
                        // encodes "mem_fsm==MEM_IDLE && !rd_pending &&
                        // wb_count>0", so this mirrors that condition; the
                        // pointer/count updates themselves happen in the
                        // combined blocks above, outside this case, so
                        // they are not duplicated here.)
                        saved_addr  <= wb_fifo_addr[wb_head];
                        saved_wdata <= wb_fifo_data[wb_head];
                        saved_cmd   <= CMD_BUSWB;
                        mem_fsm     <= MEM_WRITE;
                    end
                end

                MEM_DECODE: begin
                    case (saved_cmd)
                        CMD_BUSRD, CMD_BUSRDX : mem_fsm <= MEM_WAIT;
                        CMD_BUSWB             : mem_fsm <= MEM_WRITE;
                        default               : mem_fsm <= MEM_IDLE;
                    endcase
                end
                    
                MEM_WAIT: begin
                    lat_count <= lat_count + 1;
                    if (lat_count == MEM_LATENCY - 2)
                        mem_fsm <= MEM_RESPOND;
                end

                MEM_RESPOND: begin
                    // Assemble 8-byte block from byte array
                    begin : rd_block
                        integer rb;
                        reg [7:0] rbase;
                        rbase = {saved_addr[7:3], 3'b000};
                        for (rb = 0; rb < 8; rb = rb + 1)
                            mem_data[rb*8 +: 8] <= mem_array[rbase + rb[7:0]];
                    end
                    mem_data_valid <= 1'b1;
                    mem_resp_addr  <= saved_addr;   // NEW: tag the response with its address

                    // synthesis translate_off
                    $display("[MEM] T=%0t | READ  addr=0x%02h latency=%0d",
                        $time, saved_addr, MEM_LATENCY);
                    // synthesis translate_on

                    mem_fsm <= MEM_IDLE;
                end

                MEM_WRITE: begin
                    // Unpack 8-byte block into byte array
                    begin : wb_block
                        integer wb;
                        reg [7:0] wbase;
                        wbase = {saved_addr[7:3], 3'b000};
                        for (wb = 0; wb < 8; wb = wb + 1)
                            mem_array[wbase + wb[7:0]] <= saved_wdata[wb*8 +: 8];
                    end
                    mem_wb_ack <= 1'b1;

                    // synthesis translate_off
                    $display("[MEM] T=%0t | WRITE addr=0x%02h data=0x%h",
                        $time, saved_addr, saved_wdata);
                    // synthesis translate_on

                    mem_fsm <= MEM_IDLE;
                end

                default: mem_fsm <= MEM_IDLE;

            endcase
        end
    end

endmodule
