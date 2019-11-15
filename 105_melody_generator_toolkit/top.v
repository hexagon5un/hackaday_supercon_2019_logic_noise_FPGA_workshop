`include "oscillator.v"
`include "loop_register.v"
`include "pitches.v"

module top(input clk, input [7:0] btn, output [5:0] led, output pwmout);
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
assign led = gateloop[WIDTH-1 -: 6]; 

wire [WIDTH-1:0] pitchloop;
loop_register #( .WIDTH(WIDTH) ) pitchlooper (
	.clk(counter[19]),
	.rst(1'b0),
	.set(~btn[0]),
	.clear(~btn[2]),
	.register_out(pitchloop)
);

wire [3:0] scale_degree;
assign scale_degree = {pitchloop[2], pitchloop[4], pitchloop[5], pitchloop[9]};

wire [17:0] tuning_increment;
pitches pitch_lookup (
	.clk(clk),
	.rst(0),
	.pitch(scale_degree),
	.tuning_increment(tuning_increment)
);

wire osc_out;
oscillator myosc ( 
	.clk(clk),
	.rst(0),
	.tuning_increment(tuning_increment),
	.out(osc_out)
);

assign pwmout = osc_out & gate & ~counter[19];

endmodule
