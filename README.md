# 32 bit(parameterized) accumulator UVM verifications.
Accumulators are widely used in CIC/IIR filters.
A clocked 32bit signed accumulator targeted for FPGA designs is included here.
For a higher clock frequency, pipelining is desired(it's a little tricky since we have to solve the
feedback issue for pipelining).

The UVM test runs under Xilinx Vivado 2021.2 with the script UVM_Tests/brun

To force a simulation error, uncomment line 42 in RTL/accum.sv and comment out the line below.

The waveform dump and simulation log are in UVM_Tests/test.vcd and UVM_Tests/xsim.log.

Author contact:\
	tensor16@comcast.net

License:\
This project is licensed under the MIT License, https://opensource.org/licenses/MIT
