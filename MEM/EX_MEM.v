//role as D triggers
module EX_MEM(WB, Mem, ALU, MemWriteData_ex, rdAddr_ex, WB_out_EX_MEM, we, d, ALUResult_mem, rdAddr_ex_out, clk, reset);
    input clk, reset;
    input [1:0] WB, Mem;
    input [31:0] ALU, MemWriteData_ex;
    input [4:0] rdAddr_ex;

    output reg we;
    output reg [1:0] WB_out_EX_MEM = 0;
    output reg [31:0] ALUResult_mem = 0, d = 0;
    output reg [4:0] rdAddr_ex_out = 0;

    always@(posedge clk) begin
        if (reset) begin
            WB_out_EX_MEM = 0;
            we = 0;
            ALUResult_mem = 0;
            d = 0;
            rdAddr_ex_out = 0;
        end
        else begin
            WB_out_EX_MEM = WB;
            we = Mem[1];
            ALUResult_mem = ALU;
            d = MemWriteData_ex;
            rdAddr_ex_out = rdAddr_ex;    
        end
    end
endmodule 