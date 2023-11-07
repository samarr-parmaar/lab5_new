
module ALU(Ain,Bin,ALUop,out,Z);
input [15:0] Ain, Bin;
input [1:0] ALUop;
output reg [15:0] out;
output reg Z;

	always_comb begin

	if( ALUop == 2'b00 ) begin
		
		out = Ain + Bin;

	end

	else if ( ALUop == 2'b01 ) begin
	
		out = Ain - Bin;

	end

	else if ( ALUop == 2'b10 ) begin
	
		out = Ain & Bin;

	end

	else begin

		out = ~Bin;

	end

	

	if( out == 16'b0000000000000000 ) begin
	
		Z = 1'b1;

	end

	else begin

		Z = 1'b0;

	end

	end

endmodule
