`timescale 1ns/10ps
module reg32bits_TB();

reg clk;
reg rst;
reg[31:0] dataIn;
wire[31:0] dataOut;

reg32bits reg32(
	clk,
	rst,
	dataIn,
	dataOut
);

initial begin
	clk <= 0;
	rst <= 0;
	dataIn <= 0;
end

integer i;

always begin
	#550 rst <= 1;
	
	for(i = 0; i < 100; i = i + 1)
		#100 dataIn <= i * 1000;
		
	#300 $stop;
end

always #50 clk = ~ clk;

initial $display("DataIn \tDataOut");
always @ (posedge clk) $display("%d \t%d", dataIn, dataOut);

endmodule
