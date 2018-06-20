module registerfile(
	input clk,
	input[31:0] dataIn,
	input[3:0] dataInRegister,
	input enableSavingDataIn,
	input[3:0] dataOutRegisterA,
	input[3:0] dataOutRegisterB,
	output reg[31:0] registerA,
	output reg[31:0] registerB
);

//s0 s7 = 0-7, t0 t7 = 7 - 15

reg[31:0] registerBank[0:15];

initial begin
	integer i;
	for(i = 0; i < 15; i = i + 1)
		registerBank[i] = 0;
end

always @ (posedge clk) begin
	if(enableSavingDataIn) begin
		registerBank[dataInRegister] <= dataIn;
	end
	
	registerA <= registerBank[dataOutRegisterA];
	registerB <= registerBank[dataOutRegisterB];
end

endmodule