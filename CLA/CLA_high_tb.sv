module CLA_high_tb;
    localparam CLOCK_PERIOD = 10;
    logic clk=0;
    logic reset;
    logic [31:0] number1;
    logic [31:0] number2;
    logic cin;
    logic [31:0] sum;
    logic cout;


    CLA_high dut (.*);

    initial forever 
        #(CLOCK_PERIOD/2) clk <= ~clk;

    initial begin
        @(posedge clk);
        cin <= 0;
        number1 <= 32'd41;
        number2 <= 32'd32;
        
    end







endmodule