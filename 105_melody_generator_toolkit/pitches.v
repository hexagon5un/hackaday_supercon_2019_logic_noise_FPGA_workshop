module pitches #(
	parameter WIDTH=18
)(
	input clk,
	input rst,
	input [3:0] scale_degree,
	output [WIDTH-1:0] counter_top
);

reg [WIDTH-1:0] counter_top_internal;
always @(posedge clk) begin
	if (rst) begin
		counter_top_internal <= 0;
	end 
	else begin
		case (scale_degree) 
			// 0 is reserved to be no note played
			1: counter_top_internal <= 30578;
			2: counter_top_internal <= 27242;
			3: counter_top_internal <= 24270;
			4: counter_top_internal <= 22908;
			5: counter_top_internal <= 20408;
			6: counter_top_internal <= 18182;
			7: counter_top_internal <= 16198;
			8: counter_top_internal <= 15289;
			9: counter_top_internal <= 15289;
			10: counter_top_internal <= 13621;
			11: counter_top_internal <= 12135;
			12: counter_top_internal <= 11454;
			13: counter_top_internal <= 10204;
			14: counter_top_internal <= 9091; 
			15: counter_top_internal <= 8099; 
			default: counter_top_internal <= 145455;
		endcase
	end
end

assign counter_top = counter_top_internal;

endmodule

