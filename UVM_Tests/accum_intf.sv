`ifndef ACCUM_INTF
`define ACCUM_INTF

interface accum_intf(input logic clk, reset_n);

  // signals
  logic [31:0]	data;
  logic		 	enable;
  logic		 	clear;
  logic [31:0]	accum;

  // clocking for driver
  clocking dr_cb@(posedge clk) ;
  	default input #1step output #2;
    input  accum;
    output data;
    output enable;
    output clear;
  endclocking

  modport DRV (clocking dr_cb,input clk,reset_n) ;

  // clocking for receiver
  clocking rc_cb@(negedge clk) ;
  	default input #1step output #2;
    input data;
    input enable;
    input clear;
    input accum;
  endclocking

  modport RCV (clocking rc_cb,input clk,reset_n);

  modport DUT (input enable, clear, data, clk, reset_n, output accum);

  modport SV (input accum, enable, clear, data, clk, reset_n); 

endinterface

`endif
