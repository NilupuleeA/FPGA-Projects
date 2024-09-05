module bit_adder_parallel (
    input logic clk,
    input logic [3:0][31:0] numberA,
    input logic [3:0][31:0] numberB,
    input logic ci,
    output logic [3:0][31:0] sum,
    output logic ready
);

    logic [3:0] C;
    logic [31:0] number1;
    logic [31:0] number2;
    logic [31:0] sumInt;

    shift u_shift1 (
        .number(numberA),
        .clk(clk),
        .reset(reset),
        .Shift(number1)
    );
    
    shift u_shift2 (
        .number(numberB),
        .clk(clk),
        .reset(reset),
        .Shift(number2)
    );
    

        genvar i;
        for (i=0; i<4; i=i+1) begin
            c_addsub_0 fa (
            .A(number1[i*8 +: 8]),       // input wire [7 : 0] A
            .B(number2[i*8 +: 8]),      // input wire [7 : 0] B
            .CLK(clk),                  // input wire CLK
            .C_IN(C[i]),                // input wire C_IN
            .CE(1'b1),                  // input wire CE
            .C_OUT(C[i]),               // output wire C_OUT
            .S(sumInt[i*8 +: 8])       // output wire [7 : 0] S
            );
        end 

        


    // for (i=0; i<4; i=i+1) begin
    //     c_addsub_0 fa (
    //     .A(number1[i*8 +: 8]),       // input wire [7 : 0] A
    //     .B(number2[i*8 +: 8]),     // input wire [7 : 0] B
    //     .CLK(clk),                      // input wire CLK
    //     .C_IN(C[i]),                    // input wire C_IN
    //     .CE(1),                         // input wire CE
    //     .C_OUT(C[i]),                 // output wire C_OUT
    //     .S(sumInt[i*8 +: 8])               // output wire [7 : 0] S
    //     );
    // end 

    shift_inverse shift_3 (
        .register(sumInt),
        .clk(clk),
        .set(1'b1),
        .Shift(sum)
    );

endmodule

// module bit_adder_parallel (
//     input logic clk,
//     input logic [3:0][31:0] numberA,
//     input logic [3:0][31:0] numberB,
//     input logic ci,
//     output logic [3:0][31:0] sum
// );

//     logic [3:0] C;
//     logic [3:0][31:0] NumberA;
//     logic [3:0][31:0] NumberB;
//     logic [3:0][31:0] SuM;
//     logic [31:0] number1;
//     logic [31:0] number2;
//     logic [31:0] sumInt;

//     always_ff @(posedge clk) begin
//         NumberA <= numberA;
//         NumberB <= numberB;
        
//         // Assigning 8-bit segments to number1 and number2
//         number1[7:0]    <= NumberA[0][7:0];
//         number2[7:0]    <= NumberB[0][7:0];
//         number1[15:8]   <= NumberA[1][7:0];
//         number2[15:8]   <= NumberB[1][7:0];
//         number1[23:16]  <= NumberA[2][7:0];
//         number2[23:16]  <= NumberB[2][7:0];
//         number1[31:24]  <= NumberA[3][7:0];
//         number2[31:24]  <= NumberB[3][7:0];
//     end

//     genvar i;
//     generate
//         for (i=0; i<4; i=i+1) begin : gen_adder
//             c_addsub_0 fa (
//                 .A(number1[i*8 +: 8]),       // input wire [7 : 0] A
//                 .B(number2[i*8 +: 8]),       // input wire [7 : 0] B
//                 .CLK(clk),                   // input wire CLK
//                 .C_IN(i == 0 ? ci : C[i-1]), // input wire C_IN
//                 .CE(1),                      // input wire CE
//                 .C_OUT(C[i]),                // output wire C_OUT
//                 .S(sumInt[i*8 +: 8])         // output wire [7 : 0] S
//             );
//         end
//     endgenerate

//     always_ff @(posedge clk) begin
//         SuM <= {sumInt[31:24], sumInt[23:16], sumInt[15:8], sumInt[7:0]};
//         sum <= SuM;
//     end
    
// endmodule
