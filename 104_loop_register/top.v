`include "oscillator.v"
`include "loop_register.v"

module top(input clk, input [7:0] btn, output [5:0] led, output pwmout);
localparam WIDTH = 16;

reg [23:0] counter;
always @(posedge clk) begin
	counter <= counter + 1;
end

wire gate;
wire [WIDTH-1:0] shiftreg;
loop_register #( .WIDTH(WIDTH) ) myloop (
	.clk(counter[19]),
	.rst(1'b0),
	.set(~btn[4]),
	.clear(~btn[5]),
	.register_out(shiftreg)
);

assign gate = shiftreg[14];
assign led = shiftreg[WIDTH-1 -: 6]; 

wire osc_out;
oscillator myosc ( 
	.clk(clk),
	.rst(0),
	.tuning_increment(18'd3822),
	.out(osc_out)
);

assign pwmout = osc_out & gate & ~counter[19];

endmodule
