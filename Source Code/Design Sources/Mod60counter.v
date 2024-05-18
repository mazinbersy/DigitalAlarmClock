`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2024 02:44:39 PM
// Design Name: 
// Module Name: Mod60counter
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


module Mod60counter(
input clk, reset,en, output [5:0] count, input updown
    );
    BinaryCounter #(6,60) mod60 (.clk(clk), .reset(reset), .en(en), .count(count), .updown(updown));
    endmodule
