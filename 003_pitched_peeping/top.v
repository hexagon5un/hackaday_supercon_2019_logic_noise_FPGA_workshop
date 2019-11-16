module top(input clk, input [7:0] btn, output [5:0] ledc, output pwmout);

reg [23:0] counter; // 24-bit counter
reg counterout = 0;

always @(posedge clk) begin
	if (counter < 30578)
	begin
		counter <= counter + 1;
	end else 
	begin
		counter <= 0;
		counterout <= ~counterout;
	end
	// NOT! 
	// counter += 1
	// if (counter == 0) { counter = 0;}
end

assign pwmout = counterout & ~btn[4];
assign ledc[0] = ~btn[4];

endmodule

// Why not?  

