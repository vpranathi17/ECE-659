module divider(A,B,Q);

	input signed [7:0] A, B;
	wire signed [7:0] xi; 
	output signed [15:0] Q;
	wire signed [15:0] Ni, Di;
	wire [7:0]D,Fi,E,F,G;
	wire cin,cout;
	wire [15:0]xinew;
	reg s;
	genvar i;
	
// 	wire signed [7:0] xint,xjnew,select,fact;

	assign cin = 1'b0;
	assign xi = 8'b00000001;
	assign E = A;
	assign F = B;
// 	s = $clog2($size(A));

function [7:0]out;
input [7:0] in;
reg [7:0] temp1;
integer j;
begin
assign out[7:0] = in[7:0];
assign temp1[7:0] = in[7:0];
// assign out [7:1] = ~ in[7:1];
for(j=1; j<=7; j=j+1)
begin
// always @ (temp1[i]) begin
if (temp1[j-1]== 1'b1) begin
out[7:j] =  ~ temp1[7:j];
end
else if(temp1[j-1] == 1'b0 && (out[j] == 1'b1 || out [j] == 1'b0))
out[7:j] =  ~ temp1[7:j];
else
out [j] = temp1[j]; 
end
end
endfunction

// 	for (i=1; i<=3; i=i+1)
// 	begin	
	multiplier m2 (F,xi,Di);
	assign G = Di[7:0];	
	multiplier m1 (E,xi,Ni);
	assign D = out(G);
	cla ca1 (8'b00000010,D,cin,Fi,cout);
	multiplier m3 (Fi,xi,xinew);
// 	assign Q = Ni;
	
// 	assign E = Ni[7:0];
// 	assign F = Di[7:0];
// 	assign xi = xinew[7:0];
// 	end
	
	assign Q = D;
	
endmodule

