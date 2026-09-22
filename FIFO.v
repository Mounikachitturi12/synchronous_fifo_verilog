`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2026 15:59:57
// Design Name: 
// Module Name: FIFO
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FIFO(
    input wr_en,
    input rd_en,
    input clk,
    input rst,
    input [7:0] din,
    output reg[7:0] dout,
    output empty,
    output full
    );
    reg[3:0] wr_ptr;
    reg[3:0] rd_ptr;
    reg[4:0] count;
    // FIFO memory: 16 locations, 8 bits each
    reg[7:0]mem[15:0];
    assign empty=(count==0);
    assign full=(count==16);
    always@(posedge clk)
    begin
      if (rst)
      begin
         count=0;
         wr_ptr=0;
          rd_ptr=0;
         dout=0;
      end
      else
      begin
      // Write operation
      if(wr_en && !full)
      begin
       mem [wr_ptr]<= din;
       wr_ptr = wr_ptr + 1;
      end
      if(rd_en && !empty)
            begin
             // Read operation
             dout<=mem[rd_ptr] ;
             rd_ptr = rd_ptr + 1;
            end
        // Update FIFO count
        if((wr_en && !full)&& !(rd_en && !empty)) 
        count = count + 1 ;
         if (!(wr_en && !full)&& (rd_en && !empty))
         count = count - 1;
    end
    end
endmodule
