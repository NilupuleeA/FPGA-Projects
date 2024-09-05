module shift_inverse_tb ();

    localparam CLK_PERIOD = 10;
    
    logic [31:0] register;
    logic clk;
    logic set;
    logic [3:0][31:0] Shift;

    shift_inverse dut(.*);
    
    assign reset = 0;

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end
    initial begin
        set = 1;

        @(posedge clk);
        register = 32'hC011001;
        @(posedge clk);
        register = 32'hC1010001;
        @(posedge clk);
        register = 32'hCA010001;
        @(posedge clk);
        register = 32'h0A0B0B01;
        @(posedge clk);
        set = 0;
    end
    
endmodule