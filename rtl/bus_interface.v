// ============================================================
// Module : bus_interface
// Purpose: Shared snooping bus for 2-core MESI system.
//          4-phase: IDLE → ADDRESS → SNOOP → DATA
//          Samples granted controller signals in IDLE.
//          Broadcasts to all caches. Routes data from memory
//          or supplying cache to requesting cache.
// ============================================================

module bus_interface (
    input  wire        clk,
    input  wire        rst,

    // From arbiter (one-hot)
    input  wire [1:0]  bus_grant,

    // From controllers
    input  wire [1:0]  ctrl_bus_req,
    // Core 0
    input  wire [7:0]  ctrl_bus_addr_0,
    input  wire [2:0]  ctrl_bus_cmd_0,
    input  wire [63:0] ctrl_bus_wdata_0,
    input  wire        ctrl_data_valid_0,
    input  wire        ctrl_bus_shared_0,
    // Core 1
    input  wire [7:0]  ctrl_bus_addr_1,
    input  wire [2:0]  ctrl_bus_cmd_1,
    input  wire [63:0] ctrl_bus_wdata_1,
    input  wire        ctrl_data_valid_1,
    input  wire        ctrl_bus_shared_1,

    // Broadcast outputs (go to every controller)
    output reg  [7:0]  snoop_addr,
    output reg  [2:0]  snoop_cmd,
    output reg         snoop_valid,
    output reg  [63:0] snoop_data,
    output reg         snoop_data_ready,
    output wire        any_shared,

    // Memory interface
    input  wire [63:0] mem_data,
    input  wire        mem_data_valid,
    output reg  [7:0]  mem_addr,
    output reg  [2:0]  mem_cmd,
    output reg  [63:0] mem_wdata,
    output reg         mem_req,

    // Phase (to arbiter)
    output reg  [1:0]  bus_phase,
    output reg         active_core
);

    localparam CMD_IDLE    = 3'b000;
    localparam CMD_BUSRD   = 3'b001;
    localparam CMD_BUSRDX  = 3'b010;
    localparam CMD_BUSUPGR = 3'b011;
    localparam CMD_BUSWB   = 3'b100;

    localparam PHASE_IDLE    = 2'b00;
    localparam PHASE_ADDRESS = 2'b01;
    localparam PHASE_SNOOP   = 2'b10;
    localparam PHASE_DATA    = 2'b11;

    reg [7:0]  active_addr;
    reg [2:0]  active_cmd;
    reg [63:0] active_wdata;
    reg        snoop_cnt;     // 1-bit counter for 2-cycle snoop window

    assign any_shared = ctrl_bus_shared_0 | ctrl_bus_shared_1;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bus_phase        <= PHASE_IDLE;
            snoop_addr       <= 8'b0;
            snoop_cmd        <= CMD_IDLE;
            snoop_valid      <= 1'b0;
            snoop_data       <= 64'b0;
            snoop_data_ready <= 1'b0;
            mem_addr         <= 8'b0;
            mem_cmd          <= CMD_IDLE;
            mem_wdata        <= 64'b0;
            mem_req          <= 1'b0;
            active_addr      <= 8'b0;
            active_cmd       <= CMD_IDLE;
            active_wdata     <= 64'b0;
            active_core      <= 1'b0;
            snoop_cnt        <= 1'b0;
        end
        else begin
            // Clear pulses
            snoop_data_ready <= 1'b0;
            mem_req          <= 1'b0;

            case (bus_phase)

                // ─── IDLE ──────────────────────────────────────
                // Wait for grant. When granted, latch the CURRENT
                // bus signals from that controller immediately.
                // ───────────────────────────────────────────────
                PHASE_IDLE: begin
                    snoop_valid <= 1'b0;
                    snoop_cmd   <= CMD_IDLE;

                    if (bus_grant[0]) begin
                        active_core  <= 1'b0;
                        active_addr  <= ctrl_bus_addr_0;
                        active_cmd   <= ctrl_bus_cmd_0;
                        active_wdata <= ctrl_bus_wdata_0;
                        bus_phase    <= PHASE_ADDRESS;
                    end
                    else if (bus_grant[1]) begin
                        active_core  <= 1'b1;
                        active_addr  <= ctrl_bus_addr_1;
                        active_cmd   <= ctrl_bus_cmd_1;
                        active_wdata <= ctrl_bus_wdata_1;
                        bus_phase    <= PHASE_ADDRESS;
                    end
                end

                // ─── ADDRESS ───────────────────────────────────
                // Broadcast address + command to all caches.
                // Send request to memory.
                // ───────────────────────────────────────────────
                PHASE_ADDRESS: begin
                    snoop_addr  <= active_addr;
                    snoop_cmd   <= active_cmd;
                    snoop_valid <= 1'b1;
                    // Forward to memory
                    mem_addr  <= active_addr;
                    mem_cmd   <= active_cmd;
                    mem_wdata <= active_wdata;
                    mem_req   <= 1'b1;
                    snoop_cnt <= 1'b0;
                    bus_phase <= PHASE_SNOOP;

                    // synthesis translate_off
                    $display("[BUS] T=%0t | Core%0b | %s | ADDR=0x%02h",
                        $time, bus_grant[1],
                        (active_cmd==CMD_BUSRD )?"BusRd  ":
                        (active_cmd==CMD_BUSRDX)?"BusRdX ":
                        (active_cmd==CMD_BUSUPGR)?"BusUpgr":
                        (active_cmd==CMD_BUSWB )?"BusWB  ":"IDLE   ",
                        active_addr);
                    // synthesis translate_on
                end

                // ─── SNOOP ─────────────────────────────────────
                // Hold broadcast for 2 cycles so caches can do
                // tag lookup and react (assert bus_shared, etc.)
                // ───────────────────────────────────────────────
                PHASE_SNOOP: begin
                    snoop_valid <= 1'b1;
                    if (snoop_cnt == 1'b1)
                        bus_phase <= PHASE_DATA;
                    snoop_cnt <= ~snoop_cnt;
                end

                // ─── DATA ──────────────────────────────────────
                // Route data to requesting cache.
                // Priority: cache-to-cache > memory
                // No data phase for BusWB or BusUpgr.
                // ───────────────────────────────────────────────
                PHASE_DATA: begin
                    snoop_valid <= 1'b0;

                    if (active_cmd == CMD_BUSWB || active_cmd == CMD_BUSUPGR) begin
                        // No data to deliver back
                        bus_phase <= PHASE_IDLE;
                    end
                    else begin
                        // Cache-to-cache: other cache supplies data
                        if (ctrl_data_valid_0 && active_core == 1'b1) begin
                            snoop_data       <= ctrl_bus_wdata_0;
                            snoop_data_ready <= 1'b1;
                            bus_phase        <= PHASE_IDLE;
                            // synthesis translate_off
                            $display("[BUS] T=%0t | Cache-to-Cache from Core0 data=0x%h", $time, ctrl_bus_wdata_0);
                            // synthesis translate_on
                        end
                        else if (ctrl_data_valid_1 && active_core == 1'b0) begin
                            snoop_data       <= ctrl_bus_wdata_1;
                            snoop_data_ready <= 1'b1;
                            bus_phase        <= PHASE_IDLE;
                            // synthesis translate_off
                            $display("[BUS] T=%0t | Cache-to-Cache from Core1 data=0x%h", $time, ctrl_bus_wdata_1);
                            // synthesis translate_on
                        end
                        else if (mem_data_valid) begin
                            snoop_data       <= mem_data;
                            snoop_data_ready <= 1'b1;
                            bus_phase        <= PHASE_IDLE;
                            // synthesis translate_off
                            $display("[BUS] T=%0t | Memory data=0x%h supplied", $time, mem_data);
                            // synthesis translate_on
                        end
                        // else: stay, waiting for data
                    end
                end

            endcase
        end
    end

endmodule
