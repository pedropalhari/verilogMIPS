`timescale 1ns/10ps
module alu_TB();

reg[31:0] A;
reg[31:0] B;
reg[2:0] op;
wire[31:0] aluOut;

alu ALU(
	A,
	B,
	op,
	aluOut
);

integer i;

initial begin
	A <= 6000;
	B <= 5000;
	op <= 0;
	
	for(i = 1; i < 7; i = i + 1)
		#100 op <= i;	
		
	#1000 $stop;
end

initial begin
	$display("op \t\tA \t\tB \t\tsaida \t\tABits \t\t\t\t\tBBits \t\t\t\t\tsaidaBits");
end

always #100 $display("%d \t%d \t%d \t%d \t%b \t%b \t%B", op, A, B, aluOut, A, B, aluOut);

endmodule