module pitches #(
	parameter WIDTH=18
)(
	input clk,
	input rst,
	input [3:0] pitch,
	output [WIDTH-1:0] tuning_increment
);

reg [17:0] pitch_register;
always @(posedge clk) begin
	if (rst) begin
		pitch_register <= 0;
	end 
	else begin
		case (pitch) 
			// 0 is reserved to be no note played
			1: tuning_increment <= 30578;
			2: tuning_increment <= 27242;
			3: tuning_increment <= 24270;
			4: tuning_increment <= 22908;
			5: tuning_increment <= 20408;
			6: tuning_increment <= 18182;
			7: tuning_increment <= 16198;
			8: tuning_increment <= 15289;
			9: tuning_increment <= 15289;
			10: tuning_increment <= 13621;
			11: tuning_increment <= 12135;
			12: tuning_increment <= 11454;
			13: tuning_increment <= 10204;
			14: tuning_increment <= 9091; 
			15: tuning_increment <= 8099; 
			default: tuning_increment <= 145455;
		endcase
	end
end

endmodule

