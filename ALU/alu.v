module alu(
	input[31:0] A,
	input[31:0] B,
	input[2:0] op,
	output[31:0] aluOut
);

assign aluOut = 
	op == 0 
		? A + B
	: op == 1
		? A - B
	: op == 2
		? A & B
	: op == 3
		? A | B
	: op == 4
		? A * B
	: op == 5
		? A / B
	: op == 6
		? A ^ B
	: 0;

endmodule
