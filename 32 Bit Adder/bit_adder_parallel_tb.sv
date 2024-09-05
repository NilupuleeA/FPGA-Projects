module bit_adder_parallel_tb;


    timeunit      1ns;
    timeprecision 1ps;

    logic clk;
    logic [3:0][31:0] numberA;
    logic [3:0][31:0] numberB;
    logic reset;
    logic ready;

    //logic [31:0] numberB;
    localparam CLK_PERIOD = 10;
    logic [3:0][31:0] sum;
    logic ci;

    bit_adder_parallel dut(.*);


    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    initial begin   
    @(posedge clk);
        ci <= 0;
        reset <= 0;
    @(posedge clk);
        numberA <= {32'h00000001, 32'h00600041, 32'h02005001, 32'h04002001};
        numberB <= {32'h00011001, 32'h002104C0, 32'h20508001, 32'h06000031};
        reset <= 1;
        #10 reset <=0;
    #100;
    @(posedge clk);
        numberA <= {32'h000FF001, 32'h00600041, 32'h02005001, 32'h04002001};
        numberB <= {32'h00011001, 32'h00210400, 32'h20508001, 32'h06000031};
        reset <= 1;
    
    
    end
endmodule

//module bit_adder_parallel_tb;
//     timeunit      1ns;
//     timeprecision 1ps;
//    // Testbench signals
//    logic clk;
//    logic [3:0][31:0] numberA;
//    logic [3:0][31:0] numberB;
//    logic ci;
//    logic [3:0][31:0] sum;

//    // Instantiate the DUT (Device Under Test)
//    bit_adder_parallel DUT (
//        .clk(clk),
//        .numberA(numberA),
//        .numberB(numberB),
//        .ci(ci),
//        .sum(sum)
//    );

//    // Clock generation
//    initial begin
//        clk = 0;
//        forever #5 clk = ~clk; // 10 time units period
//    end

//    // Test cases
//    initial begin
//        // Initialize inputs
//        ci = 0;
//        numberA = 0;
//        numberB = 0;

//        // Apply first test case
//        @(posedge clk);
//        numberA = {32'h00000001, 32'h00000001, 32'h00000001, 32'h00000001};
//        numberB = {32'h00000001, 32'h00000001, 32'h00000001, 32'h00000001};
//        ci = 1'b0;

//        // Wait for a clock cycle
//        @(posedge clk);
//        #1; // Small delay to allow signals to propagate
//        // Check the result
//        if (sum !== {32'h00000002, 32'h00000002, 32'h00000002, 32'h00000002}) begin
//            $display("Test Case 1 Failed: sum = %h", sum);
//        end else begin
//            $display("Test Case 1 Passed");
//        end

//        // Apply second test case
//        @(posedge clk);
//        numberA = {32'hFFFFFFFF, 32'hFFFFFFFF, 32'hFFFFFFFF, 32'hFFFFFFFF};
//        numberB = {32'h00000001, 32'h00000001, 32'h00000001, 32'h00000001};
//        ci = 1'b0;

//        // Wait for a clock cycle
//        @(posedge clk);
//        #1; // Small delay to allow signals to propagate
//        // Check the result
//        if (sum !== {32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000}) begin
//            $display("Test Case 2 Failed: sum = %h", sum);
//        end else begin
//            $display("Test Case 2 Passed");
//        end

//        // Apply third test case
//        @(posedge clk);
//        numberA = {32'h12345678, 32'h87654321, 32'hFEDCBA98, 32'h89ABCDEF};
//        numberB = {32'h00000001, 32'h00000001, 32'h00000001, 32'h00000001};
//        ci = 1'b0;

//        // Wait for a clock cycle
//        @(posedge clk);
//        #1; // Small delay
        
//endmodule