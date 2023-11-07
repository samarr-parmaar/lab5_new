
module shifter(in,shift,sout);
input [15:0] in;
input [1:0] shift;
output reg [15:0] sout;

	`define LSB in[0]
	`define MSB in[15]

	always_comb begin

	case(shift)

	2'b00 : sout = in;

	2'b01 : begin
		sout = in << 1;
		sout[0] = 1'b0;
		end

	2'b10 : begin
		sout = in >> 1;
		sout[15] = 1'b0;
		end

	2'b11 : begin
		sout = in >> 1;
		sout[15] = `MSB;
		end

	default : sout = 16'bxxxxxxxxxxxxxxxx;

	

	endcase

	end

endmodule
