
module ALU_tb;

	reg [15:0] Ain, Bin;
	reg [1:0] ALUop;
	reg err;
	wire [15:0] out;
	wire Z;

	ALU DUT(.Ain (Ain),.Bin (Bin),.ALUop (ALUop),.out (out),.Z (Z)); //initializes the ALU as dut

	task check;
	
	input [15:0] expected_out;
	input expected_Z;

	begin

		if ( ALU_tb.DUT.out != expected_out ) begin  //checks that the arithmetic output is correct
		$display("ERROR out is %b, expected %b", ALU_tb.DUT.out, expected_out);
		err = 1'b1;
	end

		if ( ALU_tb.DUT.Z != expected_Z ) begin		//checks that the Z is set at the proper time 
		$display("ERROR Z is %b, expected %b", ALU_tb.DUT.Z, expected_Z);
		err = 1'b1;
	end

	end

	endtask

	

	initial begin

	err = 1'b0;
	Ain = 16'b0000000000000001;
	Bin = 16'b0000000000000001;
	ALUop = 2'b00;
	#10;
	
		check( 16'b0000000000000010, 1'b0); //Checks the addition 1 + 1 =2, and that Z = 0

	ALUop = 2'b01; 
	#10;
	
		check( 16'b0000000000000000, 1'b1); //Checks the subtraction 1 - 1 =0, and that when out = 0 that z = 1

	ALUop = 2'b10;
	#10;

		check( 16'b0000000000000001, 1'b0); //checks the bitwise anding between the two inputs

	ALUop = 2'b11; 
	#10;

		check( 16'b1111111111111110, 1'b0); //checks the negation of B

	Ain = 16'b0000000000010100; //changes the input A
	Bin = 16'b0000000000001010; //changes the input B
	ALUop = 2'b00;			// checks addition witht the new inputs
	#10;

	check( 16'b0000000000011110, 1'b0);

	ALUop = 2'b01; //checks subtraction with the new inputs
	#10;

	check( 16'b0000000000001010, 1'b0);

	ALUop = 2'b10; //checks anding with the new inputs
	#10;

	check( 16'b0000000000000000, 1'b1);

	ALUop = 2'b11; //checks negation with new input B
	#10;

	check( 16'b1111111111110101, 1'b0);





		if(~err) begin	//displays final result
	$display("passed");
	end
	else begin
	$display("failed");
	end
	
	end

endmodule


	

	

	
