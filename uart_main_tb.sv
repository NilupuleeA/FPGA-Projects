`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2024
// Design Name: 
// Module Name: uart_top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: uart_rx.v, uart_tx.v, uart_top.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module uart_main_tb();
    timeunit 1ns/1ps;
    localparam CLOCKS_PER_PULSE = 16,
               W_OUT            = 16,
               BITS_PER_WORD    = 8,
               NUM_WORDS        = W_OUT / BITS_PER_WORD,
               CLK_PERIOD       = 10;

    logic clk = 0, rstn = 0, rx, s_valid, m_valid;
    logic [NUM_WORDS-1:0][BITS_PER_WORD-1:0] s_data;
    logic [W_OUT-1:0] m_data;
    logic tx;

    // Clock generation
    initial forever #(CLK_PERIOD/2) clk <= !clk;

    // Instantiate the UART top module
    uart_main #(
        .CLOCKS_PER_PULSE(CLOCKS_PER_PULSE),
        .W_OUT(W_OUT),
        .BITS_PER_WORD(BITS_PER_WORD)
    ) dut (
        .clk(clk),
        .rstn(rstn),
        .rx(rx),
        .s_valid(s_valid),
        .s_data(s_data),
        .tx(tx),
        .m_valid(m_valid),
        .m_data(m_data)
    );

    // Test sequence
    initial begin
        // Reset sequence
        rstn = 0;
        s_valid = 0;
        rx = 1;
        repeat(2) @(posedge clk);
        rstn = 1;
        repeat(5) @(posedge clk);

        // Send multiple packets
        repeat(10) @(posedge clk);
            // Generate random data to send
            s_data = $urandom;

            // Transmit data
            @(posedge clk) s_valid = 1;
            #(20);
            @(posedge clk) s_valid = 0;

            // Wait for data to be received
            wait(m_valid);

            if (m_valid) begin
                if (m_data == s_data) 
                    $display("OK, %b", m_data);
                else 
                    $error("Sent %b, got %b", s_data, m_data);
            end

            // Delay before sending next packet (optional)
            #(10);

            s_data = $urandom;
            #(800);

            //Transmit data
            @(posedge clk) s_valid = 1;
            #(20);
            @(posedge clk) s_valid = 0;

            // Wait for data to be received
            wait(m_valid);

            if (m_valid) begin
                if (m_data == s_data) 
                    $display("OK, %b", m_data);
                else 
                    $error("Sent %b, got %b", s_data, m_data);
            end
    end

    // RX emulation: connect tx to rx with delay
    initial begin
        forever begin
            #1 rx = tx;
        end
    end
endmodule
