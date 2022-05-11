class apb_scoreboard extends uvm_scoreboard;
  
   `uvm_component_utils(apb_scoreboard)
  
  apb_seq_item packet,packet1;
  
  reg [7:0] rmem[256];
  reg [7:0] rprdata;
  bit pclk;
    
  
 uvm_tlm_analysis_fifo #(apb_seq_item) item_collected_monitor1;
 uvm_tlm_analysis_fifo #(apb_seq_item) item_collected_monitor2;
  
  uvm_tlm_analysis_fifo #(apb_seq_item)item_collected_coverage1;
  uvm_tlm_analysis_fifo #(apb_seq_item)item_collected_coverage2; 
  
  covergroup cov_grp @(posedge pclk);
      PSEL   :coverpoint packet.psel;
      PENABLE:coverpoint packet.pen;
      PWRITE :coverpoint packet.pwrite;
      PADDR  :coverpoint packet.paddr;
      PWDATA :coverpoint packet.pwdata;
     
    endgroup
 
  
  function new(string name="apb_scoreboard",uvm_component parent=null);
    super.new(name,parent);
    cov_grp=new();
  endfunction
  
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_monitor1 = new("item_collected_monitor1", this);
    item_collected_monitor2 = new("item_collected_monitor2", this);
    
    item_collected_coverage1 =new("item_collected_coverage1",this);
    item_collected_coverage2 =new("item_collected_coverage2",this);
    
    packet=apb_seq_item::type_id::create("packet",this);
    packet1=apb_seq_item::type_id::create("packet1",this);
    
  endfunction
  
  
  task run_phase(uvm_phase phase);
    forever begin
      
         
         // fork process1
          item_collected_monitor1.get(packet);
         // packet.display("SCB_INPUT");
       main();
          
          //fork process_2
          
          item_collected_monitor2.get(packet1);
          //packet1.display("SCB_OUTPUT");
        end
    
       
    item_collected_coverage1.get(packet);
    item_collected_coverage2.get(packet1);
         
          cov_grp.sample();
    
  endtask
      
      
  task main();
    if (packet.psel==1 && packet.pen==1 && packet.pwrite==1) begin
      rmem[packet.paddr] <= packet.pwdata;
    end
    else if (packet.psel==1 && packet.pen==1 && packet.pwrite==0) begin
      rprdata <= rmem[packet.paddr];
    end
    else
    begin
      rprdata<=0;
    end
    
    if(rprdata==packet1.prdata)begin
     // $display("------------pass------------");
     // $display("rprdata=%0d,prdata=%0d",rprdata,packet1.prdata);
      
      `uvm_info("APB_SCOREBOARD",$sformatf("------ :: pass :: ------"),UVM_LOW);
      `uvm_info("APB_SCOREBOARD",$sformatf("rprdata=%0d,prdata=%0d",rprdata,packet1.prdata),UVM_LOW);
    end
    else begin
     // $display("------------fail------------");
      //$display("rprdata=%0d,prdata=%0d",rprdata,packet1.prdata);
      
      `uvm_info("APB_SCOREBOARD", $sformatf("------ :: failed :: ------"),UVM_LOW);
      `uvm_info("APB_SCOREBOARD", $sformatf("rprdata=%0d,prdata=%0d",rprdata,packet1.prdata),UVM_LOW);
    end
    
  endtask
  
endclass
  
 
  
           
           
     
           

   
           
           
        
       
      
        
        
      
     
      
     


  
  