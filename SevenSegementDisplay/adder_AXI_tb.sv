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

    // Parameters
    parameter WIDTH = 8;
    localparam CLK_PERIOD = 10; // Clock period in ns

    // Testbench signals
    logic clk = 0;
    logic rstn = 0;
    logic s_valid = 0;
    logic m_ready = 0;
    logic [WIDTH-1:0] s_data;
    logic m_valid;
    logic s_ready;
    logic [1:0][6:0] m_data;

    // Clock generation
    initial forever #(CLK_PERIOD / 2) clk = ~clk;

    // DUT instantiation
    adder_AXI #(.WIDTH(WIDTH)) dut (.* );

    initial begin
        // Initial reset
        rstn = 0;
        #20;
        rstn = 1;
        
        // Start test after reset
        #20;
        
        // Test stimulus
        repeat(10) begin
            @(posedge clk);
                s_data = $urandom_range(0, 10);
                s_valid = 1;
                m_ready = 1;
        end

        repeat(2) @(posedge clk); s_valid = 0;

        repeat(20) begin
            @(posedge clk);
                s_data = $urandom_range(0, 10);
                s_valid = 1;
        end
    end

    // Monitor output
    always @(posedge clk) begin
        if (m_valid && m_ready) begin
            $display("Time: %0t | Sum: %0d | m_data[0]: %b | m_data[1]: %b", 
                      $time, s_data, m_data[0], m_data[1]);
        end
    end

endmodule
