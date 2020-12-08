module mux10_1 (a, b, c, d, e, f, g, h, i, j, sel, out);

	input [31:0] a, b, c, d, e, f, g, h;
	input i, j;
	input [3:0] sel;

	output reg [31:0] out;

	always @(*) begin
		case(sel)
			4'b0000: out = a;
			4'b0001: out = b;
			4'b0010: out = c;
			4'b0011: out = d;
			4'b0100: out = e;
			4'b0101: out = f;
			4'b0110: out = g;
			4'b0111: out = h;
			4'b1000: out = i;
			4'b1001: out = j;
			default: out = 0;
		endcase 
	end
endmodule