`ifndef ACCUM_ENV_PKG
`define ACCUM_ENV_PKG

package accum_env_pkg;
   
   import uvm_pkg::*;
   `include "uvm_macros.svh"

   import accum_agent_pkg::*;
   import accum_ref_model_pkg::*;

  `include "accum_coverage.sv"
  `include "accum_scoreboard.sv"
  `include "accum_env.sv"

endpackage

`endif


