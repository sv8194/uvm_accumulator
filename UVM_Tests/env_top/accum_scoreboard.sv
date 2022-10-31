`ifndef ACCUM_SCOREBOARD 
`define ACCUM_SCOREBOARD

class accum_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(accum_scoreboard)

	uvm_analysis_export#(accum_transaction) rm2sb_export, mon2sb_export;
	uvm_tlm_analysis_fifo#(accum_transaction) rm2sb_export_fifo, mon2sb_export_fifo;
	accum_transaction exp_trans, act_trans;
	accum_transaction exp_trans_fifo[$], act_trans_fifo[$];
	bit error;
	bit first_transac;
	int prev_data;
	
	function new (string name, uvm_component parent);
	  super.new(name, parent);
	endfunction : new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		rm2sb_export = new("rm2sb_export", this);
		mon2sb_export = new("mon2sb_export", this);
		rm2sb_export_fifo = new("rm2sb_export_fifo", this);
		mon2sb_export_fifo = new("mon2sb_export_fifo", this);
		first_transac = 1;
	endfunction: build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		rm2sb_export.connect(rm2sb_export_fifo.analysis_export);
		mon2sb_export.connect(mon2sb_export_fifo.analysis_export);
	endfunction: connect_phase

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			mon2sb_export_fifo.get(act_trans);
			if(act_trans==null) $stop;
			act_trans_fifo.push_back(act_trans);
			rm2sb_export_fifo.get(exp_trans);
			if(exp_trans==null) $stop;
			exp_trans_fifo.push_back(exp_trans);
			compare_trans();
		end
	endtask

	task compare_trans();
		accum_transaction exp_trans, act_trans;
	
		if(exp_trans_fifo.size!=0) begin : b1
	  		exp_trans = exp_trans_fifo.pop_front();
	
			if (act_trans_fifo.size!=0) begin : b0
				act_trans = act_trans_fifo.pop_front();
				if (act_trans.enable == 1) begin
			    	`uvm_info(get_full_name(), $sformatf("expected accum SUM =%x, actual accum SUM =%x ", exp_trans.accum, act_trans.accum), UVM_LOW);
					$display("--> %t pre_data/%x e_en/%d e_data/%x e_acc/%x a_en/%d a_data/%x a_acc/%x",
						$time,
						prev_data,
						exp_trans.enable, exp_trans.data, exp_trans.accum,
						act_trans.enable, act_trans.data, act_trans.accum,
						);
			    	//if(prev_data == (act_trans.data + act_trans.accum)) begin
			    	if(exp_trans.accum == (act_trans.data + act_trans.accum)) begin
			    	   `uvm_info(get_full_name(), $sformatf("SUM MATCHES"), UVM_LOW);
			    	end else begin
			    	   `uvm_error(get_full_name(), $sformatf("SUM MIS-MATCHES"));
			    	   error=1;
			    	end
				end
	
			 	// yibing -
			 	//if(exp_trans.accum == act_trans.accum) begin
			    //	`uvm_info(get_full_name(),$sformatf("SUM MATCHES"),UVM_LOW);
			    //end else begin
			    //	`uvm_error(get_full_name(),$sformatf("SUM MIS-MATCHES"));
			    //	error=1;
	  			//end
	  		end : b0
			//if (first_transac) begin
			//	prev_data <= act_trans.data;
			//end else begin
			//	prev_data <= act_trans.accum;
			//end
			//first_transac = 0;

			if (exp_trans.enable) begin
				prev_data <= act_trans.data + act_trans.accum;
			end else begin
				prev_data <= act_trans.accum;
			end
		end : b1
	endtask

	function void report_phase(uvm_phase phase);
	  if(error==0) begin
	    $write("%c[7;32m",27);
	    $display("TEST PASSED"); 
	    $write("%c[0m",27);
	  end else begin
	    $write("%c[7;31m",27);
	    $display("TEST FAILED"); 
	    $write("%c[0m",27);
	  end
	endfunction 
endclass : accum_scoreboard

`endif