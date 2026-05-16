# MESI Cache Coherence Protocol — Verilog Implementation

A fully functional 2-core snooping-based MESI cache coherence system
implemented in Verilog. Built for learning, simulation, and placement interviews.

---

## Project Structure

```
mesi_coherence/
├── rtl/
│   ├── cache_array.v        # Cache storage: tag/data/MESI/valid/LRU
│   ├── mesi_controller.v    # Per-core FSM: processor requests + bus snooping
│   ├── bus_interface.v      # Shared snooping bus: 4-phase protocol
│   ├── bus_arbiter.v        # Round-robin arbitration
│   ├── memory_controller.v  # Main memory with configurable latency
│   └── top.v                # Top-level integration
├── tb/
│   └── tb_mesi_top.v        # Testbench: 7 scenarios, PASS/FAIL checking
├── scripts/
│   └── run_sim.sh           # Quick run script
├── docs/
│   └── signals.gtkw         # GTKWave signal layout file
├── .github/workflows/
│   └── ci.yml               # GitHub Actions: auto-simulate on push
├── Makefile
└── README.md
```

---

## Quick Start

### Prerequisites

Install **Icarus Verilog**:

```bash
# Ubuntu / Debian
sudo apt install iverilog

# macOS (Homebrew)
brew install icarus-verilog

# Windows
# Download installer from: http://bleyer.org/icarus/
```

Optionally install **GTKWave** for waveform viewing:
```bash
# Ubuntu
sudo apt install gtkwave

# macOS
brew install --cask gtkwave
```

---

### Run Simulation

**Option 1 — Make (recommended):**
```bash
make          # compile + run
make wave     # open GTKWave waveform
make clean    # remove build files
```

**Option 2 — Shell script:**
```bash
bash scripts/run_sim.sh
```

**Option 3 — Manual commands:**
```bash
# Compile
iverilog -g2005 -Wall \
    rtl/cache_array.v \
    rtl/memory_controller.v \
    rtl/bus_arbiter.v \
    rtl/bus_interface.v \
    rtl/mesi_controller.v \
    rtl/top.v \
    tb/tb_mesi_top.v \
    -o mesi_sim.out

# Run
vvp mesi_sim.out

# View waveform
gtkwave mesi_sim.vcd docs/signals.gtkw
```

---

## Expected Output

```
╔══════════════════════════════════════════╗
║   MESI Cache Coherence Protocol TB       ║
║   2-Core Snooping Bus System             ║
╚══════════════════════════════════════════╝

========================================
 SCENARIO 1: Cold Miss  I -> E
========================================
  [PASS] Scenario1: Data correct (0x48)
  [PASS] Scenario1: Core0 state=EXCLUSIVE
  [PASS] Scenario1: Core1 state=INVALID (untouched)

========================================
 SCENARIO 2: Read Hit  E -> E
========================================
  [PASS] Scenario2: Hit returns correct data
  [PASS] Scenario2: Core0 stays EXCLUSIVE after read hit

... (all 7 scenarios) ...

╔══════════════════════════════════════════╗
║           SIMULATION COMPLETE            ║
╠══════════════════════════════════════════╣
║  Total Tests :  X                        ║
║  PASSED      :  X                        ║
║  FAILED      :  0                        ║
╠══════════════════════════════════════════╣
║  Total Cycles: XXX                       ║
║  Cache Hits  : X                         ║
║  Cache Misses: X                         ║
║  Hit Rate    : XX%                       ║
╚══════════════════════════════════════════╝

  *** ALL TESTS PASSED — DESIGN CORRECT ***
```

---

## Test Scenarios Covered

| # | Scenario              | MESI Transitions          | What it proves                    |
|---|-----------------------|---------------------------|-----------------------------------|
| 1 | Cold Miss             | I → E                     | Basic miss handling, memory fetch |
| 2 | Read Hit              | E → E                     | Cache hit, no bus traffic         |
| 3 | Shared Read           | E → S, I → S              | any_shared signal, downgrade      |
| 4 | Write Invalidation    | S → M, S → I              | BusUpgr, invalidation broadcast   |
| 5 | Write Hit (Modified)  | M → M                     | Silent write, no bus needed       |
| 6 | Modified Intervention | M → S, I → S              | Dirty writeback, cache-to-cache   |
| 7 | False Sharing         | M → I → M → I (ping-pong) | Performance pathology demo        |

---

## MESI State Encoding

| Bits | State     | Meaning                                         |
|------|-----------|-------------------------------------------------|
| 00   | INVALID   | Line not valid                                  |
| 01   | SHARED    | Clean copy, multiple caches may have it         |
| 10   | EXCLUSIVE | Clean copy, only this cache has it              |
| 11   | MODIFIED  | Dirty copy, only this cache has it (owns it)    |

---

## Bus Command Encoding

| Bits | Command  | Meaning                                          |
|------|----------|--------------------------------------------------|
| 000  | IDLE     | No transaction                                   |
| 001  | BusRd    | Read request (no write intent)                   |
| 010  | BusRdX   | Read-exclusive (write intent, fetch + invalidate)|
| 011  | BusUpgr  | Upgrade S→M (already have data, just invalidate) |
| 100  | BusWB    | Writeback (dirty data to memory)                 |

---


