class apb_sequence extends uvm_sequence #(apb_seq_item);
  
  `uvm_object_utils(apb_sequence)
  
  apb_seq_item pkt;
  
  function new(string name="apb_sequence");
    super.new(name);
  endfunction
	
	task body();
      repeat(4) begin
        pkt=apb_seq_item::type_id::create("pkt");
        start_item(pkt);
        //pkt.randomize();
        assert(pkt.randomize()with{paddr inside {[1:4]};pkt.pwrite==1;pkt.psel==1;pkt.pen==0;});
        finish_item(pkt);
        end
      
      repeat(4) begin
       pkt=apb_seq_item::type_id::create("pkt");
        start_item(pkt);
        //pkt.randomize();
        assert(pkt.randomize()with{paddr inside {[1:4]}; pkt.pwrite==0;pkt.psel==1;pkt.pen==1;pwdata==0;});
        finish_item(pkt);

        
        end
    endtask
  
   
  
endclass