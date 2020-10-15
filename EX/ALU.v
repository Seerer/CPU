module ALU (A, B, ALUCode, ALUResult);

input [31:0] A, B;
input [3:0] ALUCode;

output [31:0] ALUResult;

wire [31:0]Binvert;
wire [31:0]sum;
wire [31:0]input_B;
wire slt, sltu;

assign Binvert = {32{~(ALUCode == 0)}};
assign input_B = B^Binvert;
assign slt = A[31] && (~B[31]) || (A[31]~^B[31]) && sum[31];
assign sltu = (~A[31]) && B[31] || (A[31]~^B[31]) && sum[31];;

adder32_bits adder2(.a(A), .b(input_B), .ci(Binvert), .co(), .s(sum));
mux16_1 mux1(sum, sum, B, (A & B), (A ^ B), (A | B), 0, 0, 0, slt, sltu, 0, 0, 0, 0, 0, ALUCode, ALUResult);

