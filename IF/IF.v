`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module IF(clk, reset, Branch, Jump, IFWrite, JumpAddr, Instruction_if, PC, IF_flush);
    input clk;
    input reset;
    input Branch;
    input Jump;
    input IFWrite;
    input [31:0] JumpAddr;
    output [31:0] Instruction_if;
    output reg [31:0] PC;
    output IF_flush;

    assign IF_flush = Jump|Branch;
    always@(posedge clk) begin
        if (IFWrite) begin
            if (IF_flush) begin
                PC = JumpAddr;
            end
            else if (reset) begin
                PC = 0;
            end
            else begin
                PC = PC + 4;
            end            
        end
    end
    InstructionROM inst1 (.addr(PC>>2), .dout(Instruction_if));
    initial
        PC = 0;
endmodule
