class mem_mon extends uvm_monitor;
`uvm_component_utils(mem_mon)
 uvm_analysis_port#(mem_tx)ap_port;
virtual mem_intf vif;
mem_tx tx;
function new(string name,uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
		ap_port=new("ap_port",this);
		uvm_resource_db#(virtual mem_intf)::read_by_name("GLOBAL","MEM_VIF",vif,this);
	//	uvm_config_db#(virtual mem_intf)::get(this," ","MEM_VIF",vif);
endfunction

task run_phase(uvm_phase phase);
	forever begin
			@(vif.mon_cb);
				tx=new();	
				  if(vif.mon_cb.valid_i==1 && vif.mon_cb.ready_o==1) begin
					tx.addr =vif.mon_cb.addr_i;
					tx.wr_rd =vif.mon_cb.wr_rd_i;
					tx.data =vif.mon_cb.wr_rd_i ? vif.mon_cb.wdata_i :vif.mon_cb.rdata_o;
				//	tx.print();
					ap_port.write(tx);
		          end

	end

endtask

endclass
