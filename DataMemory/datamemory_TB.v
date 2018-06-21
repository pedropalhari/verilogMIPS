`timescale 1ns/10ps

module datamemory_TB();

reg clk;
reg we;
reg [9:0] address;
reg [31:0] dataIn;
wire[31:0] dataOut;
	
datamemory DUT (
	.clk(clk),
	.address(address),
	.dataIn(dataIn),
	.dataOut(dataOut),
	.we(we)
);
 
 integer l, k;
 
 initial
 begin	 
	 clk = 0;
	 we = 1; //escrita
	 
	 #10 
	 for (l=0; l<=1023; l=l+1)
	 begin
		 #100 dataIn = l;
		    address = l;
	 end
	 
	 #100 we = 0; //leitura
	 for (k=3; k<=1023; k=k+1)
	 begin
		#100 address = k;
	 end
	 
	 #200 $stop;
end
	
 always
	#50 clk = ~clk;	
	 
always@ (posedge clk)
begin
	$display("\t%d \t%d \t%d \t%d", address, dataIn, dataOut, we);
end

	
endmodule
