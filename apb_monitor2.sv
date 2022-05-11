class apb_monitor2 extends uvm_monitor;
  
  `uvm_component_utils(apb_monitor2)
  
  
  apb_seq_item packet1;
  
  virtual apb_intf intf;
  
  uvm_analysis_port #(apb_seq_item)item_collected_port1;
  
  
 
  
  function new(string name="apb_monitor2",uvm_component parent=null);
    super.new(name,parent);
    item_collected_port1=new("item_collected_port1",this);
  endfunction
  
   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     uvm_config_db#(virtual apb_intf)::get(this,"*", "apb_intf",intf);
  endfunction
  
   task run_phase(uvm_phase phase);
     packet1=apb_seq_item::type_id::create("packet1");
     forever begin
       @(posedge intf.pclk);
       packet1.paddr<=intf.paddr;
       packet1.pwdata<=intf.pwdata;
       packet1.pwrite<=intf.pwrite;
       packet1.psel<=intf.psel;
       packet1.pen<=intf.pen;
       packet1.prdata<=intf.prdata;
       packet1.pready<=intf.pready;
      /* $display("[MONITOR_2]:paddr=%0d,pwdata=%0d,pwrite=%0d,psel=%0d,pen=%0d,prdata=%0d,pready=%0d",packet1.paddr,packet1.pwdata,packet1.pwrite,packet1.psel,packet1.pen,packet1.prdata,packet1.pready);*/
       
       `uvm_info("APB_MONITOR_2",$sformatf("pwdata=%0d,pwrite=%0d,paddr=%0d,pen=%0d,psel=%0d,prdata=%0d",packet1.pwdata,packet1.paddr,packet1.prdata,packet1.pen,packet1.psel,packet1.pwrite),UVM_LOW);
       
       
       item_collected_port1.write(packet1);
       
     end
   endtask

  
  
endclass