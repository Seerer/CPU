module IF_ID_Reg(en, reset, PC, Instruction, PC_id, rsAddr_id);
	input en, reset;
	input [31:0]PC, Instruction;
	output reg [4:0]PC_id, rsAddr_id;
	always@(*) begin
		if (reset) begin
			rsAddr_id = 0; PC_id = 0;
		end		
		else if (en) begin
			rsAddr_id = Instruction; PC_id = PC;
		end
	end
endmodule
