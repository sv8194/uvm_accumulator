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
    output data;
    output enable;
    output clear;
    input  accum;
  endclocking

  modport DRV (clocking dr_cb,input clk,reset_n) ;

  // clocking for receiver
  clocking rc_cb@(negedge clk) ;
    input data;
    input enable;
    input clear;
    input accum;
  endclocking

  modport RCV (clocking rc_cb,input clk,reset_n);

endinterface

`endif
