// ============================================================
// Module : top
// Purpose: Integrates all MESI coherence modules.
//          2-core system. Purely structural — no logic.
// ============================================================

module top (
    input  wire       clk,
    input  wire       rst,
    input  wire       pr0_req, pr0_we,
    input  wire [7:0] pr0_addr, pr0_wdata,
    output wire       pr0_ack,
    output wire [7:0] pr0_rdata,
    input  wire       pr1_req, pr1_we,
    input  wire [7:0] pr1_addr, pr1_wdata,
    output wire       pr1_ack,
    output wire [7:0] pr1_rdata,
    output wire [1:0] dbg_bus_phase,
    output wire [1:0] dbg_bus_grant,
    output wire [7:0] dbg_snoop_addr,
    output wire [2:0] dbg_snoop_cmd,
    output wire       dbg_any_shared
);

    // ── Cache array wires — core 0 ───────────────────────────
    wire [7:0]  ca0_lk_addr;
    wire        ca0_hit; wire [1:0] ca0_hit_mesi;
    wire        ca0_hit_way; wire [63:0] ca0_hit_data;
    wire        ca0_lru_way;
    wire        ca0_wr_en; wire [7:0] ca0_wr_addr;
    wire        ca0_wr_way; wire [1:0] ca0_wr_mesi;
    wire [63:0] ca0_wr_data;
    wire [1:0]  ca0_ev_set; wire ca0_ev_way;
    wire [1:0]  ca0_ev_mesi; wire [7:0] ca0_ev_addr;
    wire [63:0] ca0_ev_data;

    // dedicated snoop-lookup port wires — core 0
    wire [7:0]  ca0_snoop_lk_addr;
    wire        ca0_snoop_hit; wire [1:0] ca0_snoop_hit_mesi;
    wire        ca0_snoop_hit_way; wire [63:0] ca0_snoop_hit_data;

    // NEW: free-way indicator wires — core 0
    wire        ca0_way0_free, ca0_way1_free;

    // ── Cache array wires — core 1 ───────────────────────────
    wire [7:0]  ca1_lk_addr;
    wire        ca1_hit; wire [1:0] ca1_hit_mesi;
    wire        ca1_hit_way; wire [63:0] ca1_hit_data;
    wire        ca1_lru_way;
    wire        ca1_wr_en; wire [7:0] ca1_wr_addr;
    wire        ca1_wr_way; wire [1:0] ca1_wr_mesi;
    wire [63:0] ca1_wr_data;
    wire [1:0]  ca1_ev_set; wire ca1_ev_way;
    wire [1:0]  ca1_ev_mesi; wire [7:0] ca1_ev_addr;
    wire [63:0] ca1_ev_data;

    // dedicated snoop-lookup port wires — core 1
    wire [7:0]  ca1_snoop_lk_addr;
    wire        ca1_snoop_hit; wire [1:0] ca1_snoop_hit_mesi;
    wire        ca1_snoop_hit_way; wire [63:0] ca1_snoop_hit_data;

    // NEW: free-way indicator wires — core 1
    wire        ca1_way0_free, ca1_way1_free;

    // ── Bus wires ─────────────────────────────────────────────
    wire [1:0]  ctrl_bus_req;
    wire [7:0]  ctrl_addr_0,  ctrl_addr_1;
    wire [2:0]  ctrl_cmd_0,   ctrl_cmd_1;
    wire [63:0] ctrl_wdata_0, ctrl_wdata_1;
    wire        ctrl_dv_0,    ctrl_dv_1;
    wire        ctrl_sh_0,    ctrl_sh_1;

    wire [7:0]  snoop_addr; wire [2:0] snoop_cmd;
    wire        snoop_valid; wire [63:0] snoop_data;
    wire        snoop_data_ready, any_shared;

    wire [1:0]  bus_grant, bus_phase;

    // ── Memory wires ──────────────────────────────────────────
    wire [7:0]  mem_addr; wire [2:0] mem_cmd;
    wire [63:0] mem_wdata; wire mem_req;
    wire [63:0] mem_data; wire mem_data_valid, mem_wb_ack;
    // address tag returned by memory alongside mem_data_valid, so
    // bus_interface can verify a response belongs to its active request
    // before accepting it (fixes the request/response mismatch bug).
    wire [7:0]  mem_resp_addr;

    // ── Instances ─────────────────────────────────────────────

    cache_array u_cache0 (
        .clk(clk),.rst(rst),
        .lookup_addr(ca0_lk_addr),
        .hit(ca0_hit),.hit_mesi(ca0_hit_mesi),
        .hit_way(ca0_hit_way),.hit_data(ca0_hit_data),
        .lru_way_out(ca0_lru_way),
        // NEW: free-way indicators
        .way0_free(ca0_way0_free),.way1_free(ca0_way1_free),
        // dedicated snoop-lookup port
        .snoop_lookup_addr(ca0_snoop_lk_addr),
        .snoop_hit(ca0_snoop_hit),.snoop_hit_mesi(ca0_snoop_hit_mesi),
        .snoop_hit_way(ca0_snoop_hit_way),.snoop_hit_data(ca0_snoop_hit_data),
        .write_en(ca0_wr_en),.write_addr(ca0_wr_addr),
        .write_way(ca0_wr_way),.write_mesi(ca0_wr_mesi),
        .write_data(ca0_wr_data),
        .evict_set(ca0_ev_set),.evict_way(ca0_ev_way),
        .evict_mesi(ca0_ev_mesi),.evict_addr_out(ca0_ev_addr),
        .evict_data(ca0_ev_data));

    mesi_controller #(.CORE_ID(0)) u_ctrl0 (
        .clk(clk),.rst(rst),
        .pr_req(pr0_req),.pr_we(pr0_we),
        .pr_addr(pr0_addr),.pr_wdata(pr0_wdata),
        .pr_ack(pr0_ack),.pr_rdata(pr0_rdata),
        .bus_req(ctrl_bus_req[0]),.bus_grant(bus_grant[0]),
        .bus_addr(ctrl_addr_0),.bus_cmd(ctrl_cmd_0),
        .bus_wdata(ctrl_wdata_0),.bus_data_valid(ctrl_dv_0),
        .bus_shared(ctrl_sh_0),
        .snoop_addr(snoop_addr),.snoop_cmd(snoop_cmd),
        .snoop_valid(snoop_valid),.snoop_data(snoop_data),
        .snoop_data_ready(snoop_data_ready),.any_shared(any_shared),
        .ca_lookup_addr(ca0_lk_addr),
        .ca_hit(ca0_hit),.ca_hit_mesi(ca0_hit_mesi),
        .ca_hit_way(ca0_hit_way),.ca_hit_data(ca0_hit_data),
        .ca_lru_way(ca0_lru_way),
        // NEW: free-way indicators
        .way0_free(ca0_way0_free),.way1_free(ca0_way1_free),
        // dedicated snoop-lookup port
        .ca_snoop_lookup_addr(ca0_snoop_lk_addr),
        .ca_snoop_hit(ca0_snoop_hit),.ca_snoop_hit_mesi(ca0_snoop_hit_mesi),
        .ca_snoop_hit_way(ca0_snoop_hit_way),.ca_snoop_hit_data(ca0_snoop_hit_data),
        .ca_write_en(ca0_wr_en),.ca_write_addr(ca0_wr_addr),
        .ca_write_way(ca0_wr_way),.ca_write_mesi(ca0_wr_mesi),
        .ca_write_data(ca0_wr_data),
        .ca_evict_set(ca0_ev_set),.ca_evict_way(ca0_ev_way),
        .ca_evict_mesi(ca0_ev_mesi),.ca_evict_addr(ca0_ev_addr),
        .ca_evict_data(ca0_ev_data));

    cache_array u_cache1 (
        .clk(clk),.rst(rst),
        .lookup_addr(ca1_lk_addr),
        .hit(ca1_hit),.hit_mesi(ca1_hit_mesi),
        .hit_way(ca1_hit_way),.hit_data(ca1_hit_data),
        .lru_way_out(ca1_lru_way),
        // NEW: free-way indicators
        .way0_free(ca1_way0_free),.way1_free(ca1_way1_free),
        // dedicated snoop-lookup port
        .snoop_lookup_addr(ca1_snoop_lk_addr),
        .snoop_hit(ca1_snoop_hit),.snoop_hit_mesi(ca1_snoop_hit_mesi),
        .snoop_hit_way(ca1_snoop_hit_way),.snoop_hit_data(ca1_snoop_hit_data),
        .write_en(ca1_wr_en),.write_addr(ca1_wr_addr),
        .write_way(ca1_wr_way),.write_mesi(ca1_wr_mesi),
        .write_data(ca1_wr_data),
        .evict_set(ca1_ev_set),.evict_way(ca1_ev_way),
        .evict_mesi(ca1_ev_mesi),.evict_addr_out(ca1_ev_addr),
        .evict_data(ca1_ev_data));

    mesi_controller #(.CORE_ID(1)) u_ctrl1 (
        .clk(clk),.rst(rst),
        .pr_req(pr1_req),.pr_we(pr1_we),
        .pr_addr(pr1_addr),.pr_wdata(pr1_wdata),
        .pr_ack(pr1_ack),.pr_rdata(pr1_rdata),
        .bus_req(ctrl_bus_req[1]),.bus_grant(bus_grant[1]),
        .bus_addr(ctrl_addr_1),.bus_cmd(ctrl_cmd_1),
        .bus_wdata(ctrl_wdata_1),.bus_data_valid(ctrl_dv_1),
        .bus_shared(ctrl_sh_1),
        .snoop_addr(snoop_addr),.snoop_cmd(snoop_cmd),
        .snoop_valid(snoop_valid),.snoop_data(snoop_data),
        .snoop_data_ready(snoop_data_ready),.any_shared(any_shared),
        .ca_lookup_addr(ca1_lk_addr),
        .ca_hit(ca1_hit),.ca_hit_mesi(ca1_hit_mesi),
        .ca_hit_way(ca1_hit_way),.ca_hit_data(ca1_hit_data),
        .ca_lru_way(ca1_lru_way),
        // NEW: free-way indicators
        .way0_free(ca1_way0_free),.way1_free(ca1_way1_free),
        // dedicated snoop-lookup port
        .ca_snoop_lookup_addr(ca1_snoop_lk_addr),
        .ca_snoop_hit(ca1_snoop_hit),.ca_snoop_hit_mesi(ca1_snoop_hit_mesi),
        .ca_snoop_hit_way(ca1_snoop_hit_way),.ca_snoop_hit_data(ca1_snoop_hit_data),
        .ca_write_en(ca1_wr_en),.ca_write_addr(ca1_wr_addr),
        .ca_write_way(ca1_wr_way),.ca_write_mesi(ca1_wr_mesi),
        .ca_write_data(ca1_wr_data),
        .ca_evict_set(ca1_ev_set),.ca_evict_way(ca1_ev_way),
        .ca_evict_mesi(ca1_ev_mesi),.ca_evict_addr(ca1_ev_addr),
        .ca_evict_data(ca1_ev_data));

    bus_interface u_bus (
        .clk(clk),.rst(rst),
        .bus_grant(bus_grant),
        .ctrl_bus_req(ctrl_bus_req),
        .ctrl_bus_addr_0(ctrl_addr_0),.ctrl_bus_cmd_0(ctrl_cmd_0),
        .ctrl_bus_wdata_0(ctrl_wdata_0),.ctrl_data_valid_0(ctrl_dv_0),
        .ctrl_bus_shared_0(ctrl_sh_0),
        .ctrl_bus_addr_1(ctrl_addr_1),.ctrl_bus_cmd_1(ctrl_cmd_1),
        .ctrl_bus_wdata_1(ctrl_wdata_1),.ctrl_data_valid_1(ctrl_dv_1),
        .ctrl_bus_shared_1(ctrl_sh_1),
        .snoop_addr(snoop_addr),.snoop_cmd(snoop_cmd),
        .snoop_valid(snoop_valid),.snoop_data(snoop_data),
        .snoop_data_ready(snoop_data_ready),.any_shared(any_shared),
        .mem_data(mem_data),.mem_data_valid(mem_data_valid),
        // wire in memory's response address tag
        .mem_resp_addr(mem_resp_addr),
        .mem_addr(mem_addr),.mem_cmd(mem_cmd),
        .mem_wdata(mem_wdata),.mem_req(mem_req),
        .bus_phase(bus_phase),.active_core());

    bus_arbiter u_arbiter (
        .clk(clk),.rst(rst),
        .bus_req(ctrl_bus_req),
        .bus_phase(bus_phase),
        .bus_grant(bus_grant));

    memory_controller #(.MEM_LATENCY(10)) u_memory (
        .clk(clk),.rst(rst),
        .mem_addr(mem_addr),.mem_cmd(mem_cmd),
        .mem_wdata(mem_wdata),.mem_req(mem_req),
        .mem_data(mem_data),.mem_data_valid(mem_data_valid),
        .mem_wb_ack(mem_wb_ack),
        // drive the response address tag out to bus_interface
        .mem_resp_addr(mem_resp_addr));

    assign dbg_bus_phase  = bus_phase;
    assign dbg_bus_grant  = bus_grant;
    assign dbg_snoop_addr = snoop_addr;
    assign dbg_snoop_cmd  = snoop_cmd;
    assign dbg_any_shared = any_shared;

endmodule
