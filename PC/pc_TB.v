`timescale 1ns/10ps

module pc_TB ();
	reg clk;
	reg rst;
	wire [9:0] dataOut;
	
pc DUT (
	.clk(clk),
	.rst(rst),
	.dataOut(dataOut)
);


initial
begin
	clk <=0;
	rst <=0;

	#50 
	rst <=1;
	
	#400
	rst <= 0;
	
	#150
	rst <= 1;
	
end

always
	#50 clk <= ~clk;
	
initial $display("PC");
always @ (posedge clk) $display("%d", dataOut);


 initial
	# 3000 $stop;	

endmodule
	