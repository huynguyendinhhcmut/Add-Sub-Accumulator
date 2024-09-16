# Variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
SIM_DIR = sim
OUTPUT = accumulator
VCD_FILE = accumulator_wave.vcd
RTL_DIR = ../rtl
DV_DIR = ../dv

# Source files
RTL_SOURCES = $(RTL_DIR)/accumulator.v \
	      $(RTL_DIR)/fullAdder.v \
	      $(RTL_DIR)/fullAdderNb.v
DV_SOURCES = $(DV_DIR)/accumulator_tb.v

#Optional macro definitions
WIDTH ?= 32

# Default target
all: build run

# Build, run and create wave
all_wave: build run wave

# Build target
build: $(OUTPUT)

# Rule to compile the Verilog sources
$(OUTPUT): $(RTL_SOURCES) $(DV_SOURCES)
	$(IVERILOG) -o $@ $^ -D Width=$(Width) -s accumulator_tb -g2005-sv
	
# Run target
run: build
	$(VVP) $(OUTPUT)

# Wave target
wave: $(VCD_FILE)
	$(GTKWAVE) $(VCD_FILE)

# Clean up
clean:
	rm -f $(OUTPUT) $(VCD_FILE)

# Help
help:
	@echo " make build	: build the design"
	@echo " make run	: run simulation"
	@echo " make wave	: open waveform"
	@echo " make all	: build and run simulation"
	@echo " make all_wave	: build, run simulation and open waveform"
	@echo " make clean	: remove simulation"
