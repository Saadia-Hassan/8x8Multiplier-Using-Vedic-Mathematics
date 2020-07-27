`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:32 07/03/2020 
// Design Name: 
// Module Name:    booth_8x8 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module booth_8x8(prd, busy, mc, mp, clk, start);
output [15:0] prd;
output busy;
input [7:0] mc, mp;
input clk, start;
reg [7:0] A, Q, B;
reg Q_1;
reg [3:0] count;
wire [7:0] sum, difference;
always @(posedge clk)
begin
if (start) begin
A <= 8'b0;
B <= mc;
Q <= mp;
Q_1 <= 1'b0;
count <= 4'b0;
end
else begin
case ({Q[0], Q_1})
2'b0_1 : {A, Q, Q_1} <= {sum[7], sum, Q};
2'b1_0 : {A, Q, Q_1} <= {difference[7], difference, Q};
default: {A, Q, Q_1} <= {A[7], A, Q};
endcase
count <= count + 1'b1;
end
end
alu adder (sum, A, B, 1'b0);
alu subtracter (difference, A, ~B, 1'b1);
assign prd = {A, Q};
assign busy = (count < 8);
endmodule

//For alu.
//It is an adder, but capable of subtraction:
//Recall that subtraction means adding the two's complement
//a - b = a + (-b) = a + (inverted b + 1)
//The 1 will be coming in as Cin (carry-in)

module alu(out, a, b, cin);
output [7:0] out;
input [7:0] a;
input [7:0] b;
input cin;
assign out = a + b + cin;
endmodule


