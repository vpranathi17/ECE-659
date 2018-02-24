module decoder (sdn,y,clock,PP);
input [2:0]sdn;
input clock;
input signed [7:0]y;
output signed [7:0]PP;
wire [7:0]cout;
wire cin;
wire [7:0]o1,o2,pp1,sum;
wire s1,s2;
genvar j;
 
assign s1 = ~ sdn[2];
assign s2 = ~ sdn[1];
assign cin = sdn[0];


for (j=1; j<=8;j=j+1) begin
assign o1[j-1] = (s1 & sdn[1] & y[j-1]);
assign o2[j-1] = (s2 & y[j] & sdn[2]);
assign pp1[j-1] = (o1[j-1] | o2[j-1]);
assign sum[j-1] = pp1[j-1] ^ sdn[0];
end

half h1 (PP[0],cout[0],sum[0],cin);
half h2 (PP[1],cout[1],sum[1],cout[0]);
half h3 (PP[2],cout[2],sum[2],cout[1]);
half h4 (PP[3],cout[3],sum[3],cout[2]);
half h5 (PP[4],cout[4],sum[4],cout[3]);
half h6 (PP[5],cout[5],sum[5],cout[4]);
half h7 (PP[6],cout[6],sum[6],cout[5]);
half h8 (PP[7],cout[7],sum[7],cout[6]);

initial
#700 $display ("sum:%b,cout: %b", sum,cout);

endmodule



// module decoder (sdn,y,PP);
// input [2:0]sdn;
// input [7:0]y;
// output [8:0]PP;
// wire [8:0]p;
// wire [7:0]o1,o2,pp1;
// wire s1,s2;
// genvar j;

// assign p[0]=1'b0;
// assign p[8:1]=y[7:0];

// assign s1 = ~ sdn[2];
// assign s2 = ~ sdn[1];

// for (j=1; j<=8;j=j+1)
// begin
// assign o1[j-1] = (s1 & sdn[1] & p[j-1]);
// assign o2[j-1]= (s2 & p[j] & sdn[2]);
// assign pp1[j-1] = (o1[j-1] | o2[j-1]);
// assign PP[j-1] = pp1[j-1] ^ sdn[0];
// end

// assign PP[8] = y[7];

// endmodule
// module decoder (sdn,y,PP);
// input [2:0]sdn;
// input signed [7:0]y;
// output signed [7:0]PP;
// wire [7:0]cout;
// wire cin,temp;
// wire [7:0]o1,o2,pp1,sum;
// wire s1,s2;
// genvar j,k;
 
// assign s1 = ~ sdn[2];
// assign s2 = ~ sdn[1];
// assign cin = sdn[0];
 
// // generate
// for (j=1; j<=8;j=j+1)
// begin
// assign o1[j-1] = (s1 & sdn[1] & y[j-1]);
// assign o2[j-1]= (s2 & y[j] & sdn[2]);
// assign pp1[j-1] = (o1[j-1] | o2[j-1]);
// assign sum[j-1] = pp1[j-1] ^ sdn[0];
// half h1 (PP[j-1],cout[j-1],sum[j-1],cin);
// // assign PP[j-1] = sum[j-1] ^ cin;
// assign cout = sum[j-1] & cin;
// end
// // endgenerate

// initial
// #700 $display ("sum:%b,cout: %b", sum,cout);
// endmodule
