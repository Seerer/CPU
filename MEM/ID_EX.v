module ID_EX(Reset, WB, Mem, EX, PC_id, Imm_id, rdAddr_id, rs1Addr_id, rs2Addr_id, rs1Data_id, rs2Data_id, WB_out_ID_EX, Mem_out_ID_EX, EX_out, PC_ex, Imm_ex, rdAddr_ex, rs1Addr_ex, rs2Addr_ex, rs1Data_ex, rs2Data_ex);
input Reset;
input [1:0] WB, Mem; //WB = MemtoReg_id + RegWrite_id  Mem = MemRead_id + MemWrite_id
input [6:0] EX;      //EX = ALUCode_id + ALUSrcA_id + ALUSrcB_id
input [31:0] PC_id, Imm_id, rs1Data_id, rs2Data_id;
input [4:0] rdAddr_id, rs1Addr_id, rs2Addr_id;

output reg [1:0] WB_out_ID_EX, Mem_out_ID_EX;
output reg [6:0] EX_out;
output reg [31:0] PC_ex, Imm_ex, rs1Data_ex, rs2Data_ex;
output reg [4:0] rdAddr_ex, rs1Addr_ex, rs2Addr_ex;

always@(*) begin
    if (Reset) begin
        WB_out_ID_EX = 0;
        Mem_out_ID_EX = 0;
        EX_out = 0;
        PC_ex = 0;
        Imm_ex = 0;
        rs1Data_ex = 0;
        rs2Data_ex = 0;
        rdAddr_ex = 0;
        rs1Addr_ex = 0; 
        rs2Addr_ex = 0;
    end
    else begin 
        WB_out_ID_EX = WB;
        Mem_out_ID_EX = Mem;
        EX_out = EX;
        PC_ex = PC_id;
        Imm_ex = Imm_id;
        rs1Data_ex = rs1Data_id;
        rs2Data_ex = rs2Data_id;
        rdAddr_ex = rdAddr_id;
        rs1Addr_ex = rs1Addr_id; 
        rs2Addr_ex = rs2Addr_id;
    end
end
endmodule