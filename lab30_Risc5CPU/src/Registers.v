
module Registers(clk, rs1Addr, rs2Addr, WriteAddr, RegWrite, WriteData, rs1Data, rs2Data);
	input clk , RegWrite;
	input [4:0] WriteAddr, rs1Addr, rs2Addr;
	input [31:0] WriteData; 

	output [31:0] rs1Data, rs2Data;
	wire rs1Sel, rs2Sel;
	wire [31:0] interdata1, interdata2;

	assign rs1Sel = RegWrite && (WriteAddr != 0) && (WriteAddr == rs1Addr);
	assign rs2Sel = RegWrite && (WriteAddr != 0) && (WriteAddr == rs2Addr);
	
	RGBRegisters rgb1(.clk(clk), .WriteRegister(WriteAddr), .WriteData(WriteData), .RegWrite(RegWrite), 
				.ReadRegister1(rs1Addr), .ReadRegister2(rs2Addr), .ReadData1(interdata1), .ReadData2(interdata2));
	mux2_1 #(.in_width(31), .out_width(31)) mux1(rs1Sel, interdata1, WriteData, rs1Data);
	mux2_1 #(.in_width(31), .out_width(31)) mux2(rs2Sel, interdata2, WriteData, rs2Data);
endmodule

