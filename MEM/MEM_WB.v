module MEM_WB(WB, MemDout, ALU, rdAddr_ex, WB_out_MEM_WB, out1, out2, rdAddr_wb, reset, clk);
    input clk, reset;
    input [1:0] WB;
    input [31:0] MemDout, ALU;
    input [4:0] rdAddr_ex;

    output reg [1:0] WB_out_MEM_WB;
    output reg [31:0] out1, out2;
    output reg [4:0]rdAddr_wb;

    always@(posedge clk) begin
        if (reset) begin
            WB_out_MEM_WB = 0;
            out1 = 0;
            out2 = 0;
            rdAddr_wb = 0;
        end
        else begin
            WB_out_MEM_WB = WB;
            out1 = MemDout;
            out2 = ALU;
            rdAddr_wb = rdAddr_ex;
        end
    end
endmodule 