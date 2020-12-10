module mux2_1 (sel, in1, in2, co);
	parameter in_width = 3;
	parameter out_width = 3;
	input sel;
	input [in_width:0] in1, in2;

	output [out_width:0] co;

	assign co = sel?in2:in1;
endmodule
