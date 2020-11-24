//role as D triggers
module EX_MEM(WB, Mem, ALU, MemWriteData_ex, rdAddr_ex, WB_out, we, d, ALU_out, rdAddr_ex_out);
input [1:0] WB, Mem;
input [31:0] ALU, MemWriteData_ex;
input [4:0] rdAddr_ex;

output reg [1:0] WB_out, we;
output reg [31:0] ALU_out, d;
output reg [4:0] rdAddr_ex_out;

always@(*) begin 
    WB_out = WB;
    we = Mem;
    ALU_out = ALU;
    d = MemWriteData_ex;
    rdAddr_ex_out = rdAddr_ex;
end
endmodule 