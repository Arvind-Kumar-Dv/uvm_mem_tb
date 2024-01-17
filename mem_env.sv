class mem_env extends uvm_env;
`uvm_component_utils(mem_env)
mem_agent agent;
mem_sbd sbd;
`NEW_COMP
function void build_phase(uvm_phase phase);
super.build_phase(phase);
agent=mem_agent::type_id::create("agent",this);
sbd=mem_sbd::type_id::create("sbd",this);
endfunction

function void connect_phase(uvm_phase phase);
agent.mon.ap_port.connect(sbd.imp_sbd);
agent.mon.ap_port.connect(sbd.imp_sbd1);
endfunction
endclass
