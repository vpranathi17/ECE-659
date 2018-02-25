module divider(A,B,Q);

	input signed [7:0] A, B;
	output signed [7:0] xi; 
	output signed [15:0] Q;
	wire signed [15:0] Ni, Di;
	wire [7:0]D,Fi;
	wire cin,cout;
// 	wire signed [7:0] xint,xjnew,select,fact;

	assign cin =1'b0;
// for log2n steps	
	multiplier m1 (A,xi,Ni);
	multiplier m2 (B,xi,Di);
	complement c1 (Di[7:0],D);
	cla ca1 (8'b00000010,D,cin,Fi,cout);
	multiplier m3 (Fi,xi,Q);
	
	assign A = Ni[7:0];
	assign B = Di[7:0];

endmodule
