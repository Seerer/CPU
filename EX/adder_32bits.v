module adder_32bits(a, b, ci, co, s);
input [31:0]a, b;
input ci;
output co;
output [31:0]s;

wire cout1, cout2, cout3, cout4, cout5, cout6, cout7;
adder_4bits addr1(a[3:0], b[3:0], ci, cout1, s[3:0]);

adder_unit u1(a[7:4], b[7:4], cout1, cout2, s[7:4]);
adder_unit u2(a[11:8], b[11:8], cout2, cout3, s[11:8]);
adder_unit u3(a[15:12], b[15:12], cout3, cout4, s[15:12]);
adder_unit u4(a[19:16], b[19:16], cout4, cout5, s[19:16]);
adder_unit u5(a[23:20], b[23:20], cout5, cout6, s[23:20]);
adder_unit u6(a[27:24], b[27:24], cout6, cout7, s[27:24]);
adder_unit u7(a[31:28], b[31:28], cout7, co, s[31:28]);

endmodule
