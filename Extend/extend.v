module extend(
	input clk,
	input rst,
	input[15:0] dataIn,
	output reg[31:0] dataOut
);

always @ (posedge clk) begin
	if(~rst)
		dataOut <= 0;
	else
		dataOut <= {16'd0, dataIn};
end

endmodule