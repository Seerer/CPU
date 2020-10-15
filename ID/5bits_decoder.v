module 5bits_decoder(din, en, dout);

input din[4:0];
input en;
output reg dout[31:0] = 0;

assign dout = (en)? din : 32'b0; 

end module
