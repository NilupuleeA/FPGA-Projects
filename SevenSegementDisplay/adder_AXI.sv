`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2024 10:47:08
// Design Name: 
// Module Name: adder_AXI
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


module adder_AXI #(
    parameter N = 10,
    parameter WIDTH = 8
) (
    input logic clk, 
    input logic rstn,
    input logic s_valid, 
    input logic m_ready,
    input logic [WIDTH-1:0] s_data,
    output logic m_valid, 
    output logic s_ready,
    output logic [1:0][6:0] m_data
);

    // Internal signals
    logic [WIDTH + $clog2(N) - 1:0] sum;
    logic [3:0] modulo_result, remainder_result;

    // Seven segment display function
    function [6:0] sevenSegment(
        input logic [3:0] X
    );
        logic [6:0] Y;
        begin
            case (X)
                4'd0: Y = 0; //7'b0111111; // 0
                4'd1: Y = 1; //7'b0000110; // 1
                4'd2: Y = 2; //7'b1011011; // 2
                4'd3: Y = 3; //7'b1001111; // 3
                4'd4: Y = 4; //7'b1100110; // 4
                4'd5: Y = 5; //7'b1101101; // 5
                4'd6: Y = 6; //7'b1111101; // 6
                4'd7: Y = 7; //7'b0000111; // 7
                4'd8: Y = 8; //7'b1111111; // 8
                4'd9: Y = 9; //7'b1101111; // 9
                default: Y = 7'b100000; // Default to all off
            endcase
            sevenSegment = Y;
        end
    endfunction

    // Sequential logic for sum
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            sum <= 0;
            m_valid <= 0;
            s_ready <= 1; // Ready to receive data
        end else begin
            if (s_valid && s_ready) begin
                sum <= sum + s_data;
                m_valid <= 1;
            end else if (m_ready && m_valid) begin
                m_valid <= 0;
            end
        end
    end

    // Combinational logic for output
    always_comb begin
        modulo_result = sum % 10;
        remainder_result = sum / 10;
        m_data[0] = sevenSegment(modulo_result);
        m_data[1] = sevenSegment(remainder_result);
    end

endmodule
