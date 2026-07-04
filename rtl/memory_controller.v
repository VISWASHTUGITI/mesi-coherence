// ============================================================
// Module : memory_controller
// Purpose: Models main memory with configurable latency.
//          Responds to BusRd/BusRdX with block data after
//          MEM_LATENCY cycles. Absorbs BusWB writebacks.
//          256 bytes, byte-addressable, 8-byte line fill.
// ============================================================

module memory_controller #(
    parameter MEM_LATENCY = 10
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

    // Writeback override: capture BusWB even when memory is busy
    reg        wb_pending;
    reg [7:0]  wb_addr;
    reg [63:0] wb_data;

    // NEW: Read override — capture BusRd/BusRdX even when memory is busy.
    // Mirrors wb_pending below so a read request can never be silently
    // dropped if mem_req pulses while mem_fsm is not in MEM_IDLE.
    reg        rd_pending;
    reg [7:0]  rd_addr;
    reg [2:0]  rd_cmd;

    integer b, base_addr;

    integer init_i;
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
            wb_pending     <= 1'b0;
            wb_addr        <= 8'b0;
            wb_data        <= 64'b0;
            rd_pending     <= 1'b0;   // NEW
            rd_addr        <= 8'b0;   // NEW
            rd_cmd         <= CMD_IDLE; // NEW
        end
        else begin
            mem_data_valid <= 1'b0;
            mem_wb_ack     <= 1'b0;

            // Always capture a BusWB request — even if memory is busy
            // This handles the Modified Intervention case where the c2c
            // writeback arrives while memory is still processing a BusRd
            if (mem_req && mem_cmd == CMD_BUSWB) begin
                wb_pending <= 1'b1;
                wb_addr    <= mem_addr;
                wb_data    <= mem_wdata;
            end
            // NEW: Always capture a BusRd/BusRdX request — even if memory
            // is busy. Same reasoning as the BusWB capture above: mem_req
            // is a 1-cycle pulse, and without this, a read arriving while
            // mem_fsm is not in MEM_IDLE would be silently dropped.
            else if (mem_req && (mem_cmd == CMD_BUSRD || mem_cmd == CMD_BUSRDX)) begin
                rd_pending <= 1'b1;
                rd_addr    <= mem_addr;
                rd_cmd     <= mem_cmd;
            end

            case (mem_fsm)

                MEM_IDLE: begin
                    if (wb_pending) begin
                        // Process pending writeback from c2c intervention
                        saved_addr  <= wb_addr;
                        saved_cmd   <= CMD_BUSWB;
                        saved_wdata <= wb_data;
                        wb_pending  <= 1'b0;
                        mem_fsm     <= MEM_WRITE;
                    end
                    // NEW: Process pending read captured by rd_pending above.
                    // This replaces the old direct "mem_req is a 1-cycle
                    // pulse — latch on rising edge" check, since rd_pending
                    // already latched the request unconditionally and can't
                    // be missed regardless of what mem_fsm was doing when
                    // the pulse arrived.
                    else if (rd_pending) begin
                        saved_addr  <= rd_addr;
                        saved_cmd   <= rd_cmd;
                        rd_pending  <= 1'b0;
                        lat_count   <= 4'b0;
                        mem_fsm     <= MEM_DECODE;
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
