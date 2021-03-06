`include "apb_agent1.sv"
`include "apb_agent2.sv"
`include "apb_scoreboard.sv"


 


class apb_env extends uvm_env;
  
  `uvm_component_utils(apb_env)
  
 apb_agent1 agent1;
 apb_agent2 agent2;
 apb_scoreboard scoreboard;
 apb_scoreboard cg;

 
  
  function new(string name="apb_env",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent1=apb_agent1::type_id::create("agent1",this);
    agent2=apb_agent2::type_id::create("agent2",this);
    scoreboard=apb_scoreboard::type_id::create("scoreboard",this);    
  endfunction
  
  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
    agent1.monitor1.item_collected_port.connect(scoreboard.item_collected_monitor1.analysis_export);
    agent2.monitor2.item_collected_port1.connect(scoreboard.item_collected_monitor2.analysis_export);
    
    agent1.monitor1.item_collected_port.connect(scoreboard.item_collected_coverage1.analysis_export);
    agent2.monitor2.item_collected_port1.connect(scoreboard.item_collected_coverage2.analysis_export);
  endfunction  
  
endclass