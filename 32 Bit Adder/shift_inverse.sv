module shift_inverse (
    input logic [31:0] register,
    input logic clk,
    input logic set,
    output logic [3:0][31:0] Shift,
    output logic ready
);

    always_ff @( posedge clk ) begin 
            
        if (set==1) begin    
        integer i;
            for (i = 0; i < 4; i = i + 1) begin
                Shift[i][31:24] <= register[i*8 +: 8];
                Shift[i][23:16] <= Shift[i][31:24];
                Shift[i][15:8] <= Shift[i][23:16];
                Shift[i][7:0] <= Shift[i][15:8];
            end
            
        end
    end
endmodule