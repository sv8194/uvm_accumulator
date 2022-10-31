# 32 bit(parameterized) accumulator UVM verifications.
A clocked 32bit signed accumulator targeted for FPGA designs. For a higher clock frequency, pipelining is desired.

The UVM test runs under Xilinx Vivado 2021.2 with the script UVM_Tests/brun

To force a simulation error, uncomment line 42 in RTL/accum.sv and comment out the line below.

TODO:\
	. handle buffer clear bit properly in UVM.\
	. accumulator width != 32.

License
This project is licensed under the MIT License, https://opensource.org/licenses/MIT
