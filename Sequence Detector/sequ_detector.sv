`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2024 09:34:36
// Design Name: 
// Module Name: ex_1
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


module sequ_detector (
    input logic clk, rstn, rx,
    output logic y
);
    enum {A, B, C, D} state;

    //state machine
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            y <= '0;
            state <= A;
        end else begin
            y <= '0;
            case(state)
                A:  
                    if (rx == 0) begin
                        state <= B;
                    end 

                B:  
                    if (rx == 1) begin
                        state <= C;
                    end

                C:  
                    if (rx == 1) 
                        state <= D;
                    else
                        state <= B;

                D:    
                    if (rx == 1) begin
                        state <= A;
                    end else begin
                        state <= A;
                        y <= 1; 
                    end
            endcase
        end
    end
endmodule