`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2024 11:40:08
// Design Name: 
// Module Name: ex_1_tb
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

module sequ_detector_tb();
    localparam CLK_PERIOD       = 10;

    logic clk = 0, rstn = 0, rx, y;

    initial forever #(CLK_PERIOD/2) clk <= !clk;

    ex_1 dut (.*);

    initial begin
        repeat(2) @(posedge clk) #1;
        rstn = 1;
        repeat(5) @(posedge clk) #1;
    end
    
    // Generate s_data continuously when s_ready is asserted
    always @(posedge clk) begin
        if (rstn) begin
            rx <= $urandom;
        end
    end
endmodule
