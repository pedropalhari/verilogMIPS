module cpu(
	input clk,
	input rst,
	output[31:0] out1,
	output[31:0] out2,
	output[31:0] out3,
	output[31:0] out4
);

//Fetch
wire[9:0] pcToInstructionMemory;
wire[31:0] instructionMemoryToControl;

//Decode
wire[31:0] controlSignalToRegCtrl0;
wire[31:0] extendToMUX1;

//Execute
wire[31:0] controlSignalToRegCtrl1;
wire[31:0] wireRegA;
wire[31:0] wireRegB;
wire[31:0] mux1ToAlu;

//Memory
wire[31:0] controlSignalToRegCtrl2;
wire[31:0] aluToRegD1;
wire[31:0] regD1ToRegD2;
wire[31:0] wireRegBToMemory;

//Write-back
wire[31:0] regD2ToWriteBack;
wire[31:0] memoryToMux2;
wire[31:0] controlSignalToWriteBack;
wire[31:0] muxToRegisterFile;

assign out1 = controlSignalToRegCtrl0;
assign out2 = wireRegA;
assign out3 = wireRegB;
assign out4 = aluToRegD1;

pc PC(rst, clk, pcToInstructionMemory);
instructionmemory InstructionMemory(clk, pcToInstructionMemory, instructionMemoryToControl);

control Control(instructionMemoryToControl, controlSignalToRegCtrl0);
extend Extend(clk, rst, instructionMemoryToControl[15:0], extendToMUX1);
registerfile RegisterFile(
	clk, 
	rst, 
	muxToRegisterFile, 
	controlSignalToWriteBack[23:20],
	controlSignalToWriteBack[13],
	controlSignalToRegCtrl0[31:28],
	controlSignalToRegCtrl0[27:24],
	wireRegA,
	wireRegB
);

mux MUX1(wireRegB, extendToMUX1, controlSignalToRegCtrl1[19], mux1ToAlu);
alu ALU(wireRegA, mux1ToAlu, controlSignalToRegCtrl1[18:16], aluToRegD1);

datamemory DataMemory(regD1ToRegD2, wireRegBToMemory, memoryToMux2, clk, controlSignalToRegCtrl2[15]);
mux MUX2(regD2ToWriteBack, memoryToMux2, controlSignalToWriteBack[14], muxToRegisterFile);

reg32bits RegCtrl0(clk, rst, controlSignalToRegCtrl0, controlSignalToRegCtrl1);
reg32bits RegCtrl1(clk, rst, controlSignalToRegCtrl1, controlSignalToRegCtrl2);
reg32bits RegCtrl2(clk, rst, controlSignalToRegCtrl2, controlSignalToWriteBack);

reg32bits RegB(clk, rst, wireRegB, wireRegBToMemory);
reg32bits RegD1(clk, rst, aluToRegD1, regD1ToRegD2);
reg32bits RegD2(clk, rst, regD1ToRegD2, regD2ToWriteBack);

endmodule