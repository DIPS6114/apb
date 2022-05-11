`include "apb_seq_item.sv"
`include "apb_sequence.sv"
`include "apb_sequencer.sv"
`include "apb_driver.sv"
`include "apb_monitor1.sv"

class apb_agent1 extends uvm_agent;
  
  `uvm_component_utils(apb_agent1);
  
  apb_sequencer sequencer;
  apb_driver driver;
  apb_monitor1 monitor1;
  
  
  function new(string name="apb_agent1",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer=apb_sequencer::type_id::create("sequencer",this);
    driver=apb_driver::type_id::create("driver",this);
    monitor1=apb_monitor1::type_id::create("monitor1",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
  
endclass
  