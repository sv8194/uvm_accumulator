`ifndef ACCUM_DRIVER
`define ACCUM_DRIVER

class accum_driver extends uvm_driver #(accum_transaction);
 
	accum_transaction trans;
	virtual accum_intf vif;
	
	`uvm_component_utils(accum_driver)
	uvm_analysis_port#(accum_transaction) drv2rm_port;

	function new (string name, uvm_component parent);
	  super.new(name, parent);
	endfunction : new
	
	function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
	   if(!uvm_config_db#(virtual accum_intf)::get(this, "", "intf", vif))
	     `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
	  drv2rm_port = new("drv2rm_port", this);
	endfunction: build_phase
	
	virtual task run_phase(uvm_phase phase);
		reset();
		forever begin
			seq_item_port.get_next_item(req);
			drive();
			$cast(rsp, req.clone());
			rsp.set_id_info(req);
			rsp.enable = req.enable;
		
			if (vif.rc_cb.enable) begin
				rsp.accum = vif.rc_cb.data + vif.rc_cb.accum;
			end else begin
				rsp.accum = vif.rc_cb.accum;
			end
			rsp.data = req.data;
		
			if (req.enable) begin
				`uvm_info("DRIVER", $sformatf("active req.enable/%d", req.enable), UVM_LOW);
				rsp.print();
				drv2rm_port.write(rsp);
			end
			seq_item_port.item_done();
			seq_item_port.put(rsp);
		end
	endtask : run_phase

	task drive();
		@(vif.dr_cb);
		vif.dr_cb.data <= req.data;
		vif.dr_cb.enable <= req.enable;
		vif.dr_cb.clear <= req.clear;
	endtask
	
	// get DUT a nice state around T=0
	task reset();
		vif.dr_cb.clear <= 1;
		vif.dr_cb.data <='d0;
		vif.dr_cb.enable <= 0;
		repeat(5)@(vif.dr_cb);
		vif.dr_cb.clear <= 0;
		repeat(5)@(vif.dr_cb);
	endtask

endclass : accum_driver

`endif
