`ifndef ACCUM_AGENT_PKG
`define ACCUM_AGENT_PKG

package accum_agent_pkg;
 
   import uvm_pkg::*;
   `include "uvm_macros.svh"

  `include "accum_defines.svh"
  `include "accum_transaction.sv"
  `include "accum_sequencer.sv"
  `include "accum_driver.sv"
  `include "accum_monitor.sv"
  `include "accum_agent.sv"

endpackage

`endif



