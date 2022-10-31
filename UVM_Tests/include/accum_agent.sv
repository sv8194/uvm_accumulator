`ifndef ACCUM_AGENT 
`define ACCUM_AGENT

class accum_agent extends uvm_agent;
  accum_driver    driver;
  accum_sequencer sequencer;
  accum_monitor   monitor;

  `uvm_component_utils(accum_agent)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver = accum_driver::type_id::create("driver", this);
    sequencer = accum_sequencer::type_id::create("sequencer", this);
    monitor = accum_monitor::type_id::create("monitor", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction : connect_phase
 
endclass : accum_agent

`endif
