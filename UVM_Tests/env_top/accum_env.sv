`ifndef ACCUM_ENV
`define ACCUM_ENV

class accum_environment extends uvm_env;
 
  accum_agent accum_agnt;
  accum_ref_model ref_model;
  accum_scoreboard  sb;
  //accum_coverage#(accum_transaction) coverage;
   
  `uvm_component_utils(accum_environment)
     
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    accum_agnt = accum_agent::type_id::create("accum_agent", this);
    ref_model = accum_ref_model::type_id::create("ref_model", this);
    sb = accum_scoreboard::type_id::create("sb", this);
    //coverage = accum_coverage#(accum_transaction)::type_id::create("coverage", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    accum_agnt.driver.drv2rm_port.connect(ref_model.rm_export);
    accum_agnt.monitor.mon2sb_port.connect(sb.mon2sb_export);
    ref_model.rm2sb_port.connect(sb.rm2sb_export);
    //ref_model.rm2sb_port.connect(coverage.analysis_export);
  endfunction : connect_phase

endclass : accum_environment

`endif




