`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 02:05:16
// Design Name: 
// Module Name: cla_32bit
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


module cla_32bit #(
    parameter N = 32
)(
    input logic [N-1:0] A,
    input logic [N-1:0] B,
    input logic c_in,
    output logic [N-1:0] S,
    output logic c_out
);

    logic [N:0] C;
    assign C[0] = c_in;
    assign c_out = C[N];

    generate
        for (genvar i = 0; i < 4; ++i) begin: add
            cla_8bit cla8(
                .A(A[i*8+7:i*8]),
                .B(B[i*8+7:i*8]),
                //.CLK(clk),
                .c_in(C[i*8]),
                .c_out(C[i*8+8]),
                .S(S[i*8+7:i*8])
            );            
        end
    endgenerate
endmodule
