`ifndef ACCUM_TB_TOP
`define ACCUM_TB_TOP

`include "uvm_macros.svh"
`include "accum_intf.sv"

import uvm_pkg::*;
module accum_tb_top;
	import accum_test_list::*;

	//--------------------------------------- 
	// signals
	parameter cycle = 10;
	bit clk;
	bit reset_n;

	//--------------------------------------- 
	// interface
	accum_intf accum_intf(clk, reset_n);

	//--------------------------------------- 
	// DUT
	accum dut(.itf(accum_intf.DUT));
 
	//--------------------------------------- 
	// SVA top for assertions
	bind accum : dut sva_top sva (.itf(accum_intf.SV));

	//--------------------------------------- 
	// clock and reset
	initial forever #(cycle/2) clk = ~clk;

	initial begin
		clk = 1'b0;
		reset_n = 1'b0;  
		#(cycle* 5) reset_n = 1;
	end

	//--------------------------------------- 
	// start UVM tests
	initial begin
		uvm_config_db#(virtual accum_intf)::set(uvm_root::get(),"*","intf",accum_intf);
		run_test();
	end

	initial begin $dumpfile("test.vcd"); $dumpvars(0, accum_tb_top); end
endmodule

`endif
