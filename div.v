module div (A,B,Q);
input [7:0]A,B;
output reg [15:0]Q;
wire [15:0] o1,o2,o3,i1,i2,x1,x2,i3,xout;
reg[7:0] e1,f1,inter,e2,f2,inter1,out;
wire [7:0] xin,a1,b1,x3;

assign xin = 8'b00000001;

divider d1 (A,B,xin,o1,i1,x1);
always @ (o1,i1)
begin
#90 $display("i1 is %b",i1);
if (i1[15:8]== 8'b11111111 && i1[7:0] == 8'b00000000) begin
Q = o1;
#90 $display("o1 is %b; finished 1",o1);
$finish;
end
else if (i1[15:8] == 8'b11111111 || i1[15:8] == 8'b00000000) begin
e1 = o1[7:0];
f1 = i1[7:0];
inter = x1[7:0];
Q =o1;
$display("o1 is %b; nope 1",o1);
end
end
divider d2 (e1,f1,inter,o2,i2,x2);
always @ (o2,i2)
begin
$display("i2 is %b",i2);
if (i2[15:8]== 8'b11111111 && i2[7:0] == 8'b00000000) begin
Q = o2;
$display("o2 is %b; finished 2",o2);
$finish;
end
else if (i2[15:8] == 8'b11111111 || i2[15:8] == 8'b00000000) begin
e2 = o2[7:0];
f2 = i2[7:0];
inter1 = x2[7:0];
Q = o2;
$display("o2 is %b; nope 2",o2);
end
end
divider d3 (e2,f2,inter1,o3,i3,xout);
always @ (o3,i3)
begin
#100 $display("i3 is %b",i3);
Q = o3;
end

endmodule
