module regfile_tb;

	reg [15:0] data_in;
	reg [2:0] writenum, readnum;
	reg write, clk, err;
	wire [15:0] data_out;

	regfile DUT(.data_in (data_in),.writenum (writenum),.write (write),.readnum (readnum),.clk (clk),.data_out (data_out));

	task check;

	input [15:0] expected_out;

	begin

	if ( regfile_tb.DUT.data_out != expected_out ) begin
		$display("ERROR data_out is %b, expected %b",regfile_tb.DUT.data_out, expected_out);
		err = 1'b1;
	end  

	end

	endtask

	

	initial begin

	clk = 1'b0; #5;

	forever begin
		
		clk = 1'b1; #5;
		clk = 1'b0; #5;

	end

	end



	initial begin

	err = 1'b0;
	data_in = 16'b0000000000000001;
	writenum = 3'b000;
	write = 1'b1;
	readnum = 3'b000;
	#10;

	check( 16'b0000000000000001 );

	data_in = 16'b0000000000000010;
	writenum = 3'b001;
	write = 1'b1;
	readnum = 3'b001;
	#10;

	check(16'b0000000000000010);

	data_in = 16'b0000000000000011;
	writenum = 3'b010;
	write = 1'b1;
	readnum = 3'b010;
	#10;

	check(16'b0000000000000011);

	data_in = 16'b0000000000000100;
	writenum = 3'b011;
	write = 1'b1;
	readnum = 3'b011;
	#10;

	check(16'b0000000000000100);

	data_in = 16'b0000000000000101;
	writenum = 3'b100;
	write = 1'b1;
	readnum = 3'b100;
	#10;

	check(16'b0000000000000101);

	data_in = 16'b0000000000000110;
	writenum = 3'b101;
	write = 1'b1;
	readnum = 3'b101;
	#10;

	check(16'b0000000000000110);

	data_in = 16'b0000000000000111;
	writenum = 3'b110;
	write = 1'b1;
	readnum = 3'b110;
	#10;

	check(16'b0000000000000111);

	data_in = 16'b0000000000001000;
	writenum = 3'b111;
	write = 1'b1;
	readnum = 3'b111;
	#10;

	check(16'b0000000000001000);

	data_in = 16'b0000000000001001;
	writenum = 3'b000;
	write = 1'b1;
	readnum = 3'b000;
	#10;

	check(16'b0000000000001001);

	data_in = 16'b0000000000001010;
	writenum = 3'b000;
	write = 1'b0;
	readnum = 3'b000;
	#10;

	check(16'b0000000000001001);

	

	

	if(~err) begin
	$display("passed");
	end
	else begin
	$display("failed");
	end

	

	end

endmodule

	 
