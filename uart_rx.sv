`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2024 13:43:56
// Design Name: 
// Module Name: uart_rx
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


module uart_rx #(
    parameter CLOCKS_PER_PULSE = 16,
              BITS_PER_WORD = 8,
              W_OUT 
)(
    input logic clk, rstn, rx,
    output logic m_valid,
    output logic [W_OUT-1:0] m_data
);
    localparam NUM_WORDS = W_OUT / BITS_PER_WORD;
    enum {IDLE, START, DATA, PARITY, END} state;

    //counters
    logic [$clog2(CLOCKS_PER_PULSE)-1:0] c_clocks;
    logic [$clog2(BITS_PER_WORD)   -1:0] c_bits  ;
    logic [$clog2(NUM_WORDS)       -1:0] c_words ;
    logic xor_parity;

    //state machine
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            {c_words, c_bits, c_clocks, m_valid, m_data} <= '0;
            state <= IDLE;
        end else begin
            m_valid <= 0;
            case(state)
                IDLE:   
                    if (rx == 0)
                        state <= START;

                START:  
                    if (c_clocks == CLOCKS_PER_PULSE/2-1) begin
                        state <= DATA;
                        c_clocks <= 0;
                    end else
                        c_clocks <= c_clocks + 1;

                DATA:   
                    if (c_clocks == CLOCKS_PER_PULSE-1) begin
                        c_clocks <= 0;
                        m_data <= {rx, m_data[W_OUT-1:1]};
                        if (c_bits == BITS_PER_WORD-1) begin
                            state <= PARITY;
                            c_bits <= 0;
                            if (c_words == NUM_WORDS-1) begin
                                m_valid <= 1;
                                c_words <= 0;
                            end else 
                                c_words <= c_words + 1;
                        end else 
                            c_bits <= c_bits + 1;  
                    end else 
                        c_clocks <= c_clocks + 1;    

                PARITY:
                    if (c_clocks == CLOCKS_PER_PULSE-1) begin
                        c_clocks <= 0;
                        xor_parity = ^m_data[BITS_PER_WORD +: BITS_PER_WORD];
                        if (rx == xor_parity) begin
                            state <= END;
                        end else 
                            state <= IDLE; 
                    end else 
                        c_clocks <= c_clocks + 1;    


                END:    
                    if (c_clocks == CLOCKS_PER_PULSE-1) begin
                        state <= IDLE;
                        c_clocks <= 0;
                    end else
                        c_clocks <= c_clocks + 1;        
            endcase
        end
    end
endmodule