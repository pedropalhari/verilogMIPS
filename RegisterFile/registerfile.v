module registerfile(
	input clk,
	input rst,
	input[31:0] dataIn,
	input[3:0] dataInRegister,
	input enableSavingDataIn,
	input[3:0] dataOutRegisterA,
	input[3:0] dataOutRegisterB,
	output reg[31:0] registerA,
	output reg[31:0] registerB
);

//s0 s7 = 0-7, t0 t7 = 7 - 15

reg[31:0] s0;
reg[31:0] s1;
reg[31:0] s2;
reg[31:0] s3;
reg[31:0] s4;
reg[31:0] s5;
reg[31:0] s6;
reg[31:0] s7;
reg[31:0] t0;
reg[31:0] t1;
reg[31:0] t2;
reg[31:0] t3;
reg[31:0] t4;
reg[31:0] t5;
reg[31:0] t6;
reg[31:0] t7;

reg [3:0] i;

initial begin
 s0 <= 0;
 s1 <= 0;
 s2 <= 0;
 s3 <= 0;
 s4 <= 0;
 s5 <= 0;
 s6 <= 0;
 s7 <= 0;
 t0 <= 0;
 t1 <= 0;
 t2 <= 0;
 t3 <= 0;
 t4 <= 0;
 t5 <= 0;
 t6 <= 0;
 t7 <= 0;
end

always @ (posedge clk) begin
	if(~rst) begin
		 s0 <= 0;
		 s1 <= 0;
		 s2 <= 0;
		 s3 <= 0;
		 s4 <= 0;
		 s5 <= 0;
		 s6 <= 0;
		 s7 <= 0;
		 t0 <= 0;
		 t1 <= 0;
		 t2 <= 0;
		 t3 <= 0;
		 t4 <= 0;
		 t5 <= 0;
		 t6 <= 0;
		 t7 <= 0;
	end
	else begin
		if(enableSavingDataIn) begin
			case(dataInRegister)
				0: s0 <= dataIn;
				1: s1 <= dataIn;
				2: s2 <= dataIn;
				3: s3 <= dataIn;
				4: s4 <= dataIn;
				5: s5 <= dataIn;
				6: s6 <= dataIn;
				7: s7 <= dataIn;
				8: t0 <= dataIn;
				9: t1 <= dataIn;
				10: t2 <= dataIn;
				11: t3 <= dataIn;
				12: t4 <= dataIn;
				13: t5 <= dataIn;
				14: t6 <= dataIn;
				15: t7 <= dataIn;
			endcase
		end
		
		case(dataOutRegisterA)
			0: registerA <= s0; 
			1: registerA <= s1; 
			2: registerA <= s2; 
			3: registerA <= s3; 
			4: registerA <= s4; 
			5: registerA <= s5; 
			6: registerA <= s6; 
			7: registerA <= s7; 
			8: registerA <= t0; 
			9: registerA <= t1; 
			10: registerA <= t2; 
			11: registerA <= t3; 
			12: registerA <= t4; 
			13: registerA <= t5; 
			14: registerA <= t6; 
			15: registerA <= t7; 
		endcase
		
		case(dataOutRegisterB)
			0: registerB <= s0; 
			1: registerB <= s1; 
			2: registerB <= s2; 
			3: registerB <= s3; 
			4: registerB <= s4; 
			5: registerB <= s5; 
			6: registerB <= s6; 
			7: registerB <= s7; 
			8: registerB <= t0; 
			9: registerB <= t1; 
			10: registerB <= t2; 
			11: registerB <= t3; 
			12: registerB <= t4; 
			13: registerB <= t5; 
			14: registerB <= t6; 
			15: registerB <= t7; 
		endcase
	end
end

endmodule