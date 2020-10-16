module mux2_1 (sel, in1, in2, co);
	input sel;
	input [3:0]in1, in2;

	output [3:0]co;

	assign co = sel?in2:in1;
endmodule
