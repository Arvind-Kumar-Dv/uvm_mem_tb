interface mem_intf(input bit clk_i,rst_i);
bit wr_rd_i,valid_i,ready_o;
bit[`ADDR_WIDTH-1:0]addr_i;
bit[`WIDTH-1:0]wdata_i;
bit[`WIDTH-1:0]rdata_o;

// monitor

clocking mon_cb @(posedge clk_i);
		default input #0;
		input wr_rd_i,rst_i,valid_i,ready_o,addr_i,wdata_i,rdata_o;
endclocking

//driver

clocking drv_cb @(posedge clk_i);
		default input #0 output#1;
		input ready_o,rdata_o,rst_i;
		output wr_rd_i,valid_i,addr_i,wdata_i;
endclocking


endinterface
