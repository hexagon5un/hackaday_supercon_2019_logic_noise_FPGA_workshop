`include "oscillator.v"
`include "pitches.v"

module top(input clk, input [7:0] btn, output [5:0] led, output pwmout);

reg [23:0] counter;
always @(posedge clk) begin
	counter <= counter + 1;
end

wire [3:0]  scale_degree;
wire        gate;
reg [7:0]   shift_register = 0;

always @(posedge counter[19]) begin
	shift_register <= { ~btn[4], shift_register[7:1]};
	scale_degree <= {shift_register[2], shift_register[3], shift_register[5], shift_register[7]};
	gate <= scale_degree ? 1 : 0;
end

assign led = shift_register;

// Now it gets musical?

wire [17:0] counter_top;
pitches pitch_lookup (
	.clk(clk),
	.rst(0),
	.scale_degree(scale_degree),
	.counter_top(counter_top)
);

wire osc_out;
oscillator myosc ( 
	.clk(clk),
	.rst(0),
	.counter_top(counter_top),
	.out(osc_out)
);

assign pwmout = osc_out & gate ;


endmodule
