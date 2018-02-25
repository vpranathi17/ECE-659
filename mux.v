/Multiplexer/
module mux(xint,xjnew,select,xi);
input signed [7:0] xint, xjnew;
input select;
output signed [7:0] xi;
reg signed [7:0]xi;
always @ (xint or xjnew or select)
begin
if (select == 1'b0)
xi = xint;
else
xi = xjnew;
end
endmodule
