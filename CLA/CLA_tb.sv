module CLA_tb ();

    localparam CLOCK_PERIOD = 10;
    logic clk = 0;
    logic reset = 0;
    logic [7:0] number1;
    logic [7:0] number2;
    logic cin;
    logic [7:0] sum;
    logic cout;

    CLA dut (.*);

    initial forever 
        #(CLOCK_PERIOD/2) clk <= ~clk;
    
    initial begin
    @(posedge clk);
        cin = 0;
        number1 = 8'd8;
        number2 = 8'd8;

    end
endmodule