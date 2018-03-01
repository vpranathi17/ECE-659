module divider(A,B,xi,Ni,Di,xinew);

	input signed [7:0] A, B,xi;
	output signed [15:0] Ni, Di, xinew;
	wire [7:0]D,G,Fi;
	wire cin,cout;
	genvar i;

	assign cin = 1'b0;

function [7:0]out;
input [7:0] in;
reg [7:0] temp1;
integer j,k;
begin
out[0] = in[0];
assign temp1[7:0] = in[7:0];

for(j=1; j<=7; j=j+1)
begin
if (temp1[j-1]== 1'b1) begin
for (k=j; k<=7; k=k+1) begin
out[k] = ~ temp1[k]; end end
else if (temp1[j-1] == 1'b0 &(out[j] ==1'b1 || out[j] == 1'b0))
out[j] = out[j];
else
out[j] = temp1[j];

end

end
endfunction
	
	multiplier m2 (B,xi,Di);
	assign G = Di[7:0];	
	multiplier m1 (A,xi,Ni);
	assign D = out(G);
// 	complement co (G,D);
	cla ca1 (8'b00000010,D,cin,Fi,cout);
	multiplier m3 (Fi,xi,xinew);
	initial
	# 90 $display("%b",D);

	
endmodule


