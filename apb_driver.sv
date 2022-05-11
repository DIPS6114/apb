class apb_driver extends uvm_driver #(apb_seq_item);
  

  
  `uvm_component_utils(apb_driver)
  virtual apb_intf intf;
  
  apb_seq_item pkt;
  
  function new(string name="apb_driver",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual apb_intf)::get(this,"*", "apb_intf",intf);
  endfunction
  
  task reset();
    wait(!intf.prst);
    
           intf.psel<=0;
           intf.pen<=0;
	       intf.pwrite<=0;
           intf.paddr<=0;
           intf.pwdata<=0;
           intf.prdata<=0;
                 
         wait(intf.prst);
  endtask

  task run_phase(uvm_phase phase);
           reset();
           
      pkt=apb_seq_item::type_id::create("pkt");
    

    forever begin
      seq_item_port.get_next_item(pkt);
     
      drive(pkt);
   $display("PSEL=%0d,PEN=%0d",pkt.psel,pkt.pen);
      
      seq_item_port.item_done();
     
    end
endtask
  
  
  task drive(apb_seq_item pkt);
  @(posedge intf.pclk);
  
intf.psel<=0;
intf.pen<=0;
intf.pwrite<=0;
intf.paddr<=0;
intf.pwdata<=0;
intf.pready<=0;
intf.prdata<=0;
 

@(posedge intf.pclk);
  
intf.psel<=1;
intf.pen<=0;
intf.pwrite<=pkt.pwrite;
intf.paddr<=pkt.paddr;
intf.pwdata<=pkt.pwdata;
//intf.pready<=0;
//intf.prdata<=1;
  @(posedge intf.pclk);
  
intf.psel<=1;
intf.pen<=1;
intf.pwrite<=pkt.pwrite;
intf.paddr<=pkt.paddr;
intf.pwdata<=pkt.pwdata;
intf.pready<=1;    
 pkt.prdata<=intf.prdata;
//intf.pready<=0;
  @(posedge intf.pclk);
    
    /*`uvm_info("APB_DRIVER",$sformatf("pwdata=%0d",pkt.pwdata),UVM_LOW);
    `uvm_info("APB_DRIVER",$sformatf("paddr=%0d",pkt.paddr),UVM_LOW);
    `uvm_info("APB_DRIVER",$sformatf("prdata=%0d",pkt.prdata),UVM_LOW);
    `uvm_info("APB_DRIVER",$sformatf("pen=%0d",pkt.pen),UVM_LOW);
    `uvm_info("APB_DRIVER",$sformatf("psel=%0d",pkt.psel),UVM_LOW);
    `uvm_info("APB_DRIVER",$sformatf("pwrite=%0d",pkt.pwrite),UVM_LOW);*/
    
    `uvm_info("APB_DRIVER",$sformatf("pwdata=%0d,pwrite=%0d,paddr=%0d,pen=%0d,psel=%0d,prdata=%0d",pkt.pwdata,pkt.paddr,pkt.prdata,pkt.pen,pkt.psel,pkt.pwrite),UVM_LOW);
 
endtask
  
  
  


  
   


endclass