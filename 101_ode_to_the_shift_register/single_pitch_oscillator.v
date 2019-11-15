module single_pitch_oscillator #(
	parameter PITCH = 30578
)(
	input clk,
	output out
);

reg [23:0] counter; // 24-bit counter
reg counterout = 0;

always @(posedge clk) begin
	if (counter < PITCH)
	begin
		counter <= counter + 1;
	end else 
	begin
		counter <= 0;
		counterout <= ~counterout;
	end
end

assign out = counterout;

endmodule

