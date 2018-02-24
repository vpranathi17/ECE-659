module decoder (sdn,Y,PP);
input [2:0]sdn;
input [7:0]Y;
output [8:0]PP;
wire [8:0]p;
reg [7:0]o1,o2,pp1,pp2,c;
wire s1,s2,cout;
reg [7:0] temp1, temp2;

//assign j=1'd1;
integer k;
assign p[0]=1'b0;
assign p[8:1]=Y[7:0];
//assign m = 0;
assign s1 = ~ sdn[2];
assign s2 = ~ sdn[1];
//assign s3 = 1'b1;
//reg s3 = 8'b00000001;
reg n = 8'b00000000;
always @(*) begin

for (k=1;k<=8;k=k+1)
begin
 o1[k-1] <= (s1 & sdn[1] & p[k-1]);
 o2[k-1] <= (s2 & p[k] & sdn[2]);
 pp1[k-1] <= (o1[k-1] | o2[k-1]);
 pp2[k-1] <= pp1[k-1] ^ sdn[0];

temp1[k-1] <= pp2[k-1];
if (sdn[0] == 1'b1 && k == 1) begin
   {{temp2[k-1]},{c}} <= temp1[k-1] + 1'b1;
    while(n !== c)
    begin
    n <= c;
    {{temp2[k-1]},{c}} <= temp1[k-1] + c;
    end
   end
else
   temp2[k-1] <= temp1[k-1];

//assign PP[k-1] = temp2[k-1]; 
end
end
 assign PP[8] = Y[7];

endmodule
