module div (A,B,Q);
input [7:0]A,B;
output reg [15:0]Q;
wire [15:0] o1,o2,o3,i1,i2,x1,x2,D,xout;
reg[7:0] e1,f1,inter,e2,f2,inter1;
wire [7:0] xin;

assign xin = 8'b00000001;

divider d1 (A,B,xin,o1,i1,x1);
always @ (o1,i1)
begin
  if (i1[15:8]== 8'b11111111 && i1[7:0] == 8'b00000000) begin
Q = o1;
$finish;
end
else begin
e1 = o1[7:0];
f1 = i1[7:0];
inter = x1[7:0];
end
end
divider d2 (e1,f1,inter,o2,i2,x2);
always @ (o2,i2)
begin
  if (i2[15:8]== 8'b11111111 && i2[7:0] == 8'b00000000) begin
Q = o2;
$finish;
end
else begin
e2 = o2[7:0];
f2 = i2[7:0];
inter1 = x2[7:0];
end
end
divider d3 (e2,f2,inter1,o3,D,xout);
always @ (o3)
begin
Q = o3;
end

// initial
// $display("%b,%b,%b",o1,i1,x1);

endmodule
