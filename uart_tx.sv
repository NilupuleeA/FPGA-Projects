`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2024 21:20:52
// Design Name: 
// Module Name: uart_tx
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


module uart_tx #(
    parameter CLOCKS_PER_PULSE = 16,
              BITS_PER_WORD = 8,
              PACKET_SIZE = BITS_PER_WORD + 5,
              W_OUT 
)(
    input logic clk, rstn, s_valid,
    input logic [NUM_WORDS-1:0][BITS_PER_WORD-1:0] s_data,
    output logic tx, s_ready
);
    localparam NUM_WORDS = W_OUT / BITS_PER_WORD;
    enum {IDLE, SEND} state;

    logic [NUM_WORDS-1:0][PACKET_SIZE-1:0] s_packets;
    logic [NUM_WORDS*PACKET_SIZE     -1:0] m_packets;
    logic parity_bit;

    //counters
    logic [$clog2(CLOCKS_PER_PULSE)     -1:0] c_clocks;
    logic [$clog2(NUM_WORDS*PACKET_SIZE)-1:0] c_pulses;

    always_comb begin
        s_packets = '1; // fill s packet with ones
        for (int iw = 0; iw < NUM_WORDS; iw = iw + 1) begin  //calculate parity bit for each word
            parity_bit = ^s_data[iw]; 
            s_packets[iw][BITS_PER_WORD+1:0] = {parity_bit, s_data[iw], 1'b0}; 
            end
        tx = m_packets[0];   //assign tx with data to be send
    end

    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin     
            state <= IDLE;
            m_packets <= '1;
            {c_pulses, c_clocks} <= 0;
        end else
            case(state)
                IDLE: 
                    if (s_valid) begin
                        state <= SEND;
                        m_packets <= s_packets;
                    end

                SEND:
                    if (c_clocks == CLOCKS_PER_PULSE-1) begin
                        c_clocks = 0;
                        if (c_pulses == NUM_WORDS*PACKET_SIZE-1) begin
                            c_pulses <= 0;
                            m_packets <= '1;
                            state <= IDLE;
                        end else begin
                            c_pulses <= c_pulses+1;
                            m_packets <= (m_packets >> 1);
                        end
                    end else c_clocks <= c_clocks + 1;
            endcase
    end
    assign s_ready = (state == IDLE);                          
endmodule
