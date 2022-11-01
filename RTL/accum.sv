//=============================================================================================
//  Module:		accum.sv
//
//  Author:		Yibing
//  Company:	Self
//  Date:		04/16/22
//
//=============================================================================================
//
//  Description:
//		. An overflow/underflow output flag is desired.
//		. For high clock rate(>200MHz) and high bitwidth(>64bits), a straight pipelining is not
//			possible since it has feedback, but the problem can be solved with advanced pipelining
//			algorithms.
//		. editor tabspace = 4
//
//=============================================================================================
module accum #(
	parameter DIN_WIDTH = 32,
	parameter DOUT_WIDTH = 32
)
(
	input logic        						clk,

	input logic        						en_i,			// enable
	input logic        						clear_i,		// clear
	input logic signed [DIN_WIDTH-1:0]		data_i,			// input data

	output logic signed [DOUT_WIDTH-1:0]	result_o
);
localparam
	STUFF_BITS = DOUT_WIDTH - DIN_WIDTH; 

wire [DOUT_WIDTH-1:0]	in_data_sext = DIN_WIDTH'(signed'(data_i));

always@(posedge clk) begin
	casez({
		  	clear_i,
			en_i
		  })
		2'b1?: result_o <= 'd0;

		//2'b01: result_o <= (result_o == 'hfeb4) ? 'h1111 : { result_o + in_data_sext }; 		// trigger an error, t=2365ns
		2'b01: result_o <= { result_o + in_data_sext };

		2'b00: result_o <= result_o; 
	endcase
end

endmodule 
