`ifndef ACCUM_BASIC_TEST 
`define ACCUM_BASIC_TEST

class accum_basic_test extends uvm_test;
 
  `uvm_component_utils(accum_basic_test)
 
  accum_environment     env;
  accum_basic_seq       seq;

  function new(string name = "accum_basic_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    env = accum_environment::type_id::create("env", this);
    seq = accum_basic_seq::type_id::create("seq");
  endfunction : build_phase

  task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	seq.start(env.accum_agnt.sequencer);
	phase.drop_objection(this);
  endtask : run_phase
 
endclass : accum_basic_test

`endif

