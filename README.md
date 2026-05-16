# MESI Cache Coherence Protocol — Verilog Implementation

A fully functional **2-core snooping-based MESI cache coherence system**
implemented in Verilog from scratch. Covers all classic coherence scenarios
including cold misses, shared reads, write invalidation, dirty intervention,
and false sharing — with automated PASS/FAIL checking and waveform export.

---

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Quick Start](#quick-start)
- [Test Scenarios](#test-scenarios)
- [MESI State Encoding](#mesi-state-encoding)
- [Bus Command Encoding](#bus-command-encoding)
- [Expected Output](#expected-output)

---

## Overview

The **MESI protocol** is an industry-standard cache coherence protocol used
in multi-core processors to keep per-core caches consistent with each other
and with main memory.

### Architecture

```
  ┌─────────────┐                   ┌─────────────┐
  │   Core 0    │                   │   Core 1    │
  │ ┌─────────┐ │                   │ ┌─────────┐ │
  │ │  Cache  │ │                   │ │  Cache  │ │
  │ │  Array  │ │                   │ │  Array  │ │
  │ └────┬────┘ │                   │ └────┬────┘ │
  │ ┌────▼────┐ │                   │ ┌────▼────┐ │
  │ │  MESI   │ │                   │ │  MESI   │ │
  │ │  Ctrl   │ │                   │ │  Ctrl   │ │
  └─┴────┬────┴─┘                   └─┴────┬────┴─┘
         │                                 │
         └────────────────┬────────────────┘
                    ┌─────▼─────┐
                    │ Snooping  │
                    │    Bus    │◄──── Bus Arbiter
                    └─────┬─────┘
                    ┌─────▼─────┐
                    │  Memory   │
                    │  Ctrl     │
                    └───────────┘
```

### Components

| File | Description |
|---|---|
| `cache_array.v` | Cache storage — tag / data / MESI state / valid / LRU bits |
| `mesi_controller.v` | Per-core FSM — handles processor requests and bus snooping |
| `bus_interface.v` | Shared snooping bus with 4-phase protocol |
| `bus_arbiter.v` | Round-robin bus arbitration between cores |
| `memory_controller.v` | Main memory with configurable access latency |
| `top.v` | Top-level integration of all modules |

---

## Project Structure

```
mesi_coherence/
├── rtl/
│   ├── cache_array.v          # Cache storage: tag/data/MESI/valid/LRU
│   ├── mesi_controller.v      # Per-core FSM: processor requests + bus snooping
│   ├── bus_interface.v        # Shared snooping bus: 4-phase protocol
│   ├── bus_arbiter.v          # Round-robin arbitration
│   ├── memory_controller.v    # Main memory with configurable latency
│   └── top.v                  # Top-level integration
├── tb/
│   └── tb_mesi_top.v          # Testbench: 7 scenarios, PASS/FAIL checking
├── scripts/
│   └── run_sim.sh             # Quick run script
├── docs/
│   └── signals.gtkw           # GTKWave signal layout file
├── Makefile
└── README.md
```

---



## Test Scenarios

7 handcrafted scenarios with automated PASS/FAIL assertions:

| # | Scenario | MESI Transitions | What It Proves |
|---|---|---|---|
| 1 | Cold Miss | `I → E` | Basic miss handling, memory fetch |
| 2 | Read Hit | `E → E` | Cache hit, zero bus traffic |
| 3 | Shared Read | `E → S, I → S` | `any_shared` signal, state downgrade |
| 4 | Write Invalidation | `S → M, S → I` | `BusUpgr`, invalidation broadcast |
| 5 | Write Hit (Modified) | `M → M` | Silent write, no bus needed |
| 6 | Modified Intervention | `M → S, I → S` | Dirty writeback, cache-to-cache transfer |
| 7 | False Sharing | `M → I → M → I` | Performance pathology demonstration |

---

## MESI State Encoding

| Bits | State | Meaning |
|---|---|---|
| `00` | **INVALID** | Line not valid — treated as empty |
| `01` | **SHARED** | Clean copy; multiple caches may hold it |
| `10` | **EXCLUSIVE** | Clean copy; only this cache holds it |
| `11` | **MODIFIED** | Dirty copy; only this cache holds it (owner) |

### State Transition Diagram

```
                      BusRd (other)
         ┌──────────────────────────────────┐
         │                                  ▼
  ┌──────┴─┐   PrRd / Miss   ┌─────────────────┐
  │INVALID │────────────────►│   EXCLUSIVE     │
  └────────┘                 └────────┬────────┘
       ▲                     PrWr     │  BusRd (other)
       │                    ┌─────────┘          │
       │                    ▼                    ▼
       │             ┌──────────┐          ┌──────────┐
       │  BusRdX     │ MODIFIED │          │  SHARED  │
       └─────────────│          │          └────┬─────┘
         (other)     └──────────┘          PrWr │
                                           ┌────┘
                                           ▼
                                      ┌──────────┐
                                      │ MODIFIED │
                                      └──────────┘
```

---

## Bus Command Encoding

| Bits | Command | Issued By | Meaning |
|---|---|---|---|
| `000` | **IDLE** | — | No active transaction |
| `001` | **BusRd** | Requester | Read request, no write intent |
| `010` | **BusRdX** | Requester | Read-exclusive — fetch and invalidate all copies |
| `011` | **BusUpgr** | Requester | Upgrade `S → M` — data already held, invalidate others |
| `100` | **BusWB** | Owner | Writeback — flush dirty data to memory |

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
  [PASS] Scenario1: Core0 state = EXCLUSIVE
  [PASS] Scenario1: Core1 state = INVALID (untouched)

========================================
 SCENARIO 2: Read Hit  E -> E
========================================
  [PASS] Scenario2: Hit returns correct data
  [PASS] Scenario2: Core0 stays EXCLUSIVE after read hit

... (all 7 scenarios) ...

╔══════════════════════════════════════════╗
║           SIMULATION COMPLETE            ║
╠══════════════════════════════════════════╣
║  Total Tests :  21                       ║
║  PASSED      :  21                       ║
║  FAILED      :   0                       ║
╠══════════════════════════════════════════╣
║  Total Cycles:  348                      ║
║  Cache Hits  :   4                       ║
║  Cache Misses:   7                       ║
║  Hit Rate    :  36%                      ║
╚══════════════════════════════════════════╝

  *** ALL TESTS PASSED — DESIGN CORRECT ***
```

---

## Tools Used

| Tool | Purpose |
|---|---|
| [Icarus Verilog](http://iverilog.icarus.com/) | Verilog compilation and simulation |
| [GTKWave](http://gtkwave.sourceforge.net/) | VCD waveform viewer |
| Make | Build automation |
