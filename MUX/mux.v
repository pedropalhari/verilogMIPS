module mux(
	input[31:0] A,
	input[31:0] B,
	input selector,
	output[31:0] muxOut
);

assign muxOut = selector ? B : A;

endmodule
