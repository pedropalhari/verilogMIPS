`timescale 1ns/10ps
module registerfile_TB();

reg clk;
reg rst;
reg[31:0] dataIn;
reg[3:0] dataInRegister;
reg enableSavingDataIn;
reg[3:0] dataOutRegisterA;
reg[3:0] dataOutRegisterB;
wire [31:0] registerA;
wire [31:0] registerB;

registerfile RegisterFile(
	clk,
	rst,
	dataIn,
	dataInRegister,
	enableSavingDataIn,
	dataOutRegisterA,
	dataOutRegisterB,
	registerA,
	registerB
);

initial begin
	clk = 0;
	rst = 0;
	dataIn = 0;
	dataInRegister = 0;
	enableSavingDataIn = 0;
	dataOutRegisterA = 0;
	dataOutRegisterB = 0;
end

always #40 clk = ~clk;

integer i, j;

initial begin
	//Salva em todos os registradores
	#440 rst = 1;
	for(i = 0; i < 16; i = i + 1) begin
		#80
		dataIn <= 10 * i;
		dataInRegister <= i;
		enableSavingDataIn <= 1;
	end
	
	//Pega de todos os registradores com o dataIn tentando gravar em cima dos dados
	for(i = 0; i < 16; i = i + 1) begin
		for(j = 0; j < 16; j = j + 1)begin
			#80
			dataIn <= 999;
			dataInRegister <= 15 - j;			
			enableSavingDataIn <= 0;
			
			dataOutRegisterA <= i;
			dataOutRegisterB <= j;
		end
	end
	
	//Salva em um e le ao mesmo tempo 
	#80
	enableSavingDataIn <= 1;
	dataIn <= 400;
	dataInRegister <= 10;
	dataOutRegisterA <= 5;
	dataOutRegisterB <= 9;
	
	#80
	enableSavingDataIn <= 0;
	dataIn <= 400;
	dataInRegister <= 10;
	dataOutRegisterA <= 5;
	dataOutRegisterB <= 10;
	
	#240
	$stop;
end

initial $display("Reset \tDataIn \tEnableSave \tRegAAddr \tRegBAddr \tRegA \t\tRegB");

always @ (posedge clk) 
 $display("%b \t%d \t\t%d \t\t%d \t\t%d",rst, dataIn, enableSavingDataIn, dataOutRegisterA, dataOutRegisterB, registerA, registerB);

endmodule
