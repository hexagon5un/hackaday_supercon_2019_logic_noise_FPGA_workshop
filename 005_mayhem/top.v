`include "single_pitch_oscillator.v"

module top(input clk, input [7:0] btn, output [5:0] led, output pwmout);

wire [7:0] outs;
single_pitch_oscillator #(
	.PITCH(15289)
) osc_c (
	.clk(clk),
	.out(outs[0])
);

single_pitch_oscillator #(
	.PITCH(13621)
) osc_d (
	.clk(clk),
	.out(outs[1])
);

single_pitch_oscillator #(
	.PITCH(12135)
) osc_e (
	.clk(clk),
	.out(outs[2])
);

single_pitch_oscillator #(
	.PITCH(11454)
) osc_f (
	.clk(clk),
	.out(outs[3])
);

single_pitch_oscillator #(
	.PITCH(10204)
) osc_g (
	.clk(clk),
	.out(outs[4])
);

single_pitch_oscillator #(
	.PITCH(9091)
) osc_a (
	.clk(clk),
	.out(outs[5])
);

single_pitch_oscillator #(
	.PITCH(8099)
) osc_b (
	.clk(clk),
	.out(outs[6])
);

single_pitch_oscillator #(
	.PITCH(7645)
) osc_c2 (
	.clk(clk),
	.out(outs[7])
);

reg [23:0] counter;
always @(posedge clk) begin
	counter <= counter + 1;
end


assign pwmout = outs[0] & counter[19] | outs[2] & counter[23] | outs[4] & ~counter[23] ^ outs[22] & ~btn[5];
assign led[5:0] = ~btn[5:0];

endmodule

// Build more!  What if you have to define 100 of these?
// What about other ways of mixing the oscs together? &? ^? 

