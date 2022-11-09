import uvm_pkg::*;
`include "uvm_macros.svh"

module sva_top #(
	parameter DIN_WIDTH = 32,
	parameter DOUT_WIDTH = 32
)
(
	input logic        						clk,

	input logic        						en_i,			// enable
	input logic        						clear_i,		// clear
	input logic signed [DIN_WIDTH-1:0]		data_i,			// input data

	input logic signed [DOUT_WIDTH-1:0]		result_o
);
	logic signed [DIN_WIDTH-1:0]	data_p;
	logic signed [DOUT_WIDTH-1:0]	result_p;

	always@(posedge clk) begin
		data_p <= #2 data_i;
		result_p <= #2 result_o;
	end

	property pp0;
		@(posedge clk) clear_i |-> ##1 (result_o == 'd0);
	endproperty
	assert property(pp0) else
		`uvm_error("SVA", "assertion");

	property pp1;
		@(posedge clk) en_i |-> ##1 (result_o == (data_p + result_p));
	endproperty
	assert property(pp1) else
		`uvm_error("SVA", "assertion");

endmodule
