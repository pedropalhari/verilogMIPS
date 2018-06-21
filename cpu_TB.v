`timescale 1ns/10ps
module cpu_TB();

reg clk;
reg rst;
wire[31:0] out1;
wire[31:0] out2;
wire[31:0] out3;
wire[31:0] out4;

cpu CPU(
	clk,
	rst,
	out1,
	out2,
	out3,
	out4
);

initial begin
	clk = 0;
	rst = 0;
	
	#100 rst = 1;
	
	#3000 $stop;
end

always #50 clk = ~clk;

always @ (posedge clk) $display("%b %b %b %b", out1, out2, out3, out4); 

endmodule
