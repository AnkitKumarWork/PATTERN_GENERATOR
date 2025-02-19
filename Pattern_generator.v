module pattern_generator (
    input clk,
    input rst,
    output reg pattern_out
);
    // Clock period in nanoseconds (assuming 10 MHz clock, 100 ns period)
    parameter CLK_PERIOD_NS = 100;
    // Number of clock cycles for each delay
    parameter DELAY_2SEC = 20000000; // 2 seconds
    parameter DELAY_4SEC = 40000000; // 4 seconds
    parameter DELAY_6SEC = 60000000; // 6 seconds
    parameter DELAY_8SEC = 80000000; // 8 seconds

    reg [31:0] counter;
    reg [2:0] state, next_state;

    localparam S0_2SEC = 3'b000,
               S1_4SEC = 3'b001,
               S3_6SEC = 3'b010,
               S4_8SEC = 3'b011;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S0_2SEC;
            counter <= 32'b0;
            pattern_out <= 1'b0;
        end else begin
            state <= next_state;
            if (state == S0_2SEC && counter < DELAY_2SEC) begin
                counter <= counter + 1;
            end else if (state == S1_4SEC && counter < DELAY_4SEC) begin
                counter <= counter + 1;
            end else if (state == S3_6SEC && counter < DELAY_6SEC) begin
                counter <= counter + 1;
            end else if (state == S4_8SEC && counter < DELAY_8SEC) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            S0_2SEC: begin
                pattern_out = 0;
                if (counter >= DELAY_2SEC) begin
                    next_state = S1_4SEC;
                    counter = 32'b0;
                end
            end
            S1_4SEC: begin
                pattern_out = 1;
                if (counter >= DELAY_4SEC) begin
                    next_state = S3_6SEC;
                    counter = 32'b0;
                end
            end
            S3_6SEC: begin
                pattern_out = 0;
                if (counter >= DELAY_6SEC) begin
                    next_state = S4_8SEC;
                    counter = 32'b0;
                end
            end
            S4_8SEC: begin
                pattern_out = 1;
                if (counter >= DELAY_8SEC) begin
                    next_state = S0_2SEC;
                    counter = 32'b0;
                end
            end
            default: next_state = S0_2SEC;
        endcase
    end
endmodule
