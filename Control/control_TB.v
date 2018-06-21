`timescale 1ns/10ps
module control_TB();

reg[31:0] instruction;
wire[31:0] controlSignal;

control Control(
	instruction,
	controlSignal
);

reg[31:0] instructionArray [0:15];

integer i; 

initial begin
	instructionArray[0] = 32'b001010_00000_00000_00000_01010_011111;
	instructionArray[1] = 32'b001010_00001_00011_01000_01010_100000;
	instructionArray[2] = 32'b001010_00001_00011_01000_01010_100010;
	instructionArray[3] = 32'b001010_00001_00011_01000_01010_100100;
	instructionArray[4] = 32'b001010_00001_00011_01000_01010_100101;
	instructionArray[5] = 32'b001011_00001_00011_0000_0000_0000_0000; //load
	instructionArray[6] = 32'b001100_00001_00011_0000_0000_0000_0000; //store
	
	for(i = 0; i < 7; i = i + 1) begin
		#100 instruction = instructionArray[i]; 
		#100 $display("%b %d %d", controlSignal, instruction[5:0], instruction[31:25]);
	end
		
	#100 $stop;
end



endmodule
