module complement (in,out);
input [7:0]in;
output reg [7:0]out;
wire [7:0] temp1;
genvar i;
initial
out[0] = in[0];
assign temp1[7:0] = in[7:0];

for(i=1; i<=7; i=i+1)
begin
always @ (*) begin
if (temp1[i-1]== 1'b1) begin
out[7:i] = ~ temp1[7:i];
end
else if(temp1[i-1] == 1'b0 && (out[i] == 1'b1 || out [i] == 1'b0))
out[7:i] = ~ temp1[7:i];
else
out [i] = temp1[i]; 
end
end
endmodule
