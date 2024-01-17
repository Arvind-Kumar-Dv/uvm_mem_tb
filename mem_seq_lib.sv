
class mem_base_seq extends uvm_sequence#(mem_tx);
`uvm_object_utils(mem_base_seq)
`NEW_OBJ
mem_tx tx,txq[$];
uvm_phase phase;
task pre_body();
		if(phase!=null) begin
		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,50);
		end
endtask

task post_body();
		if(phase!=null) begin
		phase.drop_objection(this);
		end

endtask

endclass

class mem_5wr_5rd_seq extends mem_base_seq;
	`uvm_object_utils(mem_5wr_5rd_seq)
	`NEW_OBJ


task body();
		
	repeat(5) begin
		`uvm_do_with(req,{req.wr_rd==1;})
		tx=new req;
		txq.push_back(tx);
	end


	repeat(5) begin
		 tx=txq.pop_front();
		`uvm_do_with(req,{req.wr_rd==0;req.addr==tx.addr;})
	end
	
endtask
endclass


/*

class mem_base_seq extends uvm_sequence#(mem_tx);
`uvm_object_utils(mem_base_seq)
`NEW_OBJ
mem_tx tx,tx1,txq[$];
uvm_phase phase;
task pre_body();
		if(phase!=null) begin
		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,50);
		end
endtask

task post_body();
		if(phase!=null) begin
		phase.drop_objection(this);
		end

endtask

endclass

class mem_5wr_5rd_seq extends mem_base_seq;
	`uvm_object_utils(mem_5wr_5rd_seq)
	`NEW_OBJ


task body();
bit[3:0] i;
		tx1=new();
		tx1.randomize();
		$display("tx=%p",tx1.addrQ);
	repeat(5) begin
		`uvm_do_with(req,{req.wr_rd==1;req.addr==tx1.addrQ[i];})
		tx=new req;
		txq.push_back(tx);
		i=i+1;
	end


	repeat(5) begin
		 tx=new req;
		 tx=txq.pop_front();
		`uvm_do_with(req,{req.wr_rd==0;req.addr==tx.addr;})
	end
	
endtask

endclass
*/
