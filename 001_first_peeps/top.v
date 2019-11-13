module top(input clk, input [7:0] btn, output [5:0] led, output pwmout);

reg [23:0] counter; // 24-bit counter
always @(posedge clk) begin
	counter <= counter + 1;
end

assign pwmout = counter[20];

endmodule
