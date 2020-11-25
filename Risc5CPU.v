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

    //ID module parameters
    wire MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id, ALUSrcA_id,
        Stall, Branch, Jump, IFWrite;
    wire [1:0] ALUSrcB_id;
    wire [3:0] ALUCode_id;
    wire [4:0] rs1Addr_id,rs2Addr_id,rdAddr_id;
    wire [31:0] JumpAddr, Imm_id, rs1Data_id, rs2Data_id;

    //IF module parameters
    wire [31:0] Instruction_if, PC_id, Instruction_id

    //EX module parameters
    wire 
    //IF output Instruction_if and then go through IF_ID to get instuction_id 
    //(Also from Instruction_id taking out rdAddr_id, rs1Addr_id, rs2Addr_id)
    IF top_module1(.clk(clk), .reset(reset), .Branch(Branch), .Jump(Jump),
            .IFWrite(IFWrite), .JumpAddr(JumpAddr), .Instruction_if(Instruction_if), .PC(PC), .IF_flush(IF_flush));

    IF_ID top_module2(.en(IFWrite), .reset(IF_flush), .PC(PC), .Instruction_if(Instruction_if), .PC_id(PC_id), .Instruction_id(Instruction_id));
    //data like RegWrite_wb come from ex(forwarding part)
    ID top_module3(.clk(clk), .Instruction_id(Instruction_id), .PC_id(PC_id), .RegWrite_wb(WB_out[1]), .rdAddr_wb(rdAddr_wb), .RegWriteData_wb(RegWriteData_wb), .MemRead_ex(Mem_out[0]), 
          .rdAddr_ex(rdAddr_ex), .MemtoReg_id(MemtoReg_id), .RegWrite_id(RegWrite_id), .MemWrite_id(MemWrite_id), .MemRead_id(MemRead_id), .ALUCode_id(ALUCode_id), 
			 .ALUSrcA_id(ALUSrcA_id), .ALUSrcB_id(ALUSrcB_id), .Stall(Stall), .Branch(Branch), .Jump(Jump), .IFWrite(IFWrite), .JumpAddr(JumpAddr), .Imm_id(Imm_id),
			 .rs1Data_id(rs1Data_id), .rs2Data_id(rs2Data_id), .rs1Addr_id(rs1Addr_id), .rs2Addr_id(rs2Addr_id), .rdAddr_id(rdAddr_id));

    //ID_EX parameters
    wire [1:0]Mem_out;//=MemRead_ex+MemWrite_ex
    wire [4:0]rdAddr_ex;
    ID_EX top_module4(Reset, WB, Mem, EX, PC_id, Imm_id, rdAddr_id, rs1Addr_id, rs2Addr_id, rs1Data_id, rs2Data_id,
             WB_out, .Mem_out(Mem_out), EX_out, PC_ex, Imm_out, .rdAddr_ex(rdAddr_ex), rs1Addr_out, rs2Addr_out, rs1Data_out, rs2Data_out);

    EX top_module5(ALUCode_ex, ALUSrcA_ex, ALUSrcB_ex,Imm_ex, rs1Addr_ex, rs2Addr_ex, rs1Data_ex, 
          rs2Data_ex, PC_ex, RegWriteData_wb, ALUResult_mem,rdAddr_mem, rdAddr_wb, 
		  RegWrite_mem, RegWrite_wb, ALUResult_ex, MemWriteData_ex, ALU_A, ALU_B);

    EX_MEM top_module6(WB, Mem, ALU, MemWriteData_ex, rdAddr_ex, WB_out, we, d, ALU_out, rdAddr_ex_out);
    DataRam top_module7(write_en, addr, Data_in, Data_out);
    //MEM_EX parameter's
    wire [1:0] WB_out;//= MemtoReg_wb + RegWrite_wb
    wire [4:0] rdAddr_wb;
    wire [31:0] out1, out2, RegWriteData_wb;
    assign RegWriteData_wb = WB_out[0] ? out1 : out2;
    MEM_WB top_module8(WB, MemDout, ALU, rdAddr_ex, .WB_out(WB_out), .out1(out1), .out2(out2), .rdAddr_wb(rdAddr_wb));
endmodule
