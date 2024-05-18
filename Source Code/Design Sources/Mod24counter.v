`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2024 02:47:32 PM
// Design Name: 
// Module Name: Mod24counter
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


module Mod24counter(
input clk, reset,en, output [4:0] count, input updown
    );
    BinaryCounter #(5,24) mod24 (.clk(clk), .reset(reset), .en(en), .count(count), .updown(updown));
endmodule
