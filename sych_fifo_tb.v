`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.09.2026 11:11:46
// Design Name: 
// Module Name: sych_fifo_tb
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

module sync_fifo_tb;

    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [7:0] din;

    wire [7:0] dout;
    wire full;
    wire empty;

    FIFO uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    initial
    begin
        clk = 0;
    end

    always #5 clk = ~clk;


    initial
    begin
        // RESET
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 0;

        #10;
        rst = 0;

        // SINGLE WRITE / READ

        din = 25;
        wr_en = 1;
        #10;
        wr_en = 0;

        rd_en = 1;
        #10;

        if (dout == 25)
            $display("PASS: Single Write/Read");
        else
            $display("FAIL: Single Write/Read");

        rd_en = 0;

        // RESET FOR NEXT TEST

        rst = 1;
        #10;
        rst = 0;


        // MULTIPLE VALUES / FIFO ORDER

        din = 10;
        wr_en = 1;
        #10;

        din = 20;
        #10;

        din = 30;
        #10;

        din = 40;
        #10;

        wr_en = 0;

        // Read 10
        rd_en = 1;
        #10;

        if (dout == 10)
            $display("PASS: Expected 10, Actual %d", dout);
        else
            $display("FAIL: Expected 10, Actual %d", dout);

        // Read 20
        #10;

        if (dout == 20)
            $display("PASS: Expected 20, Actual %d", dout);
        else
            $display("FAIL: Expected 20, Actual %d", dout);

        // Read 30
        #10;

        if (dout == 30)
            $display("PASS: Expected 30, Actual %d", dout);
        else
            $display("FAIL: Expected 30, Actual %d", dout);

        // Read 40
        #10;

        if (dout == 40)
            $display("PASS: Expected 40, Actual %d", dout);
        else
            $display("FAIL: Expected 40, Actual %d", dout);

        rd_en = 0;


        // FULL CONDITION

        rst = 1;
        #10;
        rst = 0;

        wr_en = 1;

        din = 1;   #10;
        din = 2;   #10;
        din = 3;   #10;
        din = 4;   #10;
        din = 5;   #10;
        din = 6;   #10;
        din = 7;   #10;
        din = 8;   #10;
        din = 9;   #10;
        din = 10;  #10;
        din = 11;  #10;
        din = 12;  #10;
        din = 13;  #10;
        din = 14;  #10;
        din = 15;  #10;
        din = 16;  #10;

        wr_en = 0;

        #1;

        if (full)
            $display("PASS: FIFO FULL");
        else
            $display("FAIL: FIFO should be FULL");


        // WRITE WHEN FULL

        din = 17;
        wr_en = 1;

        #10;

        wr_en = 0;

        if (full)
            $display("PASS: Write blocked when FULL");
        else
            $display("FAIL: Write protection failed");


        // EMPTY CONDITION

        rst = 1;
        #10;
        rst = 0;

        #1;

        if (empty)
            $display("PASS: FIFO EMPTY");
        else
            $display("FAIL: FIFO should be EMPTY");


        // READ WHEN EMPTY

        rd_en = 1;
        #10;

        rd_en = 0;

        if (empty)
            $display("PASS: Read blocked when EMPTY");
        else
            $display("FAIL: Read protection failed");


        // POINTER WRAPAROUND

        rst = 1;
        #10;
        rst = 0;

        // Write 1 to 16
        wr_en = 1;

        din = 1;   #10;
        din = 2;   #10;
        din = 3;   #10;
        din = 4;   #10;
        din = 5;   #10;
        din = 6;   #10;
        din = 7;   #10;
        din = 8;   #10;
        din = 9;   #10;
        din = 10;  #10;
        din = 11;  #10;
        din = 12;  #10;
        din = 13;  #10;
        din = 14;  #10;
        din = 15;  #10;
        din = 16;  #10;

        wr_en = 0;

        // Read 1 to 8
        rd_en = 1;

        #10;
        #10;
        #10;
        #10;
        #10;
        #10;
        #10;
        #10;

        rd_en = 0;

        // Write 17 to 24
        wr_en = 1;

        din = 17;  #10;
        din = 18;  #10;
        din = 19;  #10;
        din = 20;  #10;
        din = 21;  #10;
        din = 22;  #10;
        din = 23;  #10;
        din = 24;  #10;

        wr_en = 0;


        #20;
        $finish;

    end

endmodule