`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2024 16:11:49
// Design Name: 
// Module Name: uart_rx_tb
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

module uart_rx_tb();
    timeunit 1ns/1ps;
    localparam CLOCKS_PER_PULSE = 16,
               W_OUT            = 16,
               BITS_PER_WORD    = 8,
               NUM_WORDS        = W_OUT / BITS_PER_WORD,
               CLK_PERIOD       = 10;

    logic clk = 0, rstn = 0, rx = 1, m_valid;
    logic [NUM_WORDS-1:0][BITS_PER_WORD-1:0] m_data, data;
    logic [BITS_PER_WORD+3-1:0] packet;
    logic parity_bit;

    initial forever #(CLK_PERIOD/2) clk <= !clk;

    uart_rx #(
        .CLOCKS_PER_PULSE(CLOCKS_PER_PULSE),
        .W_OUT(W_OUT),
        .BITS_PER_WORD(BITS_PER_WORD)
    ) dut (.*);

    initial begin
        // Reset sequence
        repeat(2) @(posedge clk) #1;
        rstn = 1;
        repeat(5) @(posedge clk) #1;

        repeat(10) begin
            // Generate random data
            data = $urandom();            

            for (int iw = 0; iw < NUM_WORDS; iw = iw + 1) begin
                // Construct the UART packet with start bit (0), data bits, and stop bit (1)
                parity_bit = ^data[iw];
                packet = {1'b1, parity_bit, data[iw], 1'b0};

                repeat ($urandom_range(1, 20)) @(posedge clk);

                for (int ib = 0; ib < BITS_PER_WORD + 3; ib = ib + 1) begin
                    repeat(CLOCKS_PER_PULSE) begin
                        #1 rx <= packet[ib];
                        @(posedge clk);
                    end
                end
            end
            repeat ($urandom_range(1, 100)) @(posedge clk);
        end
    end

    initial forever begin
        @(posedge clk)
        if (m_valid) begin
            if (m_data == data) 
                $display("OK, %b", m_data);
            else 
                $error("Sent %b, got %b", data, m_data);
        end
    end
endmodule
