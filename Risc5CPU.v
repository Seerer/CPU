`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module Risc5CPU(clk, reset, JumpFlag, Instruction_id, ALU_A, 
                     ALU_B, ALUResult_ex, PC, MemDout_mem,Stall);
    input clk;
    input reset;
    output [1:0]  JumpFlag;//Jump + Branch
    output [31:0] Instruction_id;
    output [31:0] ALU_A;
    output [31:0] ALU_B;
    output [31:0] ALUResult_ex;
    output [31:0] PC;
    output [31:0] MemDout_mem;
    output Stall;

    //ID module parameters
    wire MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id, ALUSrcA_id,
        Stall, IFWrite;
    wire [1:0] ALUSrcB_id;
    wire [3:0] ALUCode_id;
    wire [4:0] rs1Addr_id, rs2Addr_id, rdAddr_id;
    wire [31:0] JumpAddr, Imm_id, rs1Data_id, rs2Data_id;

    //IF module parameters
    wire IF_flush;
    wire [31:0] Instruction_if, PC_id, Instruction_id;

    //ID_EX parameters
    wire [1:0] Mem_out_ID_EX;//=MemRead_ex+MemWrite_ex
    wire [4:0] rdAddr_ex, rs1Addr_ex, rs2Addr_ex;
    wire [1:0] WB_out_ID_EX; 
    wire [6:0] EX_out;
    wire [31:0] PC_ex, Imm_ex, rs1Data_ex, rs2Data_ex;

    //EX module parameters
    wire [31:0] MemWriteData_ex;

    //EX_MEM parameters
    wire [4:0] rdAddr_mem;
    wire [1:0] WB_out_EX_MEM;
    wire [1:0] Mem_out_EX_MEM;
    wire [31:0] d;
    wire [31:0] ALUResult_mem;

    //MEM_WB
    wire [1:0] WB_out_MEM_WB;//= MemtoReg_wb + RegWrite_wb
    wire [4:0] rdAddr_wb;
    wire [31:0] out1, out2;

    //module WB
    wire [31:0] RegWriteData_wb;

    //IF output Instruction_if and then go through IF_ID to get instuction_id 
    //(Also from Instruction_id taking out rdAddr_id, rs1Addr_id, rs2Addr_id)
    IF top_module1(.clk(clk), .reset(reset), .Branch(JumpFlag[0]), .Jump(JumpFlag[1]),
            .IFWrite(IFWrite), .JumpAddr(JumpAddr), .Instruction_if(Instruction_if), .PC(PC), .IF_flush(IF_flush));

    IF_ID top_module2(.en(IFWrite), .reset(IF_flush||reset), .PC(PC), .Instruction_if(Instruction_if), .PC_id(PC_id), .Instruction_id(Instruction_id));
    //data like RegWrite_wb come from ex(forwarding part)
    ID top_module3(.clk(clk), .Instruction_id(Instruction_id), .PC_id(PC_id), .RegWrite_wb(WB_out_MEM_WB[0]), .rdAddr_wb(rdAddr_wb), .RegWriteData_wb(RegWriteData_wb), .MemRead_ex(Mem_out_ID_EX[0]), 
          .rdAddr_ex(rdAddr_ex), .MemtoReg_id(MemtoReg_id), .RegWrite_id(RegWrite_id), .MemWrite_id(MemWrite_id), .MemRead_id(MemRead_id), .ALUCode_id(ALUCode_id), 
			 .ALUSrcA_id(ALUSrcA_id), .ALUSrcB_id(ALUSrcB_id), .Stall(Stall), .Branch(JumpFlag[0]), .Jump(JumpFlag[1]), .IFWrite(IFWrite), .JumpAddr(JumpAddr), .Imm_id(Imm_id),
			 .rs1Data_id(rs1Data_id), .rs2Data_id(rs2Data_id), .rs1Addr_id(rs1Addr_id), .rs2Addr_id(rs2Addr_id), .rdAddr_id(rdAddr_id));

    ID_EX top_module4(.Reset(Stall||reset), .WB({MemtoReg_id,RegWrite_id}), .Mem({MemWrite_id,MemRead_id}), .EX({ALUCode_id, ALUSrcA_id, ALUSrcB_id}), .PC_id(PC_id), .Imm_id(Imm_id), .rdAddr_id(rdAddr_id), .rs1Addr_id(rs1Addr_id), .rs2Addr_id(rs2Addr_id), .rs1Data_id(rs1Data_id), .rs2Data_id(rs2Data_id),
             .WB_out_ID_EX(WB_out_ID_EX), .Mem_out_ID_EX(Mem_out_ID_EX), .EX_out(EX_out), .PC_ex(PC_ex), .Imm_ex(Imm_ex), .rdAddr_ex(rdAddr_ex), .rs1Addr_ex(rs1Addr_ex), .rs2Addr_ex(rs2Addr_ex), .rs1Data_ex(rs1Data_ex), .rs2Data_ex(rs2Data_ex));

    EX top_module5(.ALUCode_ex(EX_out[6:3]), .ALUSrcA_ex(EX_out[2]), .ALUSrcB_ex(EX_out[1:0]), .Imm_ex(Imm_ex), .rs1Addr_ex(rs1Addr_ex), .rs2Addr_ex(rs2Addr_ex), .rs1Data_ex(rs1Data_ex), 
          .rs2Data_ex(rs2Data_ex), .PC_ex(PC_ex), .RegWriteData_wb(RegWriteData_wb), .ALUResult_mem(ALUResult_mem), .rdAddr_mem(rdAddr_mem), .rdAddr_wb(rdAddr_wb), 
		  .RegWrite_mem(WB_out_EX_MEM), .RegWrite_wb(WB_out_MEM_WB[0]), .ALUResult_ex(ALUResult_ex), .MemWriteData_ex(MemWriteData_ex), .ALU_A(ALU_A), .ALU_B(ALU_B));

    EX_MEM top_module6(.WB(WB_out_ID_EX), .Mem(Mem_out_ID_EX), .ALU(ALUResult_ex), .MemWriteData_ex(MemWriteData_ex), .rdAddr_ex(rdAddr_ex), .WB_out_EX_MEM(WB_out_EX_MEM), .we(Mem_out_EX_MEM), .d(d), .ALUResult_mem(ALUResult_mem), .rdAddr_ex_out(rdAddr_mem));

    DataRAM top_module7(.a(ALUResult_mem[7:2]), .d(d), .clk(clk), .we(Mem_out_EX_MEM), .spo(MemDout_mem));
    //DataRam top_module7(.write_en(Mem_out_EX_MEM), .addr(ALUResult_mem[7:2]), .Data_in(d), .Data_out(MemDout_mem));

    MEM_WB top_module8(.WB(WB_out_EX_MEM), .MemDout(MemDout), .ALU(ALUResult_mem), .rdAddr_ex(rdAddr_mem), .WB_out_MEM_WB(WB_out_MEM_WB), .out1(out1), .out2(out2), .rdAddr_wb(rdAddr_wb));
    
    assign RegWriteData_wb = WB_out_MEM_WB[1] ? out1 : out2; 
endmodule
