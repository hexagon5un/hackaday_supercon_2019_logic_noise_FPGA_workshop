`include "oscillator.v"
`include "loop_register.v"
`include "pitches.v"

module top(input clk, input [7:0] btn, output [5:0] ledc, output pwmout);
localparam WIDTH = 16;

reg [23:0] counter;
always @(posedge clk) begin
	counter <= counter + 1;
end

wire gate;
wire [WIDTH-1:0] gateloop;
loop_register #( .WIDTH(WIDTH) ) gatelooper (
	.clk(counter[19]),
	.rst(1'b0),
	.set(~btn[4]),
	.clear(~btn[5]),
	.register_out(gateloop)
);
assign gate = gateloop[14];
assign ledc = gateloop[WIDTH-1 -: 6];

wire [WIDTH-1:0] pitchloop;
loop_register #( .WIDTH(WIDTH) ) pitchlooper (
	.clk(counter[19]),
	.rst(1'b0),
	.set(~btn[2]),
	.clear(~btn[1]),
	.register_out(pitchloop)
);

wire [3:0] scale_degree;
assign scale_degree = {pitchloop[2], pitchloop[4], pitchloop[5], pitchloop[9]};

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

// Extra counter makes it do short (half-period) pulses
assign pwmout = osc_out & gate & ~counter[19];

endmodule
