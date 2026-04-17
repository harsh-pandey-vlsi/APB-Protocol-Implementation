`timescale 1ns / 1ps

module apb_master(
  input wire PCLK,PRESETn,
  output reg PSEL,PENABLE,PWRITE,
  output reg [7:0]PADDR,
  output reg [31:0]PWDATA,
  input wire [31:0]PRDATA,
  input wire PREADY,
  
  input wire start,
  input wire write,
  input wire [7:0]addr,
  input wire [31:0]wdata,
  output reg [31:0]rdata,
  output reg done
);
  
  typedef enum reg [1:0]{IDLE,SETUP,ENABLE}state_t;
  state_t state;
  
  always @(posedge PCLK or negedge PRESETn) begin
    if(!PRESETn) begin
      state<=IDLE;
      PSEL<=0;
      PENABLE<=0;
      done<=0;
    end else begin
      case(state)
        IDLE:begin
          done<=0;
          if(start) begin
            PSEL<=1;
            PWRITE<=write;
            PADDR<=addr;
            PWDATA<=wdata;
            state<=SETUP;
          end
        end
        SETUP:begin
          PENABLE<=1;
          state<=ENABLE;
        end
        ENABLE:begin
          if(PREADY) begin
            if(!PWRITE)
              rdata<=PRDATA;
            PSEL<=0;
            PENABLE<=0;
            done<=1;
            state<=IDLE;
          end
        end
      endcase
    end
  end
endmodule