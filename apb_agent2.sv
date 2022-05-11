`include "apb_monitor2.sv"

class apb_agent2 extends uvm_agent;
  
  `uvm_component_utils(apb_agent2)
  
  apb_monitor2 monitor2;
  
  
  function new(string name="apb_monitor2",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor2=apb_monitor2::type_id::create("monitor2",this);
  endfunction
  
endclass