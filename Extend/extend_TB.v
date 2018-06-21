`timescale 1ns/10ps
module extend_TB();

reg clk;
reg rst;
reg[15:0] dataIn;
wire[31:0] dataOut;

extend EXTEND(
	clk,
	rst,
	dataIn,
	dataOut
);

initial begin
	clk <= 0;
	rst <= 0;
	dataIn <= 2**15;
	
	#250 rst <= 1;
	#300 $stop;
end

always #50 clk = ~clk;

initial $display("DataIn \t\tReset \t\t\tDataOut");
always @ (posedge clk) $display("%b \t%b \t\t%b", dataIn, rst, dataOut);

endmodule
