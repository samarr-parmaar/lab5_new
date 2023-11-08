
module datapath(clk, readnum, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads,
 	writenum, write, datapath_in, Z_out, datapath_out);

	input write, vsel, loada, loadb, asel, bsel, loadc, loads, clk;
	input [2:0] readnum, writenum;
	input [1:0] shift, ALUop;
	input [15:0] datapath_in;
	output Z_out;
	output [15:0] datapath_out; //initializes the inputs and outputs
	
	wire [15:0] data_in;
	wire [15:0] data_out;

	wire [15:0] regA;
	wire [15:0] in;
	wire [15:0] sout;
	wire [15:0] Ain;
	wire [15:0] Bin;
	wire Z;
	wire [15:0] out;  //internal signals
	

	assign data_in = vsel ? datapath_in : datapath_out; //mux for which signal is input into the regfile 

	regfile REGFILE(data_in,writenum,write,readnum,clk,data_out); //initializing regfile module

	vDFFE #(16) A(clk,loada,data_out,regA); //initializes register for A input to ALU

	vDFFE #(16) B(clk,loadb,data_out,in);   //initializes register for B input to ALU

	shifter U1(in,shift,sout); //initializes shifter module

	assign Ain = asel ? 16'b0000000000000000 : regA; //multiplexer for A

	assign Bin = bsel ? {11'b0,datapath_in[4:0]} : sout; //multiplexer for B

	ALU U2(Ain,Bin,ALUop,out,Z); //the arithmetic Unit

	vDFFE #(16) C(clk,loadc,out,datapath_out); //register for output
	vDFFE status(clk,loads,Z,Z_out); //register for Z


	

	

endmodule


module vDFFE(clk, en, in, out); //module for register with load enable
	
	parameter n = 1;
	input clk, en;
	input [n-1:0] in;
	output reg [n-1:0] out;
	wire [n-1:0] next_state;

	assign next_state = en ? in : out;

	always @(posedge clk)
		out = next_state;

endmodule
