
module Registers(clk, rs1Addr, rs2Addr, WriteAddr, RegWrite, WriteData, rs1Data, rs2Data);
	input clk , RegWrite;
	input [4:0] WriteAddr, rs1Addr, rs2Addr;
	input [31:0] WriteData; 

	output [31:0] rs1Data, rs2Data;
	wire rs1Sel, rs2Sel;

	assign rs1Sel = RegWrite && (WriteAddr != 0) && (WriteAddr == rs1Addr);
	assign rs2Sel = RegWrite && (WriteAddr != 0) && (WriteAddr == rs2Addr);

	RGBRegisters r1(clk, WriteAddr, WriteData, RegWrite, rs1Addr, rs2Addr, rs1Data, rs2Data);
	mux2_1 #(.in_width(31), .out_width(4)) mux1(rs1Sel, rs1Data, WriteData, rs1Data);
	mux2_1 #(.in_width(31), .out_width(4)) mux2(rs2Sel, rs2Data, WriteData, rs2Data);
endmodule

