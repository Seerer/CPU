module DataRAM (write_en, addr, Data_in, Data_out);
//module DataRAM (read_en, write_en, LoadType, addr, Data_in, Data_out);
	//input read_en;
	input write_en;
	//input [1:0] LoadType;
	input [5:0] addr;
	input [31:0] Data_in;

	output reg [31:0] Data_out;
//[word size] regname [array size]
	reg [31:0] RAM[63:0]
	
	// always@(*) begin
	// 	if(read_en)
	// 		case(LoadType)
	// 			2'b00: Data_out = RAM[addr];							//LW
	// 			2'b01: Data_out = {{17{RAM[addr][15]}}, RAM[14 : 0]};   //LH
	// 			2'b10: Data_out = {{26{RAM[addr][7]}}, RAM[6 : 0]};     //LB
	// 			default: Data_out = 32'b0;
	// 		endcase
	// end

	always@(*) begin
		if(write_en) begin 
			RAM[addr] = Data_in;
			Data_out = 32'b0;
		end
		else begin
			Data_out = RAM[addr];
		end
	end
endmodule

