`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2024 04:55:30
// Design Name: 
// Module Name: uart_tx_tb
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


module uart_tx_tb();
    timeunit 1ns/1ps;
    localparam CLOCKS_PER_PULSE = 16,
               W_OUT            = 16,
               BITS_PER_WORD    = 8,
               PACKET_SIZE      = BITS_PER_WORD + 5,
               NUM_WORDS        = W_OUT / BITS_PER_WORD,
               CLK_PERIOD       = 10;

    logic clk = 0, rstn = 0, tx, s_valid, s_ready, parity_bit;
    logic [NUM_WORDS-1:0][BITS_PER_WORD-1:0] s_data, rx_data;
    logic [BITS_PER_WORD-1:0] rx_word;

    initial forever #(CLK_PERIOD/2) clk <= !clk;

    uart_tx #(
        .CLOCKS_PER_PULSE(CLOCKS_PER_PULSE),
        .W_OUT(W_OUT),
        .BITS_PER_WORD(BITS_PER_WORD),
        .PACKET_SIZE(PACKET_SIZE)
    ) dut (.*);

    initial begin
        #20 rstn = 1;
        repeat(5) @(posedge clk) #1;

        repeat(10) begin
            repeat ($urandom_range(1, 20)) @(posedge clk);
            wait (s_ready);

            @(posedge clk) #1 s_data = $urandom(); s_valid = 1;
            @(posedge clk) #1 s_valid = 0;
            wait (s_ready);
        end
    end

    logic sample = 1;

    initial forever begin
        rx_data <= 'x;
        for (int iw = 0; iw < NUM_WORDS; iw = iw + 1) begin
            wait(!tx);
            sample = 0;
            repeat (CLOCKS_PER_PULSE/2) @(posedge clk);
            sample = !sample;

            for (int ib = 0; ib < BITS_PER_WORD; ib = ib + 1) begin
                repeat(CLOCKS_PER_PULSE) @(posedge clk);
                rx_word[ib] = tx;
                sample = !sample;
            end
            rx_data[iw] = rx_word;

            repeat(CLOCKS_PER_PULSE) @(posedge clk); parity_bit = tx;
            if (parity_bit!=^rx_word)
                $error("Incorrect parity bit");                                

            for (int ib = 0; ib < PACKET_SIZE-BITS_PER_WORD-2; ib = ib + 1) begin
                repeat(CLOCKS_PER_PULSE) @(posedge clk);
                assert (tx==1) else $error("Incorrect end bits/padding");
                sample = !sample;
            end
        end

        assert (rx_data==s_data) $display("OK, %b", rx_data);
        else $error("Sent %b, got %b", s_data, rx_data);
    end
endmodule
