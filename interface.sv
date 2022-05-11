

interface apb_intf(input bit pclk,prst);
 

  logic       [7:0]  paddr;
  logic              pwrite;
  logic              psel;
  logic              pen;
  logic       [7:0] pwdata;
  logic        [7:0] prdata;
  logic              pready;
  
  
   sequence setup_phase_s;
       $rose(psel) and $rose(pwrite) and (!pen) and (!pready);
   endsequence
  
     
   sequence access_phase_s;
    $rose(pen) and $rose(pready) and $stable(pwrite) and $stable(pwdata)and $stable(paddr) and $stable(psel);
   endsequence
 
  property access_to_setup_p; 
    @(posedge pclk) disable iff (prst) 
    setup_phase_s |=> access_phase_s;
  endproperty
  
  assert property (access_to_setup_p)
   $display("%t , Prperty asserted psel = %b, pen = %b,pwrite = %b", $time(), psel,pen,pwrite);
    else
      $display("%t , Property failed psel = %b, pen = %b,pwrite = %b", $time(), psel,pen,pwrite);
    
  
   sequence idle;
     @(posedge pclk) psel && pen && pwrite ==0;
  endsequence
  
  a_1: assert property(idle)
    $display("%t , Prperty asseretd psel = %b, pen = %b,pwrite = %b", $time(), psel,pen,pwrite);
    else
      $display("%t , Property failed psel = %b, pen = %b,pwrite = %b", $time(), psel,pen,pwrite);
   
  
    
   sequence setup;
     @(posedge pclk) psel && !pen && pwrite && !pready == 1;
   endsequence
  
    a_2: assert property(setup)
       $display("%t , Prperty asserted psel = %b, pen = %b,pwrite = %b", $time(), psel,pen,pwrite);
    else
      $display("%t , Property failed psel = %b, pen = %b,pwrite = %b", $time(), psel,pen,pwrite);
      
      
      sequence acess;
        @(posedge pclk) psel && pen && pwrite && pready == 1;
   endsequence
  
      a_3: assert property(acess)
         $display("%t , Prperty asserted psel = %b, pen = %b,pwrite = %b", $time(), psel,pen,pwrite);
        else
        $display("%t , Property failed psel = %b, pen = %b,pwrite = %b", $time(), psel,pen,pwrite);
        
        sequence seq;
          @(posedge pclk) psel && pwrite ##2 pen && pready;
        endsequence
        
        a_4:assert property(seq)
          $display("%t , Prperty asserted psel = %b, pen = %b,pwrite = %b,pready =%b", $time(), psel,pen,pwrite,pready);
        else
          $display("%t , Property failed psel = %b, pen = %b,pwrite = %b", $time(), psel,pen,pwrite,pready);
          
        
 
  
  
endinterface 