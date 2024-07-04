`timescale 1ns / 1ps
<<<<<<< Updated upstream
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
=======

module adder_AXI_tb();

    // Parameters
    parameter N = 10;
>>>>>>> Stashed changes
    parameter WIDTH = 8;
    localparam CLK_PERIOD = 10; // Clock period in ns

    // Testbench signals
    logic clk = 0;
<<<<<<< Updated upstream
    logic rstn = 0;
    logic s_valid = 0;
    logic m_ready = 0;
=======
    logic rstn;
    logic s_valid;
    logic m_ready;
>>>>>>> Stashed changes
    logic [WIDTH-1:0] s_data;
    logic m_valid;
    logic s_ready;
    logic [1:0][6:0] m_data;

    // Clock generation
    initial forever #(CLK_PERIOD / 2) clk = ~clk;

    // DUT instantiation
<<<<<<< Updated upstream
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
                s_data = $urandom_range(0, 255);
                s_valid = 1;
                m_ready = 1;
        end

        repeat(2) @(posedge clk); s_valid = 0;

        repeat(20) begin
            @(posedge clk);
                s_data = $urandom_range(0, 255);
                s_valid = 1;
        end
    end

    // Monitor output
    always @(posedge clk) begin
        if (m_valid && m_ready) begin
            $display("Time: %0t | Sum: %0d | m_data[0]: %b | m_data[1]: %b", 
=======
    adder_AXI #(.N(N), .WIDTH(WIDTH)) dut (
        .clk(clk),
        .rstn(rstn),
        .s_valid(s_valid),
        .m_ready(m_ready),
        .s_data(s_data),
        .m_valid(m_valid),
        .s_ready(s_ready),
        .m_data(m_data)
    );

    initial begin
        // Initialize signals
        rstn = 0;
        s_valid = 0;
        m_ready = 0;
        s_data = 0;

        // Apply reset
        #20;
        rstn = 1;

        // Apply test stimuli
        @(posedge clk);
        s_data = 8'h12; // Example data
        s_valid = 1;
        m_ready = 1;
        @(posedge clk);
        s_valid = 0;

        @(posedge clk);
        s_data = 8'h34; // Example data
        s_valid = 1;
        @(posedge clk);
        s_valid = 0;

        // Wait for outputs to stabilize
        #50;

        // Finish simulation
        $finish;
    end
    
    repeat(N)

    // Monitor output
    always @(posedge clk) begin
        if (m_valid) begin
            $display("Time: %0t | Sum: %0d | m_data[0]: %0b | m_data[1]: %0b", 
>>>>>>> Stashed changes
                      $time, s_data, m_data[0], m_data[1]);
        end
    end

endmodule
