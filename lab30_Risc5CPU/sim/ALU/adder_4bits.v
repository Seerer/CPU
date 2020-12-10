module adder_4bits (a, b, ci, co, s);
	input [3:0]a, b;
	input ci;

	output co;
	output [3:0]s;

	wire [3:0]c, G, P;

	assign G = a & b;
	assign P = a | b;
	assign c[0] = G[0] | P[0]*ci;
	assign c[1] = G[1] | P[1]*G[0] | P[1]*P[0]*ci;
	assign c[2] = G[2] | P[2]*G[1] | P[2]*P[1]*G[0] | P[2]*P[1]*P[0]*ci;
	assign c[3] = G[3] | P[3]*G[2] | P[3]*P[2]*G[1] | P[3]*P[2]*P[1]*G[0] | P[3]*P[2]*P[1]*P[0]*ci;

	assign s[0] = a[0] + b[0] + ci;
	assign s[1] = a[1] + b[1] +c[0];
	assign s[2] = a[2] + b[2] +c[1];
	assign s[3] = a[3] + b[3] +c[2];

	assign co = c[3];

endmodule
