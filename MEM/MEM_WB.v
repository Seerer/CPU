module MEM_MB(WB, MemDout, ALU, rdAddr_ex, MemtoReg_wb, out1, out2, rdAddr_wb);
input [1:0] WB;
input [31:0] MemDout, ALU;
input [4:0] rdAddr_ex;

output reg [1:0] MemtoReg_wb;
output reg [31:0] out1, out2;
output reg [4:0]rdAddr_wb;

always@(*) begin
    MemtoReg_wb = WB;
    out1 = MemDout;
    out2 = ALU;
    rdAddr_wb = rdAddr_ex;
end
endmodule 