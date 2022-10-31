`ifndef ACCUM_REF_MODEL 
`define ACCUM_REF_MODEL

class accum_ref_model extends uvm_component;
	`uvm_component_utils(accum_ref_model)
	
	uvm_analysis_export#(accum_transaction) rm_export;
	uvm_analysis_port#(accum_transaction) rm2sb_port;
	accum_transaction exp_trans, rm_trans;
	uvm_tlm_analysis_fifo#(accum_transaction) rm_exp_fifo;
	int tmp;
	
	function new(string name="accum_ref_model", uvm_component parent);
	  super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
	  rm_export = new("rm_export", this);
	  rm2sb_port = new("rm2sb_port", this);
	  rm_exp_fifo = new("rm_exp_fifo", this);
	endfunction : build_phase
	
	function void connect_phase(uvm_phase phase);
	  super.connect_phase(phase);
	  rm_export.connect(rm_exp_fifo.analysis_export);
	endfunction : connect_phase

	task run_phase(uvm_phase phase);
		forever begin
	 		rm_exp_fifo.get(rm_trans);
	 		get_expected_transaction(rm_trans);
		end
	endtask
	
	task get_expected_transaction(accum_transaction rm_trans);
		this.exp_trans =  rm_trans ;
		//`uvm_info(get_full_name(),$sformatf("EXPECTED TRANSACTION FROM REF MODEL"),UVM_LOW);
		//tmp = exp_trans.accum;
		//if (exp_trans.enable) begin
		//	exp_trans.accum = exp_trans.accum + exp_trans.data;
		//end
		`uvm_info("MODEL", $sformatf("active enable/%d accum/%x", exp_trans.enable, exp_trans.accum), UVM_LOW);
		exp_trans.print();
		rm2sb_port.write(exp_trans);
	endtask

endclass

`endif
