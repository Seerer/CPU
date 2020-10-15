module adder_unit (a, b, ci, co, s);
input [3:0]a, b;
input ci;
output [3:0]s;
output co;

wire co1, co2;
wire [3:0]s1, s2;
wire andout;

adder_4bits inst1(.a(a), .b(b), .ci(1'b1), .co(co1), .s(s1));
adder_4bits inst2(.a(a), .b(b), .ci(1'b0), .co(co2), .s(s2));

mux2_1 mux1(.sel(ci), .in1(s1), .in2(s2), .co(s));

and G1(andout, co1, ci);
or G2(co, andout, co2);

endmodule
