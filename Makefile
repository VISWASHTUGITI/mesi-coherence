# ============================================================
# Makefile — MESI Cache Coherence Protocol Simulation
# Tool: Icarus Verilog (iverilog) + GTKWave
# ============================================================

# Simulator
IVERILOG = iverilog
VVP      = vvp
GTKWAVE  = gtkwave

# Source files (order matters: bottom-up)
RTL_SRCS = rtl/cache_array.v \
           rtl/memory_controller.v \
           rtl/bus_arbiter.v \
           rtl/bus_interface.v \
           rtl/mesi_controller.v \
           rtl/top.v

TB_SRC   = tb/tb_mesi_top.v

# Output
SIM_OUT  = mesi_sim.out
VCD_OUT  = mesi_sim.vcd

# ── Default target: compile + run ────────────────────────────
all: compile run

# ── Compile ───────────────────────────────────────────────────
compile:
	@echo ">>> Compiling MESI design..."
	$(IVERILOG) -g2005 -Wall -o $(SIM_OUT) $(RTL_SRCS) $(TB_SRC)
	@echo ">>> Compilation OK"

# ── Run simulation ───────────────────────────────────────────
run: $(SIM_OUT)
	@echo ">>> Running simulation..."
	$(VVP) $(SIM_OUT)

# ── Open waveform viewer ──────────────────────────────────────
wave: $(VCD_OUT)
	@echo ">>> Opening GTKWave..."
	$(GTKWAVE) $(VCD_OUT) docs/signals.gtkw &

# ── Clean build artifacts ─────────────────────────────────────
clean:
	rm -f $(SIM_OUT) $(VCD_OUT)
	@echo ">>> Cleaned"

# ── Help ──────────────────────────────────────────────────────
help:
	@echo ""
	@echo "  make         — compile + run simulation"
	@echo "  make compile — compile only"
	@echo "  make run     — run compiled simulation"
	@echo "  make wave    — open GTKWave waveform viewer"
	@echo "  make clean   — remove build artifacts"
	@echo ""

.PHONY: all compile run wave clean help
