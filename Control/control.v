module control(
	input[31:0] instruction,
	output reg[31:0] controlSignal
);

reg[15:0] offset;
reg[3:0] regDest;
reg[3:0] regSrc1;
reg[3:0] regSrc2;

/*
	BIT - 0-3 = (Register File) Registrador do register file que vai para o A
	BIT - 4-7 = (Register File) Registrador do register file que vai para o B
	BIT - 8-11 = (Register File) Registrador do register file que vai ser escrito pela saida D do write-back 
	BIT - 12 = (MUX 1 EXECUTE) Enable/Disable
	BIT - 13-15 = (ALU) Soma, subtração, AND, Or
	BIT - 16 = (Memória de Dados) READ/write
	BIT - 17 = (MUX 2 WRITE-BACK) Enable/Disable
	BIT - 18 = (Register File) Enable/Disable write
	BIT 19-31 = 0x00
*/

always @ (instruction) begin
	//Aritmeticas
	if(instruction[31:26] == 6'b001010) begin
		case(instruction[5:0])
			31: begin //NOP
				regSrc1 = 0;
				regSrc2 = 0;
				regDest = 0;
				
				controlSignal = {regSrc1, regSrc2, regDest, 1'b0, 3'b0, 1'b0, 1'b0, 1'b0, 13'b0000000000000};
			end	
			32: begin //Add
				regSrc1 = instruction[25:21];
				regSrc2 = instruction[20:16];
				regDest = instruction[15:11];
				
				controlSignal = {regSrc1, regSrc2, regDest, 1'b0, 3'b0, 1'b0, 1'b0, 1'b1, 13'b0000000000000};
			end
			34: begin //Sub
				regSrc1 = instruction[25:21];
				regSrc2 = instruction[20:16];
				regDest = instruction[15:11];
				
				controlSignal = {regSrc1, regSrc2, regDest, 1'b0, 3'b1, 1'b0, 1'b0, 1'b1, 13'b0000000000000};
			end
			36: begin //And
				regSrc1 = instruction[25:21];
				regSrc2 = instruction[20:16];
				regDest = instruction[15:11];
				
				controlSignal = {regSrc1, regSrc2, regDest, 1'b0, 3'b10, 1'b0, 1'b0, 1'b1, 13'b0000000000000};
			end
			37: begin //Or
				regSrc1 = instruction[25:21];
				regSrc2 = instruction[20:16];
				regDest = instruction[15:11];
				
				controlSignal = {regSrc1, regSrc2, regDest, 1'b0, 3'b11, 1'b0, 1'b0, 1'b1, 13'b0000000000000};
			end	
			44: begin //Mul
				regSrc1 = instruction[25:21];
				regSrc2 = instruction[20:16];
				regDest = instruction[15:11];
				
				controlSignal = {regSrc1, regSrc2, regDest, 1'b0, 3'b100, 1'b0, 1'b0, 1'b1, 13'b0000000000000};
			end		
			45: begin //Div
				regSrc1 = instruction[25:21];
				regSrc2 = instruction[20:16];
				regDest = instruction[15:11];
				
				controlSignal = {regSrc1, regSrc2, regDest, 1'b0, 3'b101, 1'b0, 1'b0, 1'b1, 13'b0000000000000};
			end
			46: begin //Xor
				regSrc1 = instruction[25:21];
				regSrc2 = instruction[20:16];
				regDest = instruction[15:11];
				
				controlSignal = {regSrc1, regSrc2, regDest, 1'b0, 3'b110, 1'b0, 1'b0, 1'b1, 13'b0000000000000};
			end	
			default: begin //NOP
				regSrc1 = 0;
				regSrc2 = 0;
				regDest = 0;
				
				controlSignal = {regSrc1, regSrc2, regDest, 1'b0, 3'b0, 1'b0, 1'b0, 1'b0, 13'b0000000000000};
			end
		endcase
	end else if (instruction[31:26] == 6'b001011) begin //Load Word
		regSrc1 = instruction[25:21];
		regSrc2 = 0;
		regDest = instruction[20:16];
		
		controlSignal = {regSrc1, regSrc2, regDest, 1'b1, 3'b0, 1'b0, 1'b1, 1'b1, 13'b0000000000000};
	end else if (instruction[31:26] == 6'b001100) begin //Store Word
		regSrc1 = instruction[25:21];
		regSrc2 = instruction[20:16]; //Vai ir pra entrada B da memoria
		regDest = 0;
		
		controlSignal = {regSrc1, regSrc2, regDest, 1'b1, 3'b0, 1'b1, 1'b1, 1'b0, 13'b0000000000000};
	end
end

endmodule
