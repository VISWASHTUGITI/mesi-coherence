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
    output reg         mem_wb_ack
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
            saved_addr     <= 8'b0;
            saved_cmd      <= CMD_IDLE;
            saved_wdata    <= 64'b0;
            lat_count      <= 4'b0;
        end
        else begin
            mem_data_valid <= 1'b0;
            mem_wb_ack     <= 1'b0;

            case (mem_fsm)

                MEM_IDLE: begin
                    // mem_req is a 1-cycle pulse — latch on rising edge
                    if (mem_req && (mem_cmd == CMD_BUSRD  ||
                                   mem_cmd == CMD_BUSRDX ||
                                   mem_cmd == CMD_BUSWB)) begin
                        saved_addr  <= mem_addr;
                        saved_cmd   <= mem_cmd;
                        saved_wdata <= mem_wdata;
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
