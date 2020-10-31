//******************************************************************************
//分支检测电路的设计
//******************************************************************************
module Branch_Test (rs1Data, rs2Data, Branch, funct3, SB_type);
	input [31:0] rs1Data, rs2Data;
	input [2:0] funct3;
	input [6:0] SB_type;

	output reg Branch;

	parameter  BEQ_funct3 =       3'b000,
	parameter  BNE_funct3 =       3'b001,
	parameter  BLT_funct3 =       3'b100,
	parameter  BGE_funct3 =       3'b101,
	parameter  BLTU_funct3 =      3'b110,
	parameter  BGEU_funct3 =      3'b111,
	parameter  LW_funct3 =        3'b010,
	parameter  LH_funct3 =        3'b001,
	parameter  LB_funct3 =        3'b000,
	parameter  SW_funct3 =        3'b010,

	wire [31:0]sum;
	wire isLT, isLTU;

	adder_32bits adder1(.a(rs1Data), .b(~rs2Data), .ci(1), .co(), .s(sum));

	assign isLT = rs1Data[31] && (~rs2Data[31]) || (rs1Data[31]~^rs2Data[31]) && sum[31];
	assign isLTU = (~rs1Data[31]) && rs2Data[31] || (rs1Data[31]~^rs2Data[31]) && sum[31];

	always @(*) begin
		if (SB_type) begin
	    	case (funct3)
		    	BEQ_funct3: begin
		           	Branch = ~(|sum[31:0]);
		        end
		        BNE_funct3: begin
		            Branch = |sum[31:0];
		        end
		        BLT_funct3: begin
		            Branch = isLT；
		        end
		        BGE_funct3: begin
		            Branch = ~isLT;
		        end
		        BLTU_funct3: begin
		            Branch = isLTU;
		        end
		        BGEU_funct3: begin
		            Branch = ~isLTU;
		        end
		        dafault: begin
		            Branch = 0;
		        end
	        endcase
        end
	end
endmodule 