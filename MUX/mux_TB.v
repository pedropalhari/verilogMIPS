`timescale 1ns/10ps
module mux_TB();

reg[31:0] A;
reg[31:0] B;
reg selector;
wire[31:0] muxOut;

mux MUX(
	A,
	B,
	selector,
	muxOut
);

initial begin
	A <= 100;
	B <= 200;
	selector <= 0;
	
	#50
	A <= 100;
	B <= 200;
	selector <= 1;
	
	#50
	A <= 100;
	B <= 200;
	selector <= 0;
	
	#50 $stop;
end

initial begin
	$display("\tA \t\tB \tSel \t\tOUT\n");
	
	#50
	$display("%d \t%d \t%d \t%d\n", A, B, selector, muxOut);
	
	#50
	$display("%d \t%d \t%d \t%d\n", A, B, selector, muxOut);
	
	#50
	$display("%d \t%d \t%d \t%d\n", A, B, selector, muxOut);
end

endmodule
