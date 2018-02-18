module decoder (sdn,y,PP);
input [2:0]sdn;
input [7:0]y;
output [8:0]PP;
wire [8:0]p;
wire [7:0]o1,o2,pp1;
wire s1,s2;
genvar j;

assign p[0]=1'b0;
assign p[8:1]=y[7:0];

assign s1 = ~ sdn[2];
assign s2 = ~ sdn[1];

for (j=1; j<=8;j=j+1)
begin
assign o1[j-1] = (s1 & sdn[1] & p[j-1]);
assign o2[j-1]= (s2 & p[j] & sdn[2]);
assign pp1[j-1] = (o1[j-1] | o2[j-1]);
assign PP[j-1] = pp1[j-1] ^ sdn[0];
end

assign PP[8] = y[7];

endmodule