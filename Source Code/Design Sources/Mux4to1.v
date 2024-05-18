`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2024 03:32:29 PM
// Design Name: 
// Module Name: Mux4to1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module Mux4to1(input [0:3] in1,input [0:3] in2,input [0:3] in3,input [0:3] in4, input [1:0] s,output [3:0] out);
wire [3:0] wire1; wire [3:0] wire2;
 
 Mux2to1(.in0(in1), .in1(in2), .sel(s[0]), .out(wire1));
 Mux2to1(.in0(in3), .in1(in4), .sel(s[0]), .out(wire2));
 Mux2to1(.in0(wire1), .in1(wire2), .sel(s[1]), .out(out));
endmodule