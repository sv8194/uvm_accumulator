`ifndef ACCUM_COVERAGE
`define ACCUM_COVERAGE

class accum_coverage#(type T=accum_transaction) extends uvm_subscriber#(T);

	accum_transaction cov_trans;

	`uvm_component_utils(accum_coverage)
	covergroup accum_cg;
	option.per_instance=1;
	option.goal=100;

	accum_cout    : coverpoint cov_trans.cout { 
                   bins low  = {0};
                   bins high = {1};
                 }

endgroup

function new(string name="accum_ref_model", uvm_component parent);
 super.new(name,parent);
 accum_cg =new();
 cov_trans =new();
endfunction

function void write(T t);
  this.cov_trans = t;
  accum_cg.sample();
endfunction

endclass

`endif



