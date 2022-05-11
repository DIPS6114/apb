import uvm_pkg::*;
`include "uvm_macros.svh"
`include "interface.sv"
`include "apb_test.sv"




module top;
  
  bit pclk;
  bit prst;
  
  
  always #5pclk=~pclk;
  
  initial begin
    prst=0;
    #5 prst=1;
  end
  
  
  apb_intf intf(pclk,prst);
  
  initial begin
    uvm_config_db#(virtual apb_intf)::set(uvm_root::get(),"*","apb_intf",intf);
  end
  
  
  apb_slave dut(
    .pclk(intf.pclk),
    .prst(intf.prst),
    .paddr(intf.paddr),
    .pwdata(intf.pwdata),
    .pwrite(intf.pwrite),
    .psel(intf.psel),
    .pen(intf.pen),
    .pready(intf.pready),
    .prdata(intf.prdata)
  );
  

  
  
  
  initial begin
    run_test("apb_test");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
endmodule