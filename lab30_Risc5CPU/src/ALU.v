module ALU (A, B, ALUCode, ALUResult);
	input [31:0] A, B;
	input [3:0] ALUCode;

	output [31:0] ALUResult;

// Decoded ALU operation select (ALUsel) signals
   parameter	 alu_add=  4'b0000;
   parameter	 alu_sub=  4'b0001;
   parameter	 alu_lui=  4'b0010;
   parameter	 alu_and=  4'b0011;
   parameter	 alu_xor=  4'b0100;
   parameter	 alu_or =  4'b0101;
   parameter 	 alu_sll=  4'b0110;
   parameter	 alu_srl=  4'b0111;
   parameter	 alu_sra=  4'b1000;
   parameter	 alu_slt=  4'b1001;
   parameter	 alu_sltu= 4'b1010; 	

	wire [31:0] Binvert;
	wire [31:0] sum;
	wire [31:0] input_B;
	wire slt, sltu;
	wire [31:0] d2, d3, d4, d5, d6, d7, d8;

	reg signed[31:0] A_reg;
	reg [3:0] sel;

	always@(*) begin
		case(ALUCode)
			alu_add:sel=0;
			alu_sub:sel=0;
			alu_lui:sel=1;
			alu_and:sel=2;
			alu_xor:sel=3;
			alu_or:sel=4;
			alu_sll:sel=5;
			alu_srl:sel=6;
			alu_sra:sel=7;
			alu_slt:sel=8;
			alu_sltu:sel=9; 	
			default:sel=0;
      endcase
	end

	assign Binvert = {32{~(ALUCode == 0)}};
	assign input_B = B^Binvert;
	adder_32bits adder2(.a(A), .b(input_B), .ci(Binvert[0]), .co(), .s(sum));

	assign d2 = B;
	assign d3 = A & B;
	assign d4 = A ^ B;
	assign d5 = A | B;
	assign d6 = A << B;
	assign d7 = A >> B;
	always @(*) begin 
		A_reg = A; 
		A_reg = A_reg >>> B;
	end
	assign d8 = A_reg;

	assign slt = A[31] && (~B[31]) || (A[31]~^B[31]) && sum[31];
	assign sltu = (~A[31]) && B[31] || (A[31]~^B[31]) && sum[31];
	mux10_1 mux1(sum, d2, d3, d4, d5, d6, d7, d8, slt, sltu, sel, ALUResult);
endmodule 
