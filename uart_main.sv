`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2024
// Design Name: 
// Module Name: uart_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: uart_rx.v, uart_tx.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module uart_main #(
    parameter CLOCKS_PER_PULSE = 5208,
              BITS_PER_WORD = 8,
              W_OUT = 16,
    localparam NUM_WORDS = W_OUT / BITS_PER_WORD
)(
    input logic clk,
    input logic rstn,
    input logic rx,
    input logic s_valid,
    input logic [NUM_WORDS-1:0][BITS_PER_WORD-1:0] s_data,
    output logic tx,
    output logic m_valid,
    output logic [W_OUT-1:0] m_data

);

    // Intermediate signals
    logic tx_ready;
    logic m;

    // RX instance
    uart_rx #(
        .CLOCKS_PER_PULSE(CLOCKS_PER_PULSE),
        .BITS_PER_WORD(BITS_PER_WORD),
        .W_OUT(W_OUT)
    ) uart_rx_inst (
        .clk(clk),
        .rstn(rstn),
        .rx(m),
        .m_valid(m_valid),
        .m_data(m_data)
    );

    // TX instance
    uart_tx #(
        .CLOCKS_PER_PULSE(CLOCKS_PER_PULSE),
        .BITS_PER_WORD(BITS_PER_WORD),
        .W_OUT(W_OUT)
    ) uart_tx_inst (
        .clk(clk),
        .rstn(rstn),
        .s_valid(s_valid),
        .s_data(s_data),
        .tx(m),
        .s_ready(tx_ready)
    );

endmodule
