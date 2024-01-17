class mem_base_test extends uvm_test;
`uvm_component_utils(mem_base_test)
`NEW_COMP
mem_env env;
function void build_phase(uvm_phase phase);
super.build_phase(phase);
env=mem_env::type_id::create("env",this);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology();
endfunction



function void report_phase(uvm_phase phase);
$display("num_matches=%0d",mem_common::num_matches);
$display("num_mismatches=%0d",mem_common::num_mismatches);
endfunction


endclass

class mem_5wr_5rd_test extends mem_base_test;
`uvm_component_utils(mem_5wr_5rd_test)
`NEW_COMP
	
	task run_phase(uvm_phase phase);
	mem_5wr_5rd_seq w_r_seq;
	w_r_seq=mem_5wr_5rd_seq::type_id::create("w_r_seq");
	phase.raise_objection(this);
	w_r_seq.start(env.agent.sqr);
	phase.phase_done.set_drain_time(this,50);
	phase.drop_objection(this);

   endtask
    
endclass
