module loop_register #(
	parameter WIDTH=16
)(
	input clk, 
	input rst,
	input set,
	input clear, 
	output [WIDTH-1:0] register_out
);

// Creates a shift register that loops back on itself, 
// with the option to set or clear the input bit.
reg [WIDTH-1:0] internal_register;
always @(posedge clk) begin
	if (rst) begin
		internal_register <= {{WIDTH-1{1'b0}}, 1}; // copy WIDTH-1 times zeroes, concat 1
	end
	else begin
		case ({set, clear})
			2'b10: internal_register = {1'b1, internal_register[WIDTH-1:1]};
			2'b01: internal_register = {1'b0, internal_register[WIDTH-1:1]};
			// else loop around
			default: internal_register = {internal_register[0], internal_register[WIDTH-1:1]};
		endcase
	end
end

assign register_out = internal_register;

endmodule
