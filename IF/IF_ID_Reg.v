module IF_ID_Reg(en, reset, PC, Instruction, PC_id, Addr_id);
	input en, reset;
	input [31:0]PC, Instruction;
	output reg [4:0]PC_id, Addr_id;
	always@(*) begin
		if (en) begin
			if (reset) begin
				PC_id = 0; Addr_id = 0;	
			end	
			else begin
				
			end
		end		
	end
endmodule