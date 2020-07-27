`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:09:06 06/26/2020 
// Design Name: 
// Module Name:    vedic8x8 
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
module vedic8x8(a, b, result);

    input  [7:0] a,b;
    output [15:0] result;
    wire [15:0] result;

wire [7:0] temp1;
wire [7:0] temp2;
wire [7:0] temp3;
wire [9:0] temp4;
wire [9:0] temp5;
wire [7:0] temp6;
wire [7:0] temp7;

vedic4x4 M1(a[3:0], b[3:0], temp1);
assign result[3:0] = temp1[3:0];

vedic4x4 M2(a[7:4], b[3:0], temp2);
vedic4x4 M3(a[3:0], b[7:4], temp3);

adder10 A1({2'b00, temp2}, {2'b00,temp3}, temp4);
adder10 A2(temp4, {6'b000000, temp1[7:4]}, temp5);
assign result[7:4] = temp5[3:0];

vedic4x4 M4(a[7:4], b[7:4], temp6);
adder8 A3(temp6, {2'b00,temp5[9:4]}, temp7);

assign result[15:8] = temp7;

endmodule

module vedic4x4(a, b, result);

    input  [3:0] a,b;
    output [7:0] result;
    wire [7:0] result;

wire [3:0] temp1;
wire [3:0] temp2;
wire [3:0] temp3;
wire [5:0] temp4;
wire [5:0] temp5;
wire [3:0] temp6;
wire [3:0] temp7;
wire [5:0] w1;

vedic_2x2 V1(a[1:0], b[1:0], temp1);
assign result[1:0] = temp1[1:0];

vedic_2x2 V2(a[3:2], b[1:0], temp2);
vedic_2x2 V3(a[1:0], b[3:2], temp3);

assign w1 = {4'b0000, temp1[3:2]};

adder6 A1({2'b00, temp3}, {2'b00, temp2}, temp4);
adder6 A2(temp4, w1, temp5);

assign result[3:2] = temp5[1:0];

vedic_2x2 V4(a[3:2], b[3:2], temp6);

adder4 A3(temp6, temp5[5:2], temp7);
assign result[7:4] = temp7;


endmodule

module vedic_2x2 (a, b, result);
    input [1:0] a,b;
    output [3:0] result;

    wire [3:0] w;
    
    
    assign result[0]= a[0]&b[0];
    assign w[0]     = a[1]&b[0];
    assign w[1]     = a[0]&b[1];
    assign w[2]     = a[1]&b[1];

    halfAdder H0(w[0], w[1], result[1], w[3]);
    halfAdder H1(w[2], w[3], result[2], result[3]);    
    
endmodule

module halfAdder(a,b,sum,carry);
    input a,b;
    output sum, carry;

assign sum   = a ^ b;
assign carry = a & b;

endmodule

module adder4(a,b,sum);

input [3:0] a,b;
output [3:0] sum;
wire [3:0] sum;

assign sum = a + b;

endmodule

module adder6(a,b,sum);

input [5:0] a,b;
output [5:0] sum;
wire [5:0] sum;

assign sum = a + b;

endmodule

module adder8(a,b,sum);

input [7:0] a,b;
output [7:0] sum;
wire [7:0] sum;

assign sum = a + b;

endmodule

module adder10(a,b,sum);

input [9:0] a,b;
output [9:0] sum;
wire [9:0] sum;

assign sum = a + b;

endmodule


