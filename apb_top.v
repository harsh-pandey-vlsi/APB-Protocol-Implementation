`timescale 1ns / 1ps
module apb_top(
  input wire PCLK,PRESETn,
  input wire start,write,
  input wire [7:0]addr,
  input wire [31:0]wdata,
  output wire [31:0]rdata,
  output wire done
);
  wire PSEL,PENABLE,PWRITE;
  wire [7:0]PADDR;
  wire [31:0]PWDATA,PRDATA;
  wire PREADY;
  
  apb_master master (
    .PCLK(PCLK), .PRESETn(PRESETn),
    .PSEL(PSEL), .PENABLE(PENABLE), .PWRITE(PWRITE),
    .PADDR(PADDR), .PWDATA(PWDATA),
    .PRDATA(PRDATA), .PREADY(PREADY),
    .start(start), .write(write),
    .addr(addr), .wdata(wdata),
    .rdata(rdata), .done(done)
  );
  apb_slave slave (
    .PCLK(PCLK), .PRESETn(PRESETn),
    .PSEL(PSEL), .PENABLE(PENABLE),
    .PWRITE(PWRITE), .PADDR(PADDR),
    .PWDATA(PWDATA), .PRDATA(PRDATA),
    .PREADY(PREADY)
  );
  
endmodule
