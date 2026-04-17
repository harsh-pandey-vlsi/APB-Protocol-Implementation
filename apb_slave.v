`timescale 1ns / 1ps
module apb_slave(
  input wire PCLK,PRESETn,
  input wire PSEL,PENABLE,PWRITE,
  input wire [7:0]PADDR,
  input wire [31:0]PWDATA,
  output reg [31:0]PRDATA,
  output reg PREADY
);
  reg [31:0]mem[0:255];
  always @(posedge PCLK or negedge PRESETn) begin
    if(!PRESETn) begin
      PREADY<=0;
    end else begin
      if(PSEL && PENABLE) begin
        PREADY<=1;
        if(PWRITE)
          mem[PADDR]<=PWDATA;
        else
          PRDATA<=mem[PADDR];
      end else begin
        PREADY<=0;
      end
    end
  end
endmodule