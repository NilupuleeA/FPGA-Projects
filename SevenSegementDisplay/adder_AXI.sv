module adder_AXI #(
    WIDTH = 8;
) (
    input logic s_valid, s_ready;
    input logic [WIDTH-1 : 0] s_data;
    output logic m_valid, m_ready;
    output logic [1:0][6:0] m_data;
);
    logic [WIDTH:0] sum;
    logic [WIDTH-1 : 0] a;

    assign sum = 8'd0;


    always_comb begin
        
        modulo_result = x=sum % 10;  // Modulo 10 operation
        remainder_result = sum / 10;  // Division by 10


        case (modulo_result)
            4'd0: m_data[0] = 7'b0111111; // 0
            4'd1: m_data[0] = 7'b0000110; // 1
            4'd2: m_data[0] = 7'b1011011; // 2
            4'd3: m_data[0] = 7'b1001111; // 3
            4'd4: m_data[0] = 7'b1100110; // 4
            4'd5: m_data[0] = 7'b1101101; // 5
            4'd6: m_data[0] = 7'b1111101; // 6
            4'd7: m_data[0] = 7'b0000111; // 7
            4'd8: m_data[0] = 7'b1111111; // 8
            4'd9: m_data[0] = 7'b1101111; // 9
            default: m_data[0] = 7'b0000000; // Default to all m_data[0] off
        endcase

        case (remainder_result)
            4'd0: m_data[1] = 7'b0111111; // 0
            4'd1: m_data[1] = 7'b0000110; // 1
            4'd2: m_data[1] = 7'b1011011; // 2
            4'd3: m_data[1] = 7'b1001111; // 3
            4'd4: m_data[1] = 7'b1100110; // 4
            4'd5: m_data[1] = 7'b1101101; // 5
            4'd6: m_data[1] = 7'b1111101; // 6
            4'd7: m_data[1] = 7'b0000111; // 7
            4'd8: m_data[1] = 7'b1111111; // 8
            4'd9: m_data[1] = 7'b1101111; // 9
            default: m_data[1] = 7'b0000000; // Default to all m_data[0] off
        endcase
    end        


    always_comb begin
        sum = sum + a;
    end


    always_ff @(posedge s_valid) begin
        a <= s_data;
    end

endmodule