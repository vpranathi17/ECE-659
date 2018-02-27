module div (A,B,Q);
input [7:0]A,B;
output [15:0]Q;
wire [15:0] o1,o2,i1,i2,x1,x2,D,xout;
wire [7:0] xin,e1,f1,inter,e2,f2,inter1;

assign xin = 8'b00000001;

divider d1 (A,B,xin,o1,i1,x1);
assign e1 = o1[7:0];
assign f1 = i1[7:0];
assign inter = x1[7:0];
divider d2 (e1,f1,inter,o2,i2,x2);
assign e2 = o2[7:0];
assign f2 = i2[7:0];
assign inter1 = x2[7:0];
divider d3 (e2,f2,inter1,Q,D,xout);

// initial
// $display("%b,%b,%b",o1,i1,x1);

endmodule