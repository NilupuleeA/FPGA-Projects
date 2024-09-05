timeunit 1ns/1ps;

module sequence_detector_tb;
    logic clk=0, rx, rstn=0, detected;
    localparam CLK_PERIOD = 10;

        sequence_detector dut (
        .rx(rx),
        .clk(clk),
        .rstn(rstn),
        .detected(detected)
    );

    initial forever #(CLK_PERIOD/2) clk <= !clk;
    

    initial begin
        repeat(2)  @(posedge clk) #1; 
        rstn = 1;
        repeat(5)  @(posedge clk) #1;
        repeat (3) begin
            repeat (3) @(posedge clk);

            @(posedge clk) #1;
            rx = $urandom();

        end
        @(posedge clk);   //when I introduce 1ps delay of the rx bit become 0 after positive edge of clock
            rx = 0;       //sequence won't detect
        @(posedge clk);
            rx = 1;
        @(posedge clk);
            rx = 1;
        @(posedge clk);
            rx = 0;



        repeat (3) begin
            repeat (3) @(posedge clk);

            @(posedge clk) #1;
            rx = $urandom();

        @(posedge clk) #1;   //when I introduce 1ps delay of the rx bit become 0 after positive edge of clock
            rx = 0;       //sequence won't detect
        @(posedge clk) #1;
            rx = 1;
        @(posedge clk) #1;
            rx = 1;
        @(posedge clk) #1;
            rx = 0;

        end


    $finish();
    end
endmodule

// `timescale 1ns/1ps

// module sequence_detector_tb;
//     logic clk = 0, rx = 0, rstn = 0, detected;
//     localparam CLK_PERIOD = 10;

//     sequence_detector dut (
//         .rx(rx),
//         .clk(clk),
//         .rstn(rstn),
//         .detected(detected)
//     );

//     initial begin
//         // Clock generation
//         forever #(CLK_PERIOD / 2) clk = ~clk;
//     end

//     initial begin
//         // Initial Reset
//         rstn = 0;
//         # (2 * CLK_PERIOD);
//         rstn = 1;

//         // Apply test sequence after reset
//         @(posedge clk);
//         rx = 0; @(posedge clk);
//         rx = 1; @(posedge clk);
//         rx = 1; @(posedge clk);
//         rx = 0; @(posedge clk);

//         // Random sequences
//         repeat (5) begin
//             rx = $urandom();
//             @(posedge clk);
//         end

//         // Apply sequence "0110" again
//         rx = 0; @(posedge clk);
//         rx = 1; @(posedge clk);
//         rx = 1; @(posedge clk);
//         rx = 0; @(posedge clk);

//         // More random sequences
//         repeat (5) begin
//             rx = $urandom();
//             @(posedge clk);
//         end

//         $finish;
//     end

// endmodule
