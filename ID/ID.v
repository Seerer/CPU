`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//////////////////////////////////////////////////////////////////////////////////
module ID(clk,Instruction_id, PC_id, RegWrite_wb, rdAddr_wb, RegWriteData_wb, MemRead_ex, 
          rdAddr_ex, MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id, ALUCode_id, 
			 ALUSrcA_id, ALUSrcB_id,  Stall, Branch, Jump, IFWrite,  JumpAddr, Imm_id,
			 rs1Data_id, rs2Data_id,rs1Addr_id,rs2Addr_id,rdAddr_id);
    input clk;
    input [31:0] Instruction_id;
    input [31:0] PC_id;
    input RegWrite_wb;
    input [4:0] rdAddr_wb;
    input [31:0] RegWriteData_wb;
    input MemRead_ex;
    input [4:0] rdAddr_ex;
    input[4:0] rs1Addr_id,rs2Addr_id;
    output MemtoReg_id;
    output RegWrite_id;
    output MemWrite_id;
    output MemRead_id;
    output [3:0] ALUCode_id;
    output ALUSrcA_id;
    output [1:0]ALUSrcB_id;
    output Stall;
    output Branch;
    output Jump;
    output IFWrite;
    output [31:0] JumpAddr;
    output [31:0] Imm_id;
    output [31:0] rs1Data_id;
    output [31:0] rs2Data_id;
    output[4:0] rdAddr_id;

    wire [2:0] funct3;
    wire [6:0] SB_type;
//  module register	
    Registers r1(.clk(clk), .rs1Addr(rs1Addr_id), .rs2Addr(rs2Addr_id), .WriteAddr(rdAddr_wb), .RegWrite(RegWrite_wb), .WriteData(RegWriteData_wb), .rs1Data(rs1Data_id), .rs2Data(rs2Data_id));
    Decode d1(.MemtoReg(MemtoReg_id), .RegWrite(RegWrite_id), .MemWrite(MemWrite_id), .MemRead(MemRead_id), .ALUCode(ALUCode_id), .ALUSrcA(ALUSrcA_id), .ALUSrcB(ALUSrcB_id), .Jump(Jump), .JALR(Jump), .Imm(Imm_id), .offset(Imm_id), .Instruction(Instruction_id), .rs1Data(rs1Data_id), .rs2Data(rs2Data_id), .funct3(funct3), .SB_type(SB_type));
    Branch_Test b1(.rs1Data(rs1Data_id), .rs2Data(rs2Data_id), .Branch(Branch), .funct3(funct3), .SB_type(SB_type));
//  module Hazard_Detector (get MemRead_ex from ID_EX MEM)
    assign Stall = MemRead_ex && ((rdAddr_ex == rs1Addr_id) || (rdAddr_ex == rs2Addr_id));
    assign IFWrite = ~Stall;
    assign JumpAddr = Imm_id + Jump?rs1Data_id:PC_id;
endmodule


