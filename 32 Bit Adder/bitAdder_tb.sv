module bitAdder_tb;

    timeunit      1ns;
    timeprecision 1ps;

    logic clk = 0;
    logic [31:0] numberA;
    logic [31:0] numberB;
    logic reset;

    //logic [31:0] numberB;
    localparam CLK_PERIOD = 10;
    logic [31:0] sum;
    logic ci;
    
    bitAdder dut(.*);
    
    initial begin
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end
    
    initial begin   
        @(posedge clk);
        ci <= 0;
        numberA <= 32'd64;
        numberB <= 32'd128;
    end

endmodule