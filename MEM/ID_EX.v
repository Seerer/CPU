module ID_EX(Reset, WB, Mem, EX, PC_id, Imm_id, rdAddr_id, rs1Addr_id, rs2Addr_id, rs1Data_id, rs2Data_id, WB_out, Mem_out, EX_out, PC_ex, Imm_out, rdAddr_ex, rs1Addr_out, rs2Addr_out, rs1Data_out, rs2Data_out);
input Reset;
input [1:0] WB, Mem; //WB = MemtoReg_id + RegWrite_id  Mem = MemRead_id + MemWrite_id
input [6:0] EX;      //EX = ALUCode_id + ALUSrcA_id + ALUSrcB_id
input [31:0] PC_id, Imm_id, rs1Data_id, rs2Data_id;
input [4:0] rdAddr_id, rs1Addr_id, rs2Addr_id;

output reg [1:0] WB_out, Mem_out;
output reg [6:0] EX_out;
output reg [31:0] PC_ex, Imm_out, rs1Data_out, rs2Data_out;
output reg [4:0] rdAddr_ex, rs1Addr_out, rs2Addr_out;

always@(*) begin
    if (Reset) begin
        WB_out = 0;
        Mem_out = 0;
        EX_out = 0;
        PC_ex = 0;
        Imm_out = 0;
        rs1Data_out = 0;
        rs2Data_out = 0;
        rdAddr_ex = 0;
        rs1Addr_out = 0; 
        rs2Addr_out = 0;
    end
    else begin 
        WB_out = WB;
        Mem_out = Mem;
        EX_out = EX;
        PC_ex = PC_id;
        Imm_out = Imm_id;
        rs1Data_out = rs1Data_id;
        rs2Data_out = rs2Data_id;
        rdAddr_ex = rdAddr_id;
        rs1Addr_out = rs1Addr_id; 
        rs2Addr_out = rs2Addr_id;
    end
end
endmodule