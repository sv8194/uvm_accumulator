`ifndef ACCUM_TRANSACTION
`define ACCUM_TRANSACTION

class accum_transaction extends uvm_sequence_item;
   rand bit [31:0] 				data;
   rand bit 					enable;
   bit  						clear;
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

endclass

`endif
