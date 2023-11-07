
module shifter_tb;
	reg [15:0] in;
	reg [1:0] shift;
	reg err;
	wire [15:0] sout;

	shifter DUT(.in (in),.shift (shift),.sout (sout));

	task check;

	input [15:0] expected_sout;
	
	begin

	if ( shifter_tb.DUT.sout != expected_sout ) begin
		$display("ERROR sout is %b, expected %b", shifter_tb.DUT.sout, expected_sout);
		err = 1'b1;
	end

	end

	endtask

	

	initial begin
	
	err = 1'b0;

	in = 16'b1111000011001111;
	shift = 2'b00;
	#10;

	check( 16'b1111000011001111 );

	shift = 2'b01;
	#10;

	check( 16'b1110000110011110 );

	shift = 2'b10;
	#10;

	check( 16'b0111100001100111 );

	shift = 2'b11;
	#10;

	check( 16'b1111100001100111 );



	if(~err) begin
	$display("passed");
	end
	else begin
	$display("failed");
	end

	

	end

endmodule


	
