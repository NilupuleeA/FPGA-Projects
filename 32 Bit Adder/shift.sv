module shift (
    
    input logic [3:0][31:0] number,
    input clk,
    input reset,
    output logic [31:0] Shift
);
    logic [3:0][31:0] number_dup; 

     //Always block triggered by the rising edge of the clock signal
    // always_ff @(posedge reset) begin
    //     number_dup <= number; // Reset internal register to 0
    
    // end
    assign number_dup = number;
    
    always_ff @( posedge clk ) begin 
        
        integer i;
            for (i = 0; i < 4; i = i + 1) begin
                Shift[i*8 +: 8] <= number_dup[i][7:0];
                number_dup[i][7:0] <= number_dup[i][15:8];
                number_dup[i][15:8] <= number_dup[i][23:16];
                number_dup[i][23:16] <= number_dup[i][31:24];
                number_dup[i][31:24] <= 0;
            end
    end
    
endmodule