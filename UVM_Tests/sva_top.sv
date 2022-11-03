
module sva_top #(
	parameter DIN_WIDTH = 32,
	parameter DOUT_WIDTH = 32
)
(
	input logic        						clk,

	input logic        						en_i,			// enable
	input logic        						clear_i,		// clear
	input logic signed [DIN_WIDTH-1:0]		data_i,			// input data

	input logic signed [DOUT_WIDTH-1:0]	result_o
);

	property pp0;
		@(posedge clk) clear_i |-> ##1 (result_o == 'd0);
	endproperty
	assert property(pp0);

endmodule
