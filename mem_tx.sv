/*
class mem_tx extends uvm_sequence_item;
`NEW_OBJ
rand bit[`ADDR_WIDTH-1:0] addr;
rand bit[`WIDTH-1:0] data;
rand bit wr_rd;

`uvm_object_utils_begin(mem_tx)
	`uvm_field_int(addr,UVM_ALL_ON)
	`uvm_field_int(data,UVM_ALL_ON)
	`uvm_field_int(wr_rd,UVM_ALL_ON)
`uvm_object_utils_end

constraint c{
     	  unique{addr}; 
  		  addr inside {[2:100]};
		}



endclass
*/


class mem_tx extends uvm_sequence_item;
`NEW_OBJ
rand bit[`ADDR_WIDTH-1:0] addr;
rand bit[`ADDR_WIDTH-1:0] addrQ[$];
rand bit[`WIDTH-1:0] data;
rand bit wr_rd;

`uvm_object_utils_begin(mem_tx)
	`uvm_field_int(addr,UVM_ALL_ON)
	`uvm_field_int(data,UVM_ALL_ON)
	`uvm_field_int(wr_rd,UVM_ALL_ON)
`uvm_object_utils_end

constraint c{
      addrQ.size()==2**`ADDR_WIDTH;
	  unique{addrQ};
		}

endclass

