class apb_monitor1 extends uvm_monitor;
  
  `uvm_component_utils(apb_monitor1)
  
  
  apb_seq_item packet;
  
  virtual apb_intf intf;
  
  uvm_analysis_port #(apb_seq_item)item_collected_port;
  
  
 
  
  function new(string name="apb_monitor1",uvm_component parent=null);
    super.new(name,parent);
    item_collected_port=new("item_collected_port",this);
  endfunction
  
   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     uvm_config_db#(virtual apb_intf)::get(this,"*", "apb_intf",intf);
  endfunction
  
   task run_phase(uvm_phase phase);
    packet=apb_seq_item::type_id::create("packet");
     forever begin
       @(posedge intf.pclk);
       packet.paddr<=intf.paddr;
       packet.pwdata<=intf.pwdata;
       packet.pwrite<=intf.pwrite;
       packet.psel<=intf.psel;
       packet.pen<=intf.pen;
       packet.prdata<=intf.prdata;
       packet.pready<=intf.pready;
       
      /* $display("[MONITOR_1]:paddr=%0d,pwdata=%0d,pwrite=%0d,psel=%0d,pen=%0d,prdata=%0d,pready=%0d",packet.paddr,packet.pwdata,packet.pwrite,packet.psel,packet.pen,packet.prdata,packet.pready);
      */
       
       `uvm_info("APB_monitor_1",$sformatf("pwdata=%0d,pwrite=%0d,paddr=%0d,pen=%0d,psel=%0d,prdata=%0d",packet.pwdata,packet.paddr,packet.prdata,packet.pen,packet.psel,packet.pwrite),UVM_LOW);
       
       item_collected_port.write(packet);
       
     end
   endtask

  
  
endclass