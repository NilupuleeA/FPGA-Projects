// module bitAdder
//(
//    input logic clk,
//    input logic [3:0][31:0] numberA,
//    input logic [3:0][31:0] numberB,
//    input logic ci,
//    output logic [31:0] sum
//);

    
//    logic [3:0][31:0] shiftRegisterA;
//    logic [3:0][31:0] shiftRegisterB;
//    logic [5:0] C;
//    assign C[0] = ci;
//    logic [31:0] number1;
//    logic [31:0] number2;

        

//    always_ff @( posedge clk ) begin
//        number1 <= shiftRegisterA[0];
//        number2 <= shiftRegisterB[0];
//        shiftRegisterA[0] <= shiftRegisterA[1];
//        shiftRegisterA[1] <= shiftRegisterA[2];
//        shiftRegisterA[2] <= shiftRegisterA[3];
//        shiftRegisterA[3] <= 32'd0; // or any desired value for the last element
        
//        shiftRegisterB[0] <= shiftRegisterB[1];
//        shiftRegisterB[1] <= shiftRegisterB[2];
//        shiftRegisterB[2] <= shiftRegisterB[3];
//        shiftRegisterB[3] <= 32'd0;

//    end

    
//    genvar i;   
//    for (i=0; i<4; i=i+1) begin
//        c_addsub_0 fa (
//            .A(number1[i*8 +: 8]),          // input wire [7 : 0] A
//            .B(number2[i*8 +: 8]),          // input wire [7 : 0] B
//            .CLK(clk),                      // input wire CLK
//            .C_IN(C[i]),                    // input wire C_IN
//            .CE(1),                         // input wire CE
//            .C_OUT(C[i+1]),                 // output wire C_OUT
//            .S(sum[i*8 +: 8])               // output wire [7 : 0] S
//            );
//    end

//endmodule

module bitAdder
(
    input logic clk,
    input logic [31:0] numberA,
    input logic [31:0] numberB,
    input logic ci,
    output logic [31:0] sum
);


    logic [5:0] C;
    assign C[0] = ci;

    genvar i;

    for (i = 0; i < 4; i = i + 1) begin
    c_addsub_0 fa (
        .A(numberA[i*8 +: 8]),       // input wire [7 : 0] A
        .B(numberB[i*8 +: 8]),       // input wire [7 : 0] B
        .CLK(clk),                   // input wire CLK
        .C_IN(C[i]),                 // input wire C_IN
        .CE(1),                      // input wire CE
        .C_OUT(C[i+1]),              // output wire C_OUT
        .S(sum[i*8 +: 8])            // output wire [7 : 0] S
    );
    end
        


endmodule
