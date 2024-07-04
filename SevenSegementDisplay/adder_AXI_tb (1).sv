`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2024 11:52:03
// Design Name: 
// Module Name: adder_AXI_tb
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


module adder_AXI_tb();

    logic clk = 0, rstn = 0;
    localparam CLK_PERIOD = 10;
    
    initial forever #(CLK_PERIOD/2) clk <= ~clk;
    
    parameter N = 8, WIDTH = 8;
    logic [WIDTH-1:0] s_data;
    logic [1:0][6:0] m_data;
    logic s_valid, s_ready, m_valid, m_ready;
    
    adder_AXI #(.N(N), .WIDTH(WIDTH)) dut (.*);
    
    initial begin
        repeat(2) @(posedge clk) #1;
        rstn = 1;
        repeat(5) @(posedge clk) #1;
        
        s_valid = 0;
        m_ready = 0;
    end
    
    // Generate s_data continuously when s_ready is asserted
    always @(posedge clk) begin
        if (rstn) begin
            s_data <= $urandom_range(1,10);
            s_valid <= 1;
            m_ready <= 1;
        end
    end
    
endmodule
