module pc(rst, clk, dataOut);

parameter DATA_ADRESS = 10 ;
input rst, clk;
output reg [DATA_ADRESS-1:0] dataOut;

always @(posedge clk)
begin
	if(~rst)
		dataOut = 0;
	else
		dataOut = dataOut + 1'b1;
end

endmodule	