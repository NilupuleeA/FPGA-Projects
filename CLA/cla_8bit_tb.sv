`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 01:56:34
// Design Name: 
// Module Name: cla_8bit_tb
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


module cla_8bit_tb();
    localparam CLK_PERIOD = 10;
    logic clk;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    localparam N = 8;

    logic [N-1:0] A, B, S;
    logic c_in, c_out;

    cla_8bit #(.N(N)) dut (.*);

    initial begin
        A <= 8'd5;
        B <= 8'd10;
        c_in <= 0;

        @(posedge clk);
        A <= 8'd30;
        B <= -8'd10;
        c_in <= 0;

        @(posedge clk);
        A <= 8'd5;
        B <= 8'd10;
        c_in <= 1;  

        @(posedge clk);
        A <= 8'd127;
        B <= -8'd1;
        c_in <= 0;    

        repeat(10) begin
            @(posedge clk);
            std::randomize(A) with{
                A inside {[-128:127]};
            };
            std::randomize(B) with{
                B inside {[-128:127]};
            };
            std::randomize(c_in);
        end
    end
endmodule
