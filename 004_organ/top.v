`include "single_pitch_oscillator.v"

module top(input clk, input [7:0] btn, output [5:0] led, output pwmout);

wire out_c;
single_pitch_oscillator #(
	.PITCH(15289)
) osc_c (
	.clk(clk),
	.out(out_c)
);

wire out_d;
single_pitch_oscillator #(
	.PITCH(13621)
) osc_d (
	.clk(clk),
	.out(out_d)
);

wire out_e;
single_pitch_oscillator #(
	.PITCH(12135)
) osc_e (
	.clk(clk),
	.out(out_e)
);

assign pwmout = (out_c & ~btn[4]) | (out_d & ~btn[5]) | (out_c & ~btn[3]);
assign led[5:0] = ~btn[5:0];

endmodule

// Build more!  What if you have to define 100 of these?
// What about other ways of mixing the oscs together? &? ^? 

