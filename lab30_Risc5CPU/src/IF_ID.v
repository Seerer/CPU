module IF_ID(en, reset, PC, Instruction_if, PC_id, Instruction_id, clk);
	input en, reset, clk;
	input [31:0]PC, Instruction_if;
	output reg [31:0]PC_id = 0, Instruction_id = 0;
	always@(posedge clk) begin
		if (reset) begin
			Instruction_id = 0; PC_id = 0;
		end		
		else if (en) begin
			Instruction_id = Instruction_if; 
			PC_id = PC;
		end
	end
endmodule
