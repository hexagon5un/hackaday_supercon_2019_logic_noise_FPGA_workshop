module top(input clk, input [7:0] btn, output [5:0] ledc, output pwmout);

reg [23:0] counter; // 24-bit counter
always @(posedge clk) begin
	counter <= counter + 1;
end

// And, not, or, xor: & ~ | ^ 
assign pwmout = counter[16] & ~btn[4];
assign ledc[0] = ~btn[4];

endmodule

// Where do these pin names come from?

