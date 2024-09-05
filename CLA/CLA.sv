module CLA (
    input logic clk,
    input logic reset,
    input logic [7:0] number1,
    input logic [7:0] number2,
    input logic cin,
    output logic [7:0] sum,
    output logic cout
);
    logic p [7:0];
    logic g [7:0];
    logic c [8:0];

    

    always_ff @( posedge clk ) begin
        integer i;
        
        for (i=0; i<8; i=i+1) begin
            p[i] <= number1[i] & number2[i];
            g[i] <= number1[i] ^ number2[i];
        end
    end

    always_ff @( posedge clk ) begin
        c[0] <= cin;
        c[1] <= p[0] | g[0]&cin;
        c[2] <= p[1] | g[1]&(p[0] | g[0]&cin);
        c[3] <= p[2] | g[2]&(p[1] | g[1]&(p[0] | g[0]&cin));
        c[4] <= p[3] | g[3]&(p[2] | g[2]&(p[1] | g[1]&(p[0] | g[0]&cin)));
        c[5] <= p[4] | g[4]&(p[3] | g[3]&(p[2] | g[2]&(p[1] | g[1]&(p[0] | g[0]&cin))));
        c[6] <= p[5] | g[5]&(p[4] | g[4]&(p[3] | g[3]&(p[2] | g[2]&(p[1] | g[1]&(p[0] | g[0]&cin)))));
        c[7] <= p[6] | g[6]&(p[5] | g[5]&(p[4] | g[4]&(p[3] | g[3]&(p[2] | g[2]&(p[1] | g[1]&(p[0] | g[0]&cin))))));
        c[8] <= p[7] | g[7]&(p[6] | g[6]&(p[5] | g[5]&(p[4] | g[4]&(p[3] | g[3]&(p[2] | g[2]&(p[1] | g[1]&(p[0] | g[0]&cin)))))));
        cout <= c[8];
    end

    always_ff @( posedge clk ) begin 
        integer i;
        for (i=0; i<8; i=i+1) begin
            sum[i] <= number1[i]^number2[i]^c[i];
        end
    end
    
endmodule