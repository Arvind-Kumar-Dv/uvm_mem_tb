`define NEW_COMP \
function new(string name ,uvm_component parent);\
super.new(name,parent);\
endfunction

`define NEW_OBJ \
function new(string name ="");\
super.new(name);\
endfunction

`define ADDR_WIDTH 4
`define WIDTH 16
`define DEPTH 16

class mem_common;
static int  num_matches;
static int  num_mismatches;
endclass
