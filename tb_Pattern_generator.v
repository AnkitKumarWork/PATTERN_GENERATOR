`timescale 1ns / 1ps

module pattern_generator_tb;
    reg clk;
    reg rst;
    wire pattern_out;

    pattern_generator uut (
        .clk(clk),
        .rst(rst),
        .pattern_out(pattern_out)
    );

    always #50 clk = ~clk; // 10 MHz clock

    initial begin

        clk = 0;
        rst = 1;
        #100;
        rst = 0;
        #2000000000;
        $stop;
    end

    initial begin
        $monitor("Time = %0t, rst = %b, clk = %b, pattern_out = %b", $time, rst, clk, pattern_out);
    end
      
endmodule
