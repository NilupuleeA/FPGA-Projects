//detect 0110

module sequence_detector (
    input logic rx,
    input logic clk,
    input logic rstn,
    output logic detected
);

enum {s0, s1, s2, s3, s4} state;

always_ff @( posedge clk ) begin 
    if (!rstn) begin
        state <= s0;
        detected <= 0;
    end else begin
        
        case (state)
            s0 :
                if (rx)    
                    state <= s0;
                else 
                    state <= s1;
            s1 :
                if (!rx)  
                    state <= s1;
                else
                    state <= s2;
            s2 :
                if(!rx) 
                    state <= s1; 
                else 
                    state <= s3;
            s3 :
                if (rx) 
                    state <= s0;
                else 
                    state <= s4;
            s4 :
                detected <= 1; 
                if  (rx)
                    state <= s2;
                else
                    state <= s1;
        endcase        
    end
end
endmodule





// module sequence_detector (
//     input logic rx,
//     input logic clk,
//     input logic rstn,
//     output logic detected
// );

// typedef enum logic [2:0] {
//     s0, // Initial state
//     s1, // Received 0
//     s2, // Received 01
//     s3, // Received 011
//     s4  // Received 0110
// } state_t;


// state_t state;

// always_ff @(posedge clk or negedge rstn) begin 
//     if (!rstn) begin
//         state <= s0;
//         detected <= 0;
//     end else begin
//         detected <= 0; // Default case to avoid latches
        
//         case (state)
//             s0: begin
//                 if (!rx)
//                     state <= s1;
//                 else
//                     state <= s0;
//             end
            
//             s1: begin
//                 if (!rx)
//                     state <= s1;
//                 else
//                     state <= s2;
//             end
            
//             s2: begin
//                 if (!rx)
//                     state <= s1;
//                 else
//                     state <= s3;
//             end
            
//             s3: begin
//                 if (!rx)
//                     state <= s4;
//                 else
//                     state <= s0;
//             end
            
//             s4: begin
//                 detected <= 1; // Sequence detected
//                 if (!rx)
//                     state <= s1;
//                 else
//                     state <= s2;
//             end
            
//             default: state <= s0; // Handle unexpected states
//         endcase        
//     end
// end

// endmodule
