module ALU (A, B, ALUCode, ALUResult);

input [31:0] A, B;
input [3:0] ALUCode;

output [31:0] ALUResult;

wire [31:0] Binvert;
wire [31:0] sum;
wire [31:0] input_B;
wire slt, sltu;
wire [31:0] d2, d3, d4, d5, d6, d7, d8, d9, d10;

reg signed[31:0] A_reg;

assign Binvert = {32{~(ALUCode == 0)}};
assign input_B = B^Binvert;

adder32_bits adder2(.a(A), .b(input_B), .ci(Binvert), .co(), .s(sum));

assign d2 = B;
assign d3 = A & B;
assign d4 = A ^ B;
assign d5 = A | B;
assign d6 = A << B;
assign d7 = A >> B;
always @(*) begin A_reg = A; end
assign d8 = A_reg >>> B;

assign slt = A[31] && (~B[31]) || (A[31]~^B[31]) && sum[31];
assign sltu = (~A[31]) && B[31] || (A[31]~^B[31]) && sum[31];;

mux16_1 mux1(sum, sum, d2, d3, d4, d5, d6, d7, d8, slt, sltu, 0, 0, 0, 0, 0, ALUResultU);

endmodule 
