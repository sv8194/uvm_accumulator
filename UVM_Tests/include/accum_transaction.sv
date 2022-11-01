`ifndef ACCUM_TRANSACTION
`define ACCUM_TRANSACTION

class accum_transaction extends uvm_sequence_item;
   rand bit [31:0] 				data;
   rand bit 					enable;
   rand bit 					clear;
   bit [31:0] 					accum;

  `uvm_object_utils_begin(accum_transaction)
    `uvm_field_int(data,	UVM_ALL_ON)
    `uvm_field_int(enable,	UVM_ALL_ON)
    `uvm_field_int(clear,	UVM_ALL_ON)
    `uvm_field_int(accum,	UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "accum_transaction");
    super.new(name);
  endfunction

  constraint c_data   	{ data inside {['h20:'hffff]}; }		// range
  constraint c_enable 	{ enable dist { 0:=80, 1:=20 }; }		// distribituion
  constraint c_clear 	{ clear dist { 0:=90, 1:=10 }; }

endclass

`endif

