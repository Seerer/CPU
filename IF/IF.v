`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module IF(clk, reset, Branch,J ump, IFWrite, JumpAddr,Instruction_if,PC,IF_flush);
    input clk;
    input reset;
    input Branch;
    input Jump;
    input IFWrite;
    input [31:0] JumpAddr;
    output [31:0] Instruction_if;
    output [31:0] PC;
    output IF_flush;

    always @(posedge clk) begin
    	if (reset) begin
    		Instruction_if = 0;
    		PC = 0;
    		IF_flush = 1;
    	end
    	else begin
    		case({Jump, Branch})
	    		// 2'b00: PC = PC + 4;
	    		// 2'b01: PC = JumpAddr;
	    		// 2'b10: PC = 
				default: PC = 0;
			endcase

    	end
    end
    InstructionROM inst1 (.addr(), .dout());
endmodule
