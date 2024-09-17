`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2024 11:03:50
// Design Name: 
// Module Name: junction_3way_tb
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


module junction_3way_tb();
    logic R1, R2, R3, R4, R5, R6, 
           A1, A2, A3, A4, A5, A6, 
           G1, G2, G3, G4, G5, G6;
    logic clk, rstn;

    localparam CLK_PERIOD = 5;

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    junction_3way dut (.*);

    initial begin
        rstn <= 0;
    
    @(posedge clk);
    rstn <= 1; 
    end

endmodule

