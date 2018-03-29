module divider(A,B,xi,C,D,xinew);

	input [7:0] A, B,xi;
	output [7:0] C,D, xinew;
	wire [7:0]Fi,exp;
	reg [7:0]neg;
	reg [7:0] two,down,E,F;
	wire [7:0] extra1,extra2,extra3,extra4; 
	wire [15:0] Ni,Di,xin;
	wire cin,cout,c1,c2,c3,c4,c5;
	reg [2:0] option1,ans1,ans;
	reg [3:0] sr1,sr2,shift,shift1,comp,ans2,shift2;
	wire [3:0] e1, e2,e3,e4, sum1,sum2,sum3,sum4,sum5,sum6 ,cp1,cp2;
	genvar i;
	
	assign cin = 1'b0;
	assign exp = 4'b1001; //-7 value
	
	assign extra1[7:4] = 4'b0000; // A value
	assign extra1[3] = 1'b1;
	assign extra1[2:0] = A[2:0];
	
	assign extra2[7:4] = 4'b0000; // B value
	assign extra2[3] = 1'b1;
	assign extra2[2:0] = B[2:0];
	
	assign extra3[7:4] = 4'b0000; // xi value
	assign extra3[3] = 1'b1;
	assign extra3[2:0] = xi[2:0];


function [3:0]out; // complement function
input [3:0] in;
reg [3:0] temp1;
integer j,k;
begin
out[0] = in[0];
temp1[3:0] = in[3:0];

for(j=1; j<=3; j=j+1)
begin
if (temp1[j-1]== 1'b1) begin
for (k=j; k<=3; k=k+1) begin
out[k] = ~ temp1[k]; end end
else if (temp1[j-1] == 1'b0 &(out[j] ==1'b1 || out[j] == 1'b0))
out[j] = out[j];
else
out[j] = temp1[j];

end

end
endfunction

function [3:0]sum; // cla function
input [3:0]a,b;
reg cin;
reg [3:0] p,g,c;
integer l;
begin
	cin = 1'b0;
	for(l=0;l<=3;l=l+1)
	begin
	  p[l]=(a[l]^b[l]); //propogate stage
	  g[l]=(a[l]&b[l]); //generate stage

	  if (l==0)
	  	c[0]=cin;
	  else
	  	c[l]=g[l-1]|(p[l-1]&c[l-1]); // internal carry
	  
	 sum[l]=p[l]^c[l]; //sum generation
		end	

end
endfunction
	
	multiplier m2 (extra2,extra3,Di);	 // Di multiplying
	multiplier m1 (extra1,extra3,Ni);    // Ni multiplying
	assign C[7] = B[7] ^ xi[7]; // Representing Di
	assign e1 = A[6:3];
	assign e2 = xi[6:3];
	assign e3 = B[6:3];
	assign sum1 = sum(e1,e2);
	assign sum2 = sum (e2,e3);
	assign sum3 = sum (sum1,exp);
	assign sum4 = sum (sum2,exp);
	assign C[6:3] = sum4[3:0];
	assign D[6:3] = sum3[3:0];
	assign D[7] = A[7] ^ xi[7]; // Representing Ni
	assign C[2:0] = Di[5:3];
	assign D[2:0] = Ni[5:3];
	
	always @ (C,D) begin
	two = 8'b01000000;
	E[7:4] = 3'b000;
	F[7:4] = 3'b000;	
	sr1 = 4'b1000; // exponent value of 2
	sr2 = C[6:3]; // exponent value of D	
	E[3:0] = sr2;
	F[3:0] = 4'b1000;
	end
	
	always @ (sum1,sum2,sr1,sr2) begin // 2-Di functionality
// 	$display("%b,%b,%b,%b,%b,%b,%b",e1,e2,e3,sum1,sum2,sum3,sum4);
// 	$display("%b,%b",sr1,sr2);
	down[6:0] = C[6:0];
	down[7] = ~ C[7]; // -Di functionality by changing sign
	shift[3] = 1'b1;
	shift[2:0] = down[2:0];
	shift1[3] = 1'b1;
	shift1[2:0] = two[2:0];
	
	if (sr1 <= sr2) // adder answer sign
		neg[7] = down[7];
	else
		neg[7] = 1'b0;
		
	if (down[7] == 1'b1) begin	
		comp [3:0] = out(shift[3:0]);
// 		$display ("just shifted %b",comp); 
		end
	else begin	
		comp[3:0] = shift[3:0]; end
	case(sr2)
		4'b1000:begin down[6:3] = sr2; down[2:0] = comp[2:0]; end 
		4'b1001:begin shift1[3:0] = shift1[3:0] >> 1; 	
					  F[3:0] = sum (sr1,4'b0001);
					  sr1 = F[3:0];
		              two[6:3] = sr1; 
					  two[2:0] = shift1[2:0]; end
		4'b1010:begin shift1[3:0] = shift1[3:0] >> 2; 	
					  F[3:0] = sum (sr1,4'b0001);
					  sr1 = F[3:0];
		              two[6:3] = sr1; 
					  two[2:0] = shift1[2:0]; end
		4'b0111:begin comp[3:0] = comp[3:0] >> 1; 	
					  E[3:0] = sum (sr2,4'b0001);
					  sr2 = E[3:0];
		              down[6:3] = sr2; 
					  down[2:0] = comp[2:0]; end
		4'b0110:begin comp[3:0] = comp[3:0] >> 2; 	
					  E[3:0] = sum (sr2,4'b0010);
					  sr2 = E[3:0];
		              down[6:3] = sr2; 
					  down[2:0] = comp[2:0]; end
		4'b0101:begin comp[3:0] = comp[3:0] >> 3; 	
					  E[3:0] = sum (sr2,4'b0011);
					  sr2 = E[3:0];
		              down[6:3] = sr2; 
					  down[2:0] = comp[2:0]; end
		4'b0100:begin comp[3:0] = comp[3:0] >> 4; 	
					  E[3:0] = sum (sr2,4'b0100);
					  sr2 = E[3:0];
		              down[6:3] = sr2; 
					  down[2:0] = comp[2:0]; end
		default:begin down[6:3] = sr2; down[2:0] = comp[2:0]; end
	endcase
// 	while (sr1 > sr2) // shifting
// 	begin 
// 	comp[3:0] = comp[3:0] >> 1;	
// 	E[3:0] = sum (sr2,4'b0001);
// 	sr2 = E[3:0];
// 	down[6:3] = sr2; 
// 	down[2:0] = comp[2:0];
// // 	$display ("down is %b,comp is %b",down[2:0],comp);
// 	end
// // 	end
// 	
// 	while (sr2 > sr1) begin //shifting
// 	shift1[3:0] = shift1[3:0] >> 1;
// 	F[3:0] = sum (sr1,4'b0001);
// 	sr1 = F[3:0];
// 	two[6:3] = sr1;
// 	two[2:0] = shift1[2:0];
// // 	#90 $display ("two is %b",two[2:0]);
// 	end
	end
	
// 	assign cp1 = shift1[3:0];
// 	assign cp2 = comp[3:0];
	
	always @ (down[7],shift1,comp) begin
	comp[3] = 1'b1;
	shift1[3] = 1'b1;
	
// 	neg[6:3] = sr2;
	ans2[3:0] = sum(shift1,comp);
	neg[2:0] = ans2[2:0];
	
	if (down[7] == 1'b1 && sr1 < sr2)
		ans = out(ans2);	
	else
		ans = ans2;
		
	if (ans[2] == 1'b1) begin
	 	neg[6:3] = sum(sr2,4'b1111);	
		ans = ans << 1; end
		
	else if (ans[2] == 1'b0 && ans[1] == 1'b1) begin
		neg[6:3] = sum(sr2,4'b1110);
		ans = ans <<1;
		ans = ans<<1; end
	else if (ans[2] == 1'b0 && ans[1] == 1'b0 && ans[0] == 1'b1) begin
		neg[6:3] = sum(sr2,4'b1101);
		ans = ans<<1;
		ans = ans<<1;
		ans = ans<<1; end
		end
	assign Fi[2:0] = ans; // Fi value
// 	assign Fi[6:3] = neg[6:3];
	assign Fi[7:3]= neg[7:3];
	
	assign extra4[7:4] = 4'b0000; // Fi value modified
	assign extra4[3] = 1'b1;
	assign extra4[2:0] = Fi[2:0];
	
	multiplier m3 (extra4,extra3,xin); // new xi value
	
	assign xinew[7] = Fi[7] ^ xi[7];
	assign e4 = Fi[6:3];
	assign sum5 = sum(e4,e2);
	assign sum6 = sum(sum5,exp);
	assign xinew[6:3] = sum6;
	assign xinew[2:0] = xin[5:3];

endmodule
