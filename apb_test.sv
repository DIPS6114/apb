`include "apb_env.sv"

class apb_test extends uvm_test;
  
  `uvm_component_utils(apb_test)
  
  apb_env env;
  
  apb_sequence sq;
  
  
  
 
  
  function new(string name="apb_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=apb_env::type_id::create("env",this);
    sq=apb_sequence::type_id::create("sq",this);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    sq.start(env.agent1.sequencer);
    #100;
    phase.drop_objection(this);
  endtask

  
endclass
    
    
