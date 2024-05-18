`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2024 03:10:34 PM
// Design Name: 
// Module Name: SecMinCounter
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


module SecMinHourCounter(
input clk,en, houren, minen, reset, output [3:0]min1, output  [3:0]hour1,  output [2:0]min2,  output [1:0]hour2, input updown, output  [5:0] mins, output  [4:0] hour, output [5:0] secs );
     wire w1,w2;
  


Mod60counter seconds(.en(en), .clk(clk), .reset(reset), . count(secs), .updown(updown));
assign w1 = (secs==59 & en);
Mod60counter minutes(.en(w1 | minen), .clk(clk), .reset(reset), . count(mins), .updown(updown));

assign w2 = (mins == 59 & w1);
    Mod24counter hours(.en(w2 | houren), .clk(clk), .reset(reset), . count(hour), .updown(updown));
    assign min1 = mins % 10;
    assign min2 = mins / 10;
    assign hour1= hour %10;
    assign hour2 = hour /10;

    
endmodule
