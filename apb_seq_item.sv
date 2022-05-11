class apb_seq_item extends uvm_sequence_item;
  
    rand bit psel;
	rand bit pen;
	rand bit pwrite;
    randc bit [7:0]paddr;
    rand bit [7:0]pwdata;

        bit [7:0]prdata;
     	bit pready;


  `uvm_object_utils_begin(apb_seq_item)
        `uvm_field_int(psel,UVM_ALL_ON)
        `uvm_field_int(pen,UVM_ALL_ON)
        `uvm_field_int(pwrite,UVM_ALL_ON)
        `uvm_field_int(paddr,UVM_ALL_ON)
        `uvm_field_int(pwdata,UVM_ALL_ON)
        `uvm_field_int(prdata,UVM_ALL_ON)
	    `uvm_field_int(pready,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name="apb_seq_item");
    super.new(name);
  endfunction
  
endclass