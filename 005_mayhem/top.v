`include "single_pitch_oscillator.v"

module top(input clk, input [7:0] btn, output [5:0] ledc, output pwmout);

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

wire voice_0;
assign voice_0 = outs[0] & counter[19] ;

wire blue_moon;
assign blue_moon = counter[19] & counter[21] & counter[22];
wire voice_1;
assign voice_1 = outs[2] & blue_moon ;

wire voice_2;
assign voice_2 = outs[4] & ~counter[23] ;

wire voice_3;
assign voice_3 = outs[6] & ~btn[5];


assign pwmout = voice_0 | voice_1 | voice_2 | voice_3;
assign ledc[5:0] = ~btn[5:0];

endmodule

// Build more!  What if you have to define 100 of these?
// What about other ways of mixing the oscs together? &? ^? 

