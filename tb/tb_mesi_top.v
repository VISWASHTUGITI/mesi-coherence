// ============================================================
// Module : tb_mesi_top
// Purpose: Full testbench for MESI coherence system.
//          Tests 7 scenarios with automated PASS/FAIL checking.
//
// Scenarios:
//   1. Cold Miss (I → E)
//   2. Read Hit (E → E)
//   3. Shared Read (E → S)
//   4. Write Invalidation (S → M, other → I)
//   5. Write Hit (M → M, silent)
//   6. Modified Intervention (M → S)
//   7. False Sharing (ping-pong)
// ============================================================

`timescale 1ns/1ps

module tb_mesi_top;

    // ── DUT signals ───────────────────────────────────────────
    reg        clk, rst;
    reg        pr0_req, pr0_we;
    reg  [7:0] pr0_addr, pr0_wdata;
    wire       pr0_ack;
    wire [7:0] pr0_rdata;

    reg        pr1_req, pr1_we;
    reg  [7:0] pr1_addr, pr1_wdata;
    wire       pr1_ack;
    wire [7:0] pr1_rdata;

    wire [1:0] dbg_bus_phase;
    wire [1:0] dbg_bus_grant;
    wire [7:0] dbg_snoop_addr;
    wire [2:0] dbg_snoop_cmd;
    wire       dbg_any_shared;

    // ── Instantiate DUT ───────────────────────────────────────
    top dut (
        .clk          (clk),
        .rst          (rst),
        .pr0_req      (pr0_req),
        .pr0_we       (pr0_we),
        .pr0_addr     (pr0_addr),
        .pr0_wdata    (pr0_wdata),
        .pr0_ack      (pr0_ack),
        .pr0_rdata    (pr0_rdata),
        .pr1_req      (pr1_req),
        .pr1_we       (pr1_we),
        .pr1_addr     (pr1_addr),
        .pr1_wdata    (pr1_wdata),
        .pr1_ack      (pr1_ack),
        .pr1_rdata    (pr1_rdata),
        .dbg_bus_phase(dbg_bus_phase),
        .dbg_bus_grant(dbg_bus_grant),
        .dbg_snoop_addr(dbg_snoop_addr),
        .dbg_snoop_cmd (dbg_snoop_cmd),
        .dbg_any_shared(dbg_any_shared)
    );

    // ── MESI state encoding for readability ───────────────────
    localparam INVALID   = 2'b00;
    localparam SHARED    = 2'b01;
    localparam EXCLUSIVE = 2'b10;
    localparam MODIFIED  = 2'b11;

    // ── Stats counters ────────────────────────────────────────
    integer total_tests, pass_count, fail_count;
    integer hit_count, miss_count;
    integer cycle_count;

    // ── Clock: 10ns period ────────────────────────────────────
    initial clk = 0;
    always #5 clk = ~clk;

    // ── Cycle counter ─────────────────────────────────────────
    always @(posedge clk) cycle_count = cycle_count + 1;

    // ── Waveform dump ─────────────────────────────────────────
    initial begin
        $dumpfile("mesi_sim.vcd");
        $dumpvars(0, tb_mesi_top);
    end

    // =========================================================
    // TASKS
    // =========================================================

    // Task: issue a read from core 0, wait for ack
    task core0_read;
        input [7:0] addr;
        output [7:0] rdata;
        integer timeout;
        begin
            @(negedge clk);
            pr0_req  = 1'b1;
            pr0_we   = 1'b0;
            pr0_addr = addr;
            pr0_wdata= 8'b0;
            timeout  = 0;
            @(posedge clk);
            while (!pr0_ack && timeout < 200) begin
                @(posedge clk);
                timeout = timeout + 1;
            end
            rdata   = pr0_rdata;
            pr0_req = 1'b0;
            @(negedge clk);
            if (timeout >= 200)
                $display("  [TIMEOUT] core0_read addr=0x%02h", addr);
        end
    endtask

    // Task: issue a write from core 0, wait for ack
    task core0_write;
        input [7:0] addr;
        input [7:0] wdata;
        integer timeout;
        begin
            @(negedge clk);
            pr0_req   = 1'b1;
            pr0_we    = 1'b1;
            pr0_addr  = addr;
            pr0_wdata = wdata;
            timeout   = 0;
            @(posedge clk);
            while (!pr0_ack && timeout < 200) begin
                @(posedge clk);
                timeout = timeout + 1;
            end
            pr0_req = 1'b0;
            pr0_we  = 1'b0;
            @(negedge clk);
            if (timeout >= 200)
                $display("  [TIMEOUT] core0_write addr=0x%02h", addr);
        end
    endtask

    // Task: issue a read from core 1, wait for ack
    task core1_read;
        input [7:0] addr;
        output [7:0] rdata;
        integer timeout;
        begin
            @(negedge clk);
            pr1_req  = 1'b1;
            pr1_we   = 1'b0;
            pr1_addr = addr;
            pr1_wdata= 8'b0;
            timeout  = 0;
            @(posedge clk);
            while (!pr1_ack && timeout < 200) begin
                @(posedge clk);
                timeout = timeout + 1;
            end
            rdata   = pr1_rdata;
            pr1_req = 1'b0;
            @(negedge clk);
            if (timeout >= 200)
                $display("  [TIMEOUT] core1_read addr=0x%02h", addr);
        end
    endtask

    // Task: issue a write from core 1, wait for ack
    task core1_write;
        input [7:0] addr;
        input [7:0] wdata;
        integer timeout;
        begin
            @(negedge clk);
            pr1_req   = 1'b1;
            pr1_we    = 1'b1;
            pr1_addr  = addr;
            pr1_wdata = wdata;
            timeout   = 0;
            @(posedge clk);
            while (!pr1_ack && timeout < 200) begin
                @(posedge clk);
                timeout = timeout + 1;
            end
            pr1_req = 1'b0;
            pr1_we  = 1'b0;
            @(negedge clk);
            if (timeout >= 200)
                $display("  [TIMEOUT] core1_write addr=0x%02h", addr);
        end
    endtask

    // Task: check condition and report PASS/FAIL
    task check;
        input        condition;
        input [127:0] test_name;
        begin
            total_tests = total_tests + 1;
            if (condition) begin
                $display("  [PASS] %s", test_name);
                pass_count = pass_count + 1;
            end else begin
                $display("  [FAIL] %s", test_name);
                fail_count = fail_count + 1;
            end
        end
    endtask

    // Task: helper to read MESI state of core0 cache line
    // Uses hierarchical reference into DUT internals
    task get_mesi_core0;
        input [1:0] set;
        input       way;
        output [1:0] state;
        begin
            state = dut.u_cache0.mesi[set][way];
        end
    endtask

    task get_mesi_core1;
        input [1:0] set;
        input       way;
        output [1:0] state;
        begin
            state = dut.u_cache1.mesi[set][way];
        end
    endtask

    // Task: print separator
    task print_scenario;
        input [255:0] name;
        begin
            $display("");
            $display("========================================");
            $display(" %s", name);
            $display("========================================");
        end
    endtask

    // Task: idle gap between scenarios
    task idle_gap;
        begin
            repeat(5) @(posedge clk);
        end
    endtask

    // =========================================================
    // MAIN TEST SEQUENCE
    // =========================================================
    reg [7:0] rdata0, rdata1;
    reg [1:0] mesi_state;

    initial begin
        // Init stats
        total_tests = 0;
        pass_count  = 0;
        fail_count  = 0;
        hit_count   = 0;
        miss_count  = 0;
        cycle_count = 0;

        // Init processor ports
        pr0_req=0; pr0_we=0; pr0_addr=0; pr0_wdata=0;
        pr1_req=0; pr1_we=0; pr1_addr=0; pr1_wdata=0;

        // Reset
        rst = 1;
        repeat(4) @(posedge clk);
        rst = 0;
        repeat(2) @(posedge clk);

        $display("");
        $display("╔══════════════════════════════════════════╗");
        $display("║   MESI Cache Coherence Protocol TB       ║");
        $display("║   2-Core Snooping Bus System             ║");
        $display("╚══════════════════════════════════════════╝");

  // =================================================
// SCENARIO 1: Cold Miss (I → E)
// Core 0 writes address 0x48 first (guarantees known data),
// then reads it back to confirm correctness.
// No other cache has it → should get EXCLUSIVE on the write,
// and stay EXCLUSIVE on the read (hit).
// =================================================
print_scenario("SCENARIO 1: Cold Miss  I -> E");
$display("  Core0 writes 0x48 to addr 0x48 (establish known data, first access)");

miss_count = miss_count + 1;
core0_write(8'h48, 8'h48);

// Address 0x48: tag=010, index=01, offset=000
// Set=1, check MESI state in cache0 after the write
get_mesi_core0(2'b01, 1'b0, mesi_state);
check(mesi_state == EXCLUSIVE,
      "Scenario1: Core0 state=EXCLUSIVE after write-miss");
// Note: some MESI implementations may go directly to MODIFIED
// on a write-miss instead of EXCLUSIVE — adjust expected state
// here if that's how your protocol is defined.

// Core1 should still be INVALID for this address
get_mesi_core1(2'b01, 1'b0, mesi_state);
check(mesi_state == INVALID,
      "Scenario1: Core1 state=INVALID (untouched)");

$display("  Core0 reads back 0x48 to confirm data correctness");
hit_count = hit_count + 1;
core0_read(8'h48, rdata0);

$display("  Core0 got data=0x%02h", rdata0);
check(rdata0 == 8'h48,
      "Scenario1: Data correct after write-then-read (0x48)");

idle_gap;
        // =================================================
        // SCENARIO 2: Read Hit (E → E, no bus traffic)
        // Core 0 reads 0x48 again — should hit in cache.
        // =================================================
        print_scenario("SCENARIO 2: Read Hit  E -> E");
        $display("  Core0 reads 0x48 again (should hit, no bus)");

        hit_count = hit_count + 1;
        core0_read(8'h48, rdata0);

        $display("  Core0 got data=0x%02h", rdata0);
        check(rdata0 == 8'h48,
              "Scenario2: Hit returns correct data");

        get_mesi_core0(2'b01, 1'b0, mesi_state);
        check(mesi_state == EXCLUSIVE,
              "Scenario2: Core0 stays EXCLUSIVE after read hit");

        idle_gap;

        // =================================================
        // SCENARIO 3: Shared Read (E → S, S → ?)
        // Core 1 reads 0x48 while Core 0 has it in E.
        // Core 0 should downgrade E → S.
        // Core 1 should enter S.
        // any_shared should have been asserted.
        // =================================================
        print_scenario("SCENARIO 3: Shared Read  E->S + I->S");
        $display("  Core1 reads 0x48 (Core0 has it in EXCLUSIVE)");

        miss_count = miss_count + 1;
        core1_read(8'h48, rdata1);

        $display("  Core1 got data=0x%02h", rdata1);
        check(rdata1 == 8'h48,
              "Scenario3: Core1 gets correct data");

        get_mesi_core0(2'b01, 1'b0, mesi_state);
        check(mesi_state == SHARED,
              "Scenario3: Core0 downgraded E->S");

        get_mesi_core1(2'b01, 1'b0, mesi_state);
        check(mesi_state == SHARED,
              "Scenario3: Core1 enters SHARED");

        idle_gap;

        // =================================================
        // SCENARIO 4: Write Invalidation (S→M, other→I)
        // Core 0 writes to 0x48 while both cores have S.
        // Core 0 should go M, Core 1 should go I.
        // =================================================
        print_scenario("SCENARIO 4: Write Invalidation  S->M + S->I");
        $display("  Core0 writes 0xAB to 0x48 (both cores in SHARED)");

        miss_count = miss_count + 1;
        core0_write(8'h48, 8'hAB);

        get_mesi_core0(2'b01, 1'b0, mesi_state);
        check(mesi_state == MODIFIED,
              "Scenario4: Core0 state=MODIFIED after write");

        // Give Core1 snoop a moment to process
        repeat(3) @(posedge clk);

        get_mesi_core1(2'b01, 1'b0, mesi_state);
        check(mesi_state == INVALID,
              "Scenario4: Core1 invalidated S->I");

        // Verify Core0 can read back written value
        hit_count = hit_count + 1;
        core0_read(8'h48, rdata0);
        check(rdata0 == 8'hAB,
              "Scenario4: Core0 reads back written value 0xAB");

        idle_gap;

        // =================================================
        // SCENARIO 5: Write Hit on Modified (M→M, silent)
        // Core 0 writes again to 0x48 — already Modified.
        // No bus transaction needed.
        // =================================================
        print_scenario("SCENARIO 5: Write Hit on Modified  M->M");
        $display("  Core0 writes 0xCD to 0x48 (already MODIFIED, silent)");

        hit_count = hit_count + 1;
        core0_write(8'h48, 8'hCD);

        get_mesi_core0(2'b01, 1'b0, mesi_state);
        check(mesi_state == MODIFIED,
              "Scenario5: Core0 stays MODIFIED");

        core0_read(8'h48, rdata0);
        check(rdata0 == 8'hCD,
              "Scenario5: Core0 reads back 0xCD");

        idle_gap;

        // =================================================
        // SCENARIO 6: Modified Intervention (M→S, I→S)
        // Core 1 reads 0x48 while Core 0 has dirty (M) copy.
        // Core 0 must writeback, then both go to S.
        // =================================================
        print_scenario("SCENARIO 6: Modified Intervention  M->S + I->S");
        $display("  Core1 reads 0x48 (Core0 has MODIFIED/dirty copy)");
        $display("  Core0 must writeback dirty data first");

        miss_count = miss_count + 1;
        core1_read(8'h48, rdata1);

        $display("  Core1 got data=0x%02h (should be Core0 dirty=0xCD)", rdata1);
        check(rdata1 == 8'hCD,
              "Scenario6: Core1 gets Core0 dirty data (0xCD)");

        // Both should now be SHARED
        repeat(3) @(posedge clk);

        get_mesi_core0(2'b01, 1'b0, mesi_state);
        check(mesi_state == SHARED,
              "Scenario6: Core0 downgraded M->S after writeback");

        get_mesi_core1(2'b01, 1'b0, mesi_state);
        check(mesi_state == SHARED,
              "Scenario6: Core1 enters SHARED with fresh data");

        // Verify memory was updated with written-back value
        repeat(5) @(posedge clk);
        check(dut.u_memory.mem_array[8'h48] == 8'hCD,
              "Scenario6: Memory updated with dirty data 0xCD");

        idle_gap;

        // =================================================
        // SCENARIO 7: False Sharing (Ping-Pong)
        // Core0 and Core1 alternately write to DIFFERENT bytes
        // in the SAME cache line (0x48 and 0x49 — same block).
        // Expect high bus traffic (M→I→M→I...).
        // =================================================
        print_scenario("SCENARIO 7: False Sharing Ping-Pong");
        $display("  Core0 writes 0x48, Core1 writes 0x49 (same cache line!)");
        $display("  Expect ping-pong: M->I->M->I...");

        core0_write(8'h48, 8'h11);
        idle_gap;
        $display("  Core0 wrote 0x11 to 0x48");
        get_mesi_core0(2'b01, 1'b0, mesi_state);
        check(mesi_state == MODIFIED,
              "FalseShare: Core0 has line in MODIFIED");

        core1_write(8'h49, 8'h22);   // different byte, same cache line!
        idle_gap;
        $display("  Core1 wrote 0x22 to 0x49 (same block as 0x48)");
        get_mesi_core1(2'b01, 1'b0, mesi_state);
        check(mesi_state == MODIFIED,
              "FalseShare: Core1 now has line in MODIFIED");

        repeat(3) @(posedge clk);
        get_mesi_core0(2'b01, 1'b0, mesi_state);
        check(mesi_state == INVALID,
              "FalseShare: Core0 invalidated (false sharing penalty!)");

        // One more round
        core0_write(8'h48, 8'h33);
        idle_gap;
        get_mesi_core0(2'b01, 1'b0, mesi_state);
        check(mesi_state == MODIFIED,
              "FalseShare: Core0 grabbed line back (M again)");

        repeat(3) @(posedge clk);
        get_mesi_core1(2'b01, 1'b0, mesi_state);
        check(mesi_state == INVALID,
              "FalseShare: Core1 invalidated again (ping-pong confirmed)");

        // =================================================
        // FINAL REPORT
        // =================================================
        repeat(10) @(posedge clk);

        $display("");
        $display("╔══════════════════════════════════════════╗");
        $display("║           SIMULATION COMPLETE            ║");
        $display("╠══════════════════════════════════════════╣");
        $display("║  Total Tests : %2d                        ║", total_tests);
        $display("║  PASSED      : %2d                        ║", pass_count);
        $display("║  FAILED      : %2d                        ║", fail_count);
        $display("╠══════════════════════════════════════════╣");
        $display("║  Total Cycles: %0d                      ║", cycle_count);
        $display("║  Cache Hits  : %0d                        ║", hit_count);
        $display("║  Cache Misses: %0d                        ║", miss_count);
        $display("║  Hit Rate    : %0d%%                       ║",
                 (hit_count * 100) / (hit_count + miss_count));
        $display("╚══════════════════════════════════════════╝");

        if (fail_count == 0)
            $display("\n  *** ALL TESTS PASSED — DESIGN CORRECT ***\n");
        else
            $display("\n  *** %0d TEST(S) FAILED — CHECK ABOVE ***\n", fail_count);

        $finish;
    end

    // ── Watchdog: kill simulation if stuck ───────────────────
    initial begin
        #200000;
        $display("[WATCHDOG] Simulation exceeded 200000ns — force quit");
        $finish;
    end

endmodule
