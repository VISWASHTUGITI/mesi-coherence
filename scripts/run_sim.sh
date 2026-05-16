#!/bin/bash
# ============================================================
# run_sim.sh — Quick simulation runner
# Usage: bash scripts/run_sim.sh
# ============================================================

set -e

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   MESI Cache Coherence — Simulation     ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Check iverilog is installed
if ! command -v iverilog &> /dev/null; then
    echo "ERROR: iverilog not found."
    echo "Install with:"
    echo "  Ubuntu/Debian : sudo apt install iverilog"
    echo "  Mac (Homebrew): brew install icarus-verilog"
    exit 1
fi

# Compile
echo ">>> Step 1: Compiling..."
iverilog -g2005 -Wall \
    rtl/cache_array.v \
    rtl/memory_controller.v \
    rtl/bus_arbiter.v \
    rtl/bus_interface.v \
    rtl/mesi_controller.v \
    rtl/top.v \
    tb/tb_mesi_top.v \
    -o mesi_sim.out

echo ">>> Compilation successful!"
echo ""

# Run
echo ">>> Step 2: Running simulation..."
echo ""
vvp mesi_sim.out

echo ""
echo ">>> VCD waveform saved to: mesi_sim.vcd"
echo ">>> Open waveform with:   gtkwave mesi_sim.vcd docs/signals.gtkw"
echo ""
