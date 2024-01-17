/*
`uvm_analysis_imp_decl(_mem)
class mem_sbd extends uvm_scoreboard;
`uvm_component_utils(mem_sbd)
`NEW_COMP
uvm_analysis_imp_mem#(mem_tx,mem_sbd) imp_sbd;
bit[15:0] memw_Q[$];// memory in the tb , dut has its own memory
bit[15:0] memr_Q[$];
bit[15:0] wtx,rtx;


		function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		imp_sbd=new("imp_sbd",this);
		endfunction
		function void write_mem(mem_tx tx);
		`uvm_info("MEM_SBD","MEM_SBD_TX",UVM_LOW);
			//tx.print();
			if(tx.wr_rd==1) begin// write
			    memw_Q.push_back(tx.data);
			//	memw_Q.push_back(tx.data[15:0]);
				end
				if(tx.wr_rd==0) begin
				memr_Q.push_back(tx.data);
			//	memw_Q.push_back(tx.data[15:0]);

				end

		endfunction

		task run_phase(uvm_phase phase);
			forever begin
					wait(memw_Q.size()>0 && memr_Q.size()>0);
							wtx=memw_Q.pop_front();
							rtx=memr_Q.pop_front();
							if(wtx==rtx)begin
							$display("wtx=%0d",wtx);
							mem_common::num_matches++;
							end
							else begin
							$display("rtx=%0d",rtx);
							mem_common::num_mismatches++;
							end
					end

		endtask

	endclass
*/
	
   
`uvm_analysis_imp_decl(_wr)
`uvm_analysis_imp_decl(_rd)
class mem_sbd extends uvm_scoreboard;
`uvm_component_utils(mem_sbd)
`NEW_COMP
uvm_analysis_imp_wr#(mem_tx,mem_sbd) imp_sbd;
uvm_analysis_imp_rd#(mem_tx,mem_sbd) imp_sbd1;
mem_tx memw_Q[$];// memory in the tb , dut has its own memory
mem_tx memr_Q[$];
mem_tx wtx,rtx;


		function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		imp_sbd=new("imp_sbd",this);
		imp_sbd1=new("imp_sbd1",this);
		endfunction
		function void write_wr(mem_tx tx);
		`uvm_info("MEM_SBD","MEM_SBD_TX",UVM_LOW);
			    memw_Q.push_back(tx);
				
		endfunction

		function void write_rd(mem_tx tx);
				memr_Q.push_back(tx);
    	endfunction


		task run_phase(uvm_phase phase);
			forever begin
					wait(memw_Q.size()>0 && memr_Q.size()>0);
							wtx=memw_Q.pop_front();
							rtx=memr_Q.pop_front();
							if(wtx==rtx)begin
							$display("wtx=%0d",wtx);
							mem_common::num_matches++;
							end
							else begin
							$display("rtx=%0d",rtx);
							mem_common::num_mismatches++;
							end
					end

		endtask

	endclass


