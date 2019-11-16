`include "oscillator.v"

module top(input clk, input [7:0] btn, output [5:0] ledc, output pwmout);

reg [23:0] counter;
always @(posedge clk) begin
	counter <= counter + 1;
end

reg [5:0] shift_register = 0;
always @(posedge counter[19]) begin
	shift_register <= { ~btn[4], shift_register[5:1]};
end

assign ledc=shift_register;

// Now it gets weird:

wire osc_out;
oscillator myosc ( 
	.clk(clk),
	.rst(0),
	.counter_top({2'b0, shift_register, 9'h0}), // just playin!
	.out(osc_out)
);

assign pwmout = osc_out;


endmodule
