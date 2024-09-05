module CLA_high(
    input logic  clk,
    input logic  reset,
    input logic  [31:0] number1,
    input logic  [31:0] number2,
    input logic  cin,
    output logic  [31:0] sum,
    output logic  cout
);
    logic [4:0] c;

    always_ff @( posedge clk ) begin 
        c[0] <= cin;
    end

    
    genvar i;
    for (i=0; i<4; i=i+1)
        CLA device(
            .number1(number1[i*8 +:8]),
            .number2(number2[i*8 +:8]),
            .clk(clk),
            .reset(reset),
            .cin(c[i]),
            .sum(sum[i*8 +:8]),
            .cout(c[i+1])
        );
    
endmodule