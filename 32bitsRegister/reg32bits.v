module reg32bits(
	input clk,
	input rst,
	input[31:0] dataIn,
	output reg[31:0] dataOut
);

always @ (posedge clk) begin
	if(~rst)
		dataOut <= 0;
	else
		dataOut <= dataIn;
end

endmodule
