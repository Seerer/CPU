//******************************************************************************
//分支检测电路的设计
//******************************************************************************
module Branch_Test (rs1Data, rs2Data, Branch, funct3, SB_type);
	input [31:0] rs1Data, rs2Data;
	input [2:0] funct3;
	input SB_type;

	output reg Branch = 0;

	parameter  BEQ_funct3 =       3'b000;
	parameter  BNE_funct3 =       3'b001;
	parameter  BLT_funct3 =       3'b100;
	parameter  BGE_funct3 =       3'b101;
	parameter  BLTU_funct3 =      3'b110;
	parameter  BGEU_funct3 =      3'b111;

	wire [31:0]sum;
	wire isLT, isLTU;

	adder_32bits adder1(.a(rs1Data), .b(~rs2Data+1), .ci(0), .co(), .s(sum));

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
		            Branch = isLT;
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
		        default: begin
		            Branch = 0;
		        end
	        endcase
        end
		else begin
			Branch = 0;
		end
	end
endmodule 