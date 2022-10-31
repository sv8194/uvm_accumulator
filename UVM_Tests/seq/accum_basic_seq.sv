`ifndef ACCUM_BASIC_SEQ 
`define ACCUM_BASIC_SEQ

class accum_basic_seq extends uvm_sequence#(accum_transaction);
   
  `uvm_object_utils(accum_basic_seq)

  function new(string name = "accum_basic_seq");
    super.new(name);
  endfunction

	virtual task body();
		for(int i=0;i<`NO_OF_TRANSACTIONS;i++) begin
		   req = accum_transaction::type_id::create("req");
		   start_item(req);
		   assert(req.randomize());  
		   `uvm_info(get_full_name(),$sformatf("RANDOMIZED TRANSACTION FROM SEQUENCE"),UVM_LOW);
		   req.print();
		   finish_item(req);
		   get_response(rsp);
		end
	endtask
   
endclass

`endif


