`ifndef ACCUM_MONITOR 
`define ACCUM_MONITOR

class accum_monitor extends uvm_monitor;
 
	virtual accum_intf vif;
	uvm_analysis_port #(accum_transaction) mon2sb_port;
	accum_transaction act_trans;

	`uvm_component_utils(accum_monitor)
	
	function new (string name, uvm_component parent);
	  super.new(name, parent);
	  act_trans = new();
	  mon2sb_port = new("mon2sb_port", this);
	endfunction : new

	function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
	  if (!uvm_config_db#(virtual accum_intf)::get(this, "", "intf", vif))
	  	`uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
	endfunction: build_phase

	virtual task run_phase(uvm_phase phase);
		repeat(11)@(vif.rc_cb);
		forever begin
			collect_trans();
			mon2sb_port.write(act_trans);		// send it to scoreboard.
		end
	endtask : run_phase

	task collect_trans();
	  @(vif.rc_cb);
	  act_trans.data = vif.rc_cb.data;
	  act_trans.clear = vif.rc_cb.clear;
	  act_trans.enable = vif.rc_cb.enable;
	  act_trans.accum = vif.rc_cb.accum;
	  `uvm_info("MONITOR", $sformatf("active"), UVM_LOW);
	  act_trans.print();
	endtask

endclass : accum_monitor

`endif
