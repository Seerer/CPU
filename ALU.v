module ALU (A, B, ALUCode, ALUResult);

input [31:0] A, B;
input [3:0] ALUCode;

output [31:0] ALUResult;

wire [31:0]Binvert;
wire [31:0]sum;
wire [31:0]input_B;

assign Binvert = {32{~(ALUCode == 0)}};
assign input_B = B^Binvert;

adder32_bits adder2(.a(A), .b(input_B), .ci(Binvert), .co(), .s(sum));


