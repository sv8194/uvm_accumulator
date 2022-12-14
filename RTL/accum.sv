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
	interface itf
);
localparam
	STUFF_BITS = DOUT_WIDTH - DIN_WIDTH; 

reg signed [DOUT_WIDTH-1:0]		result_o;
wire 							clk = itf.clk;
//wire signed [DIN_WIDTH-1:0]		data_i = itf.data;
wire 							clear_i = itf.clear;
wire 							en_i = itf.enable;
wire [DOUT_WIDTH-1:0]			in_data_sext = DOUT_WIDTH'(signed'(itf.data));

assign itf.accum = result_o;

always@(posedge clk) begin
	casez({
		  	clear_i,
			en_i
		  })
		2'b1?: result_o <= 'd0;
		//2'b1?: result_o <= 'h2222;		// trigger an assertion error.

		//2'b01: result_o <= (result_o == 'hfeb4) ? 'h1111 : { result_o + in_data_sext }; 		// trigger an error, t=2380ns
		2'b01: result_o <= { result_o + in_data_sext };

		2'b00: result_o <= result_o; 
	endcase
end

endmodule 
