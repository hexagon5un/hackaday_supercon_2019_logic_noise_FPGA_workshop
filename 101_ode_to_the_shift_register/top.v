`include "single_pitch_oscillator.v"

module top(input clk, input [7:0] btn, output [5:0] led, output pwmout);

reg [23:0] counter;
always @(posedge clk) begin
	counter <= counter + 1;
end

reg [5:0] shift_register = 0;
always @(posedge counter[19]) begin
	shift_register <= { ~btn[4], shift_register[5:1]};
end

assign led=shift_register;

// But this class isn't about blinking lights

wire osc_out;
single_pitch_oscillator #(.PITCH(7645)) 
myosc ( .clk(clk), .out(osc_out));

assign pwmout = osc_out & (shift_register[1] | shift_register[5]);


endmodule
