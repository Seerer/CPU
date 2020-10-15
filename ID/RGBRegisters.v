module RGWRegisters(clk, WriteRegister, WriteData, RegWrite, ReadRegister1, ReadRegister2, ReadData1, ReadData2);

input RegWrite, clk; 
input [31:0] WriteData, ReadRegister1, ReadRegister2;
input [4:0] WriteRegister, ReadData1, ReadData2;
 

reg [31:0]regs [31:0];


assign ReadData1 = (ReadData1 == 5'b0) ? 32'b0 : regs[ReadData1];
assign ReadData2 = (ReadData2 == 5'b0) ? 32'b0 : regs[ReadData2];
always @(posedge clk) if(RegWrite) regs[WriteRegister] <= WriteData;

endmodule
