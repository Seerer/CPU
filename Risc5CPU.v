`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module Risc5CPU(clk, reset, JumpFlag, Instruction_id, ALU_A, 
                     ALU_B, ALUResult_ex, PC, MemDout_mem,Stall);
    input clk;
    input reset;
    output[1:0] JumpFlag;
    output [31:0] Instruction_id;
    output [31:0] ALU_A;
    output [31:0] ALU_B;
    output [31:0] ALUResult_ex;
    output [31:0] PC;
    output [31:0] MemDout_mem;
    output Stall;
    wire 
    IF top_module1(.clk(clk), .reset(reset), .Branch(BranchTest), .Jump,
     .IFWrite(IFWrite), .JumpAddr(JumpAddr),.Instruction_if, PC, IF_flush);
    ID top_module2(clk,Instruction_id, PC_id, RegWrite_wb, rdAddr_wb, RegWriteData_wb, MemRead_ex, 
          rdAddr_ex, MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id, ALUCode_id, 
			 ALUSrcA_id, ALUSrcB_id,  Stall, Branch, Jump, IFWrite,  JumpAddr, Imm_id,
			 rs1Data_id, rs2Data_id,rs1Addr_id,rs2Addr_id,rdAddr_id);
    EX top_module3(ALUCode_ex, ALUSrcA_ex, ALUSrcB_ex,Imm_ex, rs1Addr_ex, rs2Addr_ex, rs1Data_ex, 
          rs2Data_ex, PC_ex, RegWriteData_wb, ALUResult_mem,rdAddr_mem, rdAddr_wb, 
		  RegWrite_mem, RegWrite_wb, ALUResult_ex, MemWriteData_ex, ALU_A, ALU_B);
    IF_ID top_module4(en, reset, PC, Instruction, PC_id, rsAddr_id);
    ID_EX top_module5(Reset, WB, Mem, EX, PC_id, Imm_id, rdAddr_id, rs1Addr_id, rs2Addr_id, rs1Data_id, rs2Data_id, WB_out, Mem_out, EX_out, PC_ex, Imm_out, rdAddr_ex, rs1Addr_out, rs2Addr_out, rs1Data_out, rs2Data_out);
    EX_MEM top_module6(WB, Mem, ALU, MemWriteData_ex, rdAddr_ex, WB_out, we, d, ALU_out, rdAddr_ex_out);
    DataRam top_module7(write_en, addr, Data_in, Data_out);
    MRM_EB top_module8(WB, MemDout, ALU, rdAddr_ex, MemtoReg_wb, out1, out2, rdAddr_wb);
endmodule
