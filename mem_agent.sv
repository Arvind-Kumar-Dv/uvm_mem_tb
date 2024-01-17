class mem_agent extends uvm_agent;
`uvm_component_utils(mem_agent)
`NEW_COMP
mem_drv drv;
mem_sqr sqr;
mem_mon mon;
mem_cov cov;
 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	drv=mem_drv::type_id::create("drv",this);
	//drv=new("drv",this);
	sqr=mem_sqr::type_id::create("sqr",this);
	mon=mem_mon::type_id::create("mon",this);
	cov=mem_cov::type_id::create("cov",this);
 endfunction
function void connect_phase(uvm_phase phase);
	drv.seq_item_port.connect(sqr.seq_item_export);
	mon.ap_port.connect(cov.analysis_export);
endfunction
endclass
