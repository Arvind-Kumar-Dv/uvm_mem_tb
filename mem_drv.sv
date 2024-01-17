class mem_drv extends uvm_driver#(mem_tx);
`uvm_component_utils(mem_drv)
mem_tx tx;
virtual mem_intf vif;
`NEW_COMP

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_resource_db#(virtual mem_intf)::read_by_name("GLOBAL","MEM_VIF",vif,this);
		//uvm_config_db#(virtual mem_intf)::get(this," ","MEM_VIF",vif);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive_tx(req);
			//req.print();
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(mem_tx tx);
		@(vif.drv_cb);
			vif.drv_cb.addr_i<=tx.addr;
			vif.drv_cb.wr_rd_i<=tx.wr_rd;
			if(tx.wr_rd) vif.drv_cb.wdata_i<=tx.data;
			else tx.data=vif.drv_cb.rdata_o;
			vif.drv_cb.valid_i<=1;
			//wait(vif.drv_cb.ready_o==1);
		
	    	@(vif.drv_cb);
			vif.drv_cb.valid_i<=0;
			vif.drv_cb.addr_i<=0;
			vif.drv_cb.wr_rd_i<=0;
			vif.drv_cb.wdata_i<=0;
			
	endtask

endclass
