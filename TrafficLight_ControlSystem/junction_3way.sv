`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2024 01:38:57
// Design Name: 
// Module Name: junction_3way
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 3-way traffic light controller
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comment+s:
// 
//////////////////////////////////////////////////////////////////////////////////

module junction_3way(
    input logic clk, rstn, 
    output logic R1, R2, R3, R4, R5, R6, 
           A1, A2, A3, A4, A5, A6, 
           G1, G2, G3, G4, G5, G6
);

    typedef enum logic [3:0] {
        RA_S1, G_S1, A_S1, R_S1, 
        RA_S2, G_S2, A_S2, R_S2, 
        RA_S3, G_S3, A_S3, R_S3
    } state_t;

    state_t state;

    // counters
    logic [31:0] count;

    // state machine
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            {R1, R2, R3, R4, R5, R6, 
             A1, A2, A3, A4, A5, A6, 
             G1, G2, G3, G4, G5, G6} <= '0;
            state <= G_S1;
            count <= 0;
        end else begin
            case(state)
                G_S1: begin
                    if (count[31]) begin
                        state <= A_S1;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {R1, G2, R3, R4, G5, G6} <= '1;
                    {A1, G1, R2, A2, A3, G3, A4, G4, R5, A5, R6, A6} <= '0;
                end

                A_S1: begin
                    if (count[26]) begin
                        state <= R_S1;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {R1, A2, R3, R4, A5, G6} <= '1;
                    {A1, G1, R2, G2, A3, G3, A4, G4, R5, G5, R6, A6} <= '0;
                end

                R_S1: begin
                    if (count[26]) begin
                        state <= RA_S2;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {R1, R2, R3, R4, R5, G6} <= '1;
                    {A1, G1, A2, G2, A3, G3, A4, G4, A5, G5, R6, A6} <= '0;
                end

                RA_S2: begin
                    if (count[26]) begin
                        state <= G_S2;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {R1, R2, R3, A3, R4, A4, R5, G6} <= '1;
                    {A1, G1, A2, G2, G3, G4, A5, G5, R6, A6} <= '0;
                end

                G_S2: begin
                    if (count[31]) begin
                        state <= A_S2;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {R1, R2, G3, G4, R5, G6} <= '1;
                    {A1, G1, A2, G2, R3, A3, R4, A4, A5, G5, R6, A6} <= '0;
                end

                A_S2: begin
                    if (count[26]) begin
                        state <= R_S2;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {R1, R2, G3, G4, R5, G6} <= '1;
                    {A1, G1, A2, G2, R3, A3, R4, A4, A5, G5, R6, A6} <= '0;
                end

                R_S2: begin
                    if (count[26]) begin
                        state <= RA_S3;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {R1, R2, G3, R4, R5, R6} <= '1;
                    {A1, G1, A2, G2, R3, A3, A4, G4, A5, G5, A6, G6} <= '0;
                end

                RA_S3: begin
                    if (count[26]) begin
                        state <= G_S3;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {R1, A1, R2, A2, G3, R4, R5, R6} <= '1;
                    {G1, G2, R3, A3, A4, G4, A5, G5, A6, G6} <= '0;
                end

                G_S3: begin
                    if (count[31]) begin
                        state <= A_S3;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {G1, G2, G3, R4, R5, R6} <= '1;
                    {R1, A1, R2, A2, R3, A3, A4, G4, A5, G5, A6, G6} <= '0;
                end

                A_S3: begin
                    if (count[26]) begin
                        state <= R_S3;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {A1, G2, A3, R4, R5, R6} <= '1;
                    {R1, G1, R2, A2, R3, G3, A4, G4, A5, G5, A6, G6} <= '0;
                end

                R_S3: begin
                    if (count[26]) begin
                        state <= RA_S1;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {R1, G2, R3, R4, R5, R6} <= '1;
                    {A1, G1, R2, A2, A3, G3, A4, G4, A5, G5, A6, G6} <= '0;
                end

                RA_S1: begin
                    if (count[26]) begin
                        state <= G_S1;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                    {R1, G2, R3, R4, R5, A5, R6, A6} <= '1;
                    {A1, G1, R2, A2, A3, G3, A4, G4, G5, G6} <= '0;
                end

            endcase
        end
    end
endmodule
