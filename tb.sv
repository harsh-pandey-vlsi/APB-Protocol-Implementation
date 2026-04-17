`timescale 1ns / 1ps

module tb;
  logic PCLK,PRESETn;
  logic start, write;
  logic [7:0]addr;
  logic [31:0]wdata;
  logic [31:0]rdata;
  logic done;
  
  apb_top dut (
    .PCLK(PCLK), .PRESETn(PRESETn),
    .start(start), .write(write),
    .addr(addr), .wdata(wdata),
    .rdata(rdata), .done(done)
);
  
  always #5 PCLK=~PCLK;
  
  task apb_write(input [7:0]a,input [31:0]d);
    begin
      @(posedge PCLK);
      start=1;write=1;
      addr=a;wdata=d;
      @(posedge PCLK);
      start=0;
      wait(done);
    end
  endtask
  
  task apb_read(input [7:0]a, output [31:0]d);
    begin
      @(posedge PCLK);
      start=1; write=0;
      addr=a;
      @(posedge PCLK);
      start=0;
      wait(done);
      d=rdata;
    end
  endtask
  
  initial begin
    logic [31:0] rd;
    PCLK=0;
    PRESETn=0;
    start=0;
    
    #20 PRESETn=1;
    apb_write(8'h10, 32'hA5A5A5A5);
    
    apb_read(8'h10, rd);
    
    if (rd==32'hA5A5A5A5)
      $display("PASS");
    else
      $display("FAIL");
    #50 $finish;
  end   
endmodule