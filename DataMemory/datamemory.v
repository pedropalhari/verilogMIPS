module datamemory(address ,dataIn ,dataOut, clk, we);
							
parameter DATA_WIDTH = 32 ;
parameter ADDR_WIDTH = 10 ;

input we, clk;
input [ADDR_WIDTH-1:0] address ;
input [DATA_WIDTH-1:0] dataIn ;
 

output reg[DATA_WIDTH-1:0] dataOut ;
reg [DATA_WIDTH-1:0] mem [0:1024];

initial 
	begin
		mem[32'd0] = 32'd 1000; //A
		mem[32'd1] = 32'd 5000; //B
		mem[32'd2] = 32'd 2000; //C
		mem[32'd3] = 32'd 3000; //D		
	end

always @ (posedge clk)
begin
	 if (we) 
		mem[address] <= dataIn;
	else
		dataOut <= mem[address];
end

endmodule
