class mem_cov extends uvm_subscriber#(mem_tx);
`uvm_component_utils(mem_cov)
mem_tx tx;


covergroup mem_cg;
ADDR_CP:coverpoint tx.addr{
	option.auto_bin_max=8;
}

WR_RD_CP:coverpoint tx.wr_rd{
	bins WRITE={1'b1};
	bins READ={1'b0};
}

ADDR_X_WR_RD:cross ADDR_CP,WR_RD_CP;

endgroup

function new(string name,uvm_component parent);
	super.new(name,parent);
	mem_cg=new();
endfunction

//function void write(T t);
function void write(mem_tx t);
	$cast(tx,t);
	mem_cg.sample();
	$display("coverage=%f",mem_cg.get_coverage()); // here also we can print the coverage
endfunction

endclass
