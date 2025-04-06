# The testbenches provided are just some simple cases, 
# you are encouraged to modify the tb/test.py files 
# to conduct more comprehensive testing. 

TOPLEVEL_LANG ?= verilog
SIM ?= icarus

VERILOG_SOURCES += rtl/systolic_array.sv
VERILOG_SOURCES += rtl/accumulator.sv
VERILOG_SOURCES += rtl/relu.sv
VERILOG_SOURCES += rtl/multiplier_fp16.sv
VERILOG_SOURCES += rtl/adder_fp16.sv
# include your submodule designs, if you have any. 
# VERILOG_SOURCES += rtl/submodule1.sv
# VERILOG_SOURCES += rtl/submodule2.sv
# VERILOG_SOURCES += rtl/……

# If you want to test your systolic array design, 
# please uncomment the following two lines
 TOPLEVEL = systolic_array
 MODULE = tb.test_systolic_array



# If you want to test your accumulator design, 
# please uncomment the following two lines
# TOPLEVEL = accumulator
# MODULE = tb.test_accumulator

# If you want to test your relu design, 
# please uncomment the following two lines
# TOPLEVEL = relu
# MODULE = tb.test_relu

include $(shell cocotb-config --makefiles)/Makefile.sim