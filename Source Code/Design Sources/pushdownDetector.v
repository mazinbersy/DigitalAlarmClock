`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2024 03:33:57 PM
// Design Name: 
// Module Name: pushdownDetector
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


module pushdownDetector(input clk, rst, in, output out );

wire wire1, wire2;
debouncer db(.clk(clk), .rst(rst), .in(in), .out(wire1));
synchronizer sync(.clk(clk), .SIG(wire1), .SIG1(wire2));
risingedgedetector red(.clk(clk), .rst(rst), .w(wire2), .z(out));
endmodule
