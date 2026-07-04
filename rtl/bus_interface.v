// ============================================================
// Module : bus_interface  (fixed — CMD_IDLE guard + any_shared latch)
// 4-phase snooping bus: IDLE → ADDRESS → SNOOP → DATA
// ============================================================
`timescale 1ns/1ps
module bus_interface (
    input  wire        clk,
    input  wire        rst,

    // From arbiter
    input  wire [1:0]  bus_grant,

    // From controllers
    input  wire [1:0]  ctrl_bus_req,
    input  wire [7:0]  ctrl_bus_addr_0,
    input  wire [2:0]  ctrl_bus_cmd_0,
    input  wire [63:0] ctrl_bus_wdata_0,
    input  wire        ctrl_data_valid_0,
    input  wire        ctrl_bus_shared_0,
    input  wire [7:0]  ctrl_bus_addr_1,
    input  wire [2:0]  ctrl_bus_cmd_1,
    input  wire [63:0] ctrl_bus_wdata_1,
    input  wire        ctrl_data_valid_1,
    input  wire        ctrl_bus_shared_1,

    // Broadcast to all controllers
    output reg  [7:0]  snoop_addr,
    output reg  [2:0]  snoop_cmd,
    output reg         snoop_valid,
    output reg  [63:0] snoop_data,
    output reg         snoop_data_ready,

    // Sticky any_shared — set during SNOOP phase, held until next ADDRESS
    output reg         any_shared,

    // Memory interface
    input  wire [63:0] mem_data,
    input  wire        mem_data_valid,
    output reg  [7:0]  mem_addr,
    output reg  [2:0]  mem_cmd,
    output reg  [63:0] mem_wdata,
    output reg         mem_req,

    // Phase output (to arbiter + debug)
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
    reg        snoop_cnt;
    reg        c2c_valid;
    reg [63:0] c2c_data;

    // Live any_shared (combinational)
    wire any_shared_live = ctrl_bus_shared_0 | ctrl_bus_shared_1;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bus_phase        <= PHASE_IDLE;
            snoop_addr       <= 8'b0;
            snoop_cmd        <= CMD_IDLE;
            snoop_valid      <= 1'b0;
            snoop_data       <= 64'b0;
            snoop_data_ready <= 1'b0;
            any_shared       <= 1'b0;
            mem_addr         <= 8'b0;
            mem_cmd          <= CMD_IDLE;
            mem_wdata        <= 64'b0;
            mem_req          <= 1'b0;
            active_addr      <= 8'b0;
            active_cmd       <= CMD_IDLE;
            active_wdata     <= 64'b0;
            active_core      <= 1'b0;
            snoop_cnt        <= 1'b0;
            c2c_valid        <= 1'b0;
            c2c_data         <= 64'b0;
        end
        else begin
            // Pulse signals — clear each cycle by default
            snoop_data_ready <= 1'b0;
            mem_req          <= 1'b0;

            case (bus_phase)

                // ─────────────────────────────────────────────
                // IDLE: wait for a grant, latch transaction info
                // ─────────────────────────────────────────────
                PHASE_IDLE: begin
                    snoop_valid <= 1'b0;
                    snoop_cmd   <= CMD_IDLE;
                    c2c_valid   <= 1'b0;
                    // any_shared is NOT cleared here — cleared in
                    // PHASE_ADDRESS so it persists long enough for
                    // the controller to sample it after snoop_data_ready

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

                // ─────────────────────────────────────────────
                // ADDRESS: broadcast cmd+addr, send mem request
                // KEY FIX: if CMD_IDLE, abort immediately — this
                // prevents the bus hanging in PHASE_DATA with no
                // data source (spurious grant after transaction)
                // ─────────────────────────────────────────────
                PHASE_ADDRESS: begin
                    // Clear sticky any_shared for the new transaction
                    any_shared <= 1'b0;

                    if (active_cmd == CMD_IDLE) begin
                        // Spurious grant with no real command — abort
                        bus_phase <= PHASE_IDLE;
                    end
                    else begin
                        snoop_addr  <= active_addr;
                        snoop_cmd   <= active_cmd;
                        snoop_valid <= 1'b1;
                        mem_addr    <= active_addr;
                        mem_cmd     <= active_cmd;
                        mem_wdata   <= active_wdata;
                        mem_req     <= 1'b1;
                        snoop_cnt   <= 1'b0;
                        bus_phase   <= PHASE_SNOOP;
                        $display("[BUS] T=%0t | Core%0b | %s | ADDR=0x%02h",
                            $time, active_core,
                            (active_cmd==CMD_BUSRD )?"BusRd  ":
                            (active_cmd==CMD_BUSRDX)?"BusRdX ":
                            (active_cmd==CMD_BUSUPGR)?"BusUpgr":
                            (active_cmd==CMD_BUSWB )?"BusWB  ":"???    ",
                            active_addr);
                    end
                end

                // ─────────────────────────────────────────────
                // SNOOP: 2-cycle window for caches to react
                // Capture c2c transfer + latch any_shared
                // ─────────────────────────────────────────────
                PHASE_SNOOP: begin
                    snoop_valid <= 1'b1;

                    // Latch any_shared while it is asserted by snooping caches
                    if (any_shared_live) any_shared <= 1'b1;

                    // Capture cache-to-cache data
                    if (!c2c_valid) begin
                        if (active_core == 1'b1 && ctrl_data_valid_0) begin
                            c2c_data  <= ctrl_bus_wdata_0;
                            c2c_valid <= 1'b1;
                        end
                        else if (active_core == 1'b0 && ctrl_data_valid_1) begin
                            c2c_data  <= ctrl_bus_wdata_1;
                            c2c_valid <= 1'b1;
                        end
                    end

                    if (snoop_cnt == 1'b1)
                        bus_phase <= PHASE_DATA;
                    snoop_cnt <= ~snoop_cnt;
                end

                // ─────────────────────────────────────────────
                // DATA: deliver data to requesting cache
                // Priority: c2c > direct ctrl_data_valid > memory
                // BusWB and BusUpgr need no data delivery
                // ─────────────────────────────────────────────
                PHASE_DATA: begin
    snoop_valid <= 1'b0;

    if (active_cmd == CMD_BUSWB || active_cmd == CMD_BUSUPGR) begin
        bus_phase <= PHASE_IDLE;
    end
    else if (c2c_valid) begin
        // Cache-to-cache transfer (captured during SNOOP)
        snoop_data       <= c2c_data;
        snoop_data_ready <= 1'b1;
        bus_phase        <= PHASE_IDLE;
        // Also write dirty data back to memory (Modified Intervention)
        mem_addr  <= active_addr;
        mem_cmd   <= 3'b100; // CMD_BUSWB
        mem_wdata <= c2c_data;
        mem_req   <= 1'b1;
        $display("[BUS] T=%0t | C2C data=0x%h delivered + memory writeback", $time, c2c_data);
    end
    else if (ctrl_data_valid_0 && active_core == 1'b1) begin
        // Late c2c from core 0
        snoop_data       <= ctrl_bus_wdata_0;
        snoop_data_ready <= 1'b1;
        bus_phase        <= PHASE_IDLE;
        // Also write dirty data back to memory (Modified Intervention)
        mem_addr  <= active_addr;
        mem_cmd   <= 3'b100; // CMD_BUSWB
        mem_wdata <= ctrl_bus_wdata_0;
        mem_req   <= 1'b1;
        $display("[BUS] T=%0t | C2C Core0->Core1 data=0x%h delivered + memory writeback", $time, ctrl_bus_wdata_0);
    end
    else if (ctrl_data_valid_1 && active_core == 1'b0) begin
        // Late c2c from core 1
        snoop_data       <= ctrl_bus_wdata_1;
        snoop_data_ready <= 1'b1;
        bus_phase        <= PHASE_IDLE;
        // Also write dirty data back to memory (Modified Intervention)
        mem_addr  <= active_addr;
        mem_cmd   <= 3'b100; // CMD_BUSWB
        mem_wdata <= ctrl_bus_wdata_1;
        mem_req   <= 1'b1;
        $display("[BUS] T=%0t | C2C Core1->Core0 data=0x%h delivered + memory writeback", $time, ctrl_bus_wdata_1);
    end
    else if (mem_data_valid) begin
        // Memory response
        snoop_data       <= mem_data;
        snoop_data_ready <= 1'b1;
        bus_phase        <= PHASE_IDLE;
        $display("[BUS] T=%0t | Memory data=0x%h supplied", $time, mem_data);
    end
            // else: stay in PHASE_DATA waiting
                end

            endcase
        end
    end

endmodule
