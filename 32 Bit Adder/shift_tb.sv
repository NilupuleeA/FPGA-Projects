module shift_tb();

    localparam CLK_PERIOD = 10;
    
    logic [3:0][31:0] number;
    logic clk;
    logic reset;
    logic [31:0] Shift;

    shift dut(.*);
    
    assign reset = 0;

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end
    initial begin
    

        @(posedge clk);
        number = {32'hC011001, 32'hC1010001, 32'h0A010001, 32'h0A0B0B01};
        @(posedge clk);
        reset = 1;
    end
    
    
endmodule