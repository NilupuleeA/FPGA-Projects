`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 02:08:42
// Design Name: 
// Module Name: cla_32bit_tb
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


module cla_32bit_tb();
    localparam CLK_PERIOD = 10;
    logic clk;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    localparam N = 32;

    logic [N-1:0] A, B, S;
    logic c_in, c_out;

    cla_32bit #(.N(N)) dut (.*);

    initial begin
        A <= 32'd5;
        B <= 32'd10;
        c_in <= 0;

        @(posedge clk);
        A <= 32'd30;
        B <= -32'd10;
        c_in <= 0;

        @(posedge clk);
        A <= 32'd5;
        B <= 32'd10;
        c_in <= 1;  

        @(posedge clk);
        A <= 32'd127;
        B <= -32'd1;
        c_in <= 0;    

        repeat(10) begin
            @(posedge clk);
            std::randomize(A) with{
                A inside {[-2**31:2**31-1]};
            };
            std::randomize(B) with{
                B inside {[-2**31:2**31-1]};
            };
            std::randomize(c_in);
        end
    end
endmodule
