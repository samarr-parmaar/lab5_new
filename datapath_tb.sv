
module datapath_tb;

	reg write, vsel, loada, loadb, asel, bsel, loadc, loads, clk, err;
	reg [2:0] readnum, writenum;
	reg [1:0] shift, ALUop;
	reg [15:0] datapath_in;
	wire Z_out;
	wire [15:0] datapath_out;

	`define undefined 16'bxxxxxxxxxxxxxxxx

	datapath DUT ( .clk         (clk), // recall from Lab 4 that KEY0 is 1 when NOT pushed

                // register operand fetch stage
                .readnum     (readnum),
                .vsel        (vsel),
                .loada       (loada),
                .loadb       (loadb),

                // computation stage (sometimes called "execute")
                .shift       (shift),
                .asel        (asel),
                .bsel        (bsel),
                .ALUop       (ALUop),
                .loadc       (loadc),
                .loads       (loads),

                // set when "writing back" to register file
                .writenum    (writenum),
                .write       (write),  
                .datapath_in (datapath_in),

                // outputs
                .Z_out       (Z_out),
                .datapath_out(datapath_out)
             );

	wire [15:0] R0 = DUT.REGFILE.R0;
 	wire [15:0] R1 = DUT.REGFILE.R1;
  	wire [15:0] R2 = DUT.REGFILE.R2;
  	wire [15:0] R3 = DUT.REGFILE.R3;
  	wire [15:0] R4 = DUT.REGFILE.R4;
  	wire [15:0] R5 = DUT.REGFILE.R5;
  	wire [15:0] R6 = DUT.REGFILE.R6;
  	wire [15:0] R7 = DUT.REGFILE.R7;

	task check1;

	input expected_Z_out;
	input [15:0] expected_datapath_out;

	begin

	if ( datapath_tb.DUT.Z_out != expected_Z_out ) begin
		$display("ERROR Z_out is %b, expected %b", datapath_tb.DUT.Z_out, expected_Z_out);
		err = 1'b1;
	end

	if ( datapath_tb.DUT.datapath_out != expected_datapath_out ) begin
		$display("ERROR datapath_out is %b, expected %b", datapath_tb.DUT.datapath_out, expected_datapath_out);
		err = 1'b1;
	end

	end

	endtask

	task check2;

	input [15:0] expected_R0;
	input [15:0] expected_R1;
	input [15:0] expected_R2;
	input [15:0] expected_R3;
	input [15:0] expected_R4;
	input [15:0] expected_R5;
	input [15:0] expected_R6;
	input [15:0] expected_R7;

	begin

	if (R0 !== expected_R0) begin 
      		err = 1'b1; 
      		$display("ERROR R0 is %b, expected %b", R0, expected_R0);  
    	end

	if (R1 !== expected_R1) begin 
      		err = 1'b1; 
      		$display("ERROR R1 is %b, expected %b", R1, expected_R1);  
    	end

	if (R2 !== expected_R2) begin 
      		err = 1'b1; 
      		$display("ERROR R2 is %b, expected %b", R2, expected_R2);  
    	end

	if (R3 !== expected_R3) begin 
      		err = 1'b1; 
      		$display("ERROR R3 is %b, expected %b", R3, expected_R3);  
    	end

	if (R4 !== expected_R4) begin 
      		err = 1'b1; 
      		$display("ERROR R4 is %b, expected %b", R4, expected_R4);  
    	end

	if (R5 !== expected_R5) begin 
      		err = 1'b1; 
      		$display("ERROR R5 is %b, expected %b", R5, expected_R5);  
    	end

	if (R6 !== expected_R6) begin 
      		err = 1'b1; 
      		$display("ERROR R6 is %b, expected %b", R6, expected_R6);  
    	end

	if (R7 !== expected_R7) begin 
      		err = 1'b1; 
      		$display("ERROR R7 is %b, expected %b", R7, expected_R7);  
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
	
	datapath_in = 0;
    	write = 0; vsel=0; loada=0; loadb=0; asel=0; bsel=0; loadc=0; loads=0;
  	readnum = 0; writenum=0;
  	shift = 0; ALUop=0;

	#10;

	

	datapath_in = 16'b0000000000000111;
	writenum = 3'b000;
	write = 1'b1;
	vsel = 1'b1;
	#10;

	check2(16'b0000000000000111, `undefined, `undefined, `undefined, `undefined, `undefined, `undefined, `undefined);

	datapath_in = 16'b0000000000000010;
	writenum = 3'b001;
	write = 1'b1;
	vsel = 1'b1;
	#10;
	write = 1'b0;

	check2(16'b0000000000000111, 16'b0000000000000010, `undefined, `undefined, `undefined, `undefined, `undefined, `undefined);

	readnum = 3'b000;
	loadb = 1'b1;
	#10;
	loadb = 1'b0;

	readnum = 3'b001;
	loada = 1'b1;
	#10;
	loada = 1'b0;

	
   	shift = 2'b01;
  	asel = 1'b0;
  	bsel = 1'b0;
  	ALUop = 2'b00;
  	loadc = 1'b1;
  	loads = 1'b1;
	#10;
	loadc = 1'b0;
    	loads = 1'b0;

	write = 1'b1;
    	writenum = 3'b010;
    	vsel = 1'b0;
    	#10;
    	write = 1'b0;

	check2(16'b0000000000000111, 16'b0000000000000010, 16'b0000000000010000, `undefined, `undefined, `undefined, `undefined, `undefined);

	check1( 1'b0, 16'b0000000000010000);

	datapath_in = 16'b0000000000000010;
	writenum = 3'b110;
	write = 1'b1;
	vsel = 1'b1;
	#10;

	check2(16'b0000000000000111, 16'b0000000000000010, 16'b0000000000010000, `undefined, `undefined, `undefined, 16'b0000000000000010, `undefined);

	datapath_in = 16'b0000000000000001;
	writenum = 3'b111;
	write = 1'b1;
	vsel = 1'b1;
	#10;
	write = 1'b0;

	check2(16'b0000000000000111, 16'b0000000000000010, 16'b0000000000010000, `undefined, `undefined, `undefined, 16'b0000000000000010, 16'b0000000000000001);

	readnum = 3'b111;
	loadb = 1'b1;
	#10;
	loadb = 1'b0;

	readnum = 3'b110;
	loada = 1'b1;
	#10;
	loada = 1'b0;

	
   	shift = 2'b00;
  	asel = 1'b0;
  	bsel = 1'b0;
  	ALUop = 2'b01;
  	loadc = 1'b1;
  	loads = 1'b1;
	#10;
	loadc = 1'b0;
    	loads = 1'b0;

	write = 1'b1;
    	writenum = 3'b101;
    	vsel = 1'b0;
    	#10;
    	write = 1'b0;

	check2(16'b0000000000000111, 16'b0000000000000010, 16'b0000000000010000, `undefined, `undefined, 16'b0000000000000001, 16'b0000000000000010, 16'b0000000000000001);

	check1( 1'b0, 16'b0000000000000001);

	

	
	

	

	if(~err) begin
	$display("passed");
	end
	else begin
	$display("failed");
	end

	
	

	end

endmodule