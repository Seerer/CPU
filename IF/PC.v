module PC(IFWrite, PCSource, PC);
	input IFWrite;
	input [31:0]PCSource;
	output [31:0]PC;
	assign PC = (IFWrite == 1) ? PCSource : 32'b0;
endmodule