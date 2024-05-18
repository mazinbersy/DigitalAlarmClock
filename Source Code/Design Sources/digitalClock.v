`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2024 04:48:27 PM
// Design Name: 
// Module Name: digitalClock
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2024 04:53:59 PM
// Design Name: 
// Module Name: SevenSegDecWithEn
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



module digitalClock(input clk_1, clk_200,en, houren, minen, reset, adjust,
 output [6:0] segments, output [3:0] anode_active, output reg dp, input updown, input [5:0] alarmmin,
  [4:0] alarmhour, input alarmflag, output reg trigger, input alhouren, alminen, alupdown);
    wire [3:0]min1; wire [3:0]hour1; wire [2:0]min2; wire [1:0]hour2;
    wire [3:0] y, yalarm, muxout; 
    wire [1:0]display;
    wire [4:0]hour; wire [5:0] mins;
    wire [3:0] alarmmin1, alarmhour1;
    wire [1:0] alarmhour2;
    wire [2:0] alarmmin2;
   wire [5:0] alarmsecs; wire[5:0] clocksecs;
  
   
   
   
   BinaryCounter#(2,4)cnt(.clk(clk_200),.reset(reset),.en(1'b1),.count(display), .updown(1'b1));
 
   
   
   SecMinHourCounter counter(.clk(clk_1),.en(en),.houren(houren), .minen(minen),.reset(reset),.min1(min1),.hour1(hour1),.min2(min2),.hour2(hour2), .updown(updown), .mins(mins), .hour(hour), .secs(clocksecs));
   SecMinHourCounter alarmcounter(.clk(clk_1),.en(1'b0),.houren(alhouren), .minen(alminen),.reset(reset),.min1(alarmmin1),.hour1(alarmhour1),.min2(alarmmin2),.hour2(alarmhour2), .updown(alupdown), .mins(alarmmin), .hour(alarmhour), .secs(alarmsecs));
 
   Mux4to1 mux1(.in1({2'b00,hour2}), .in2(hour1), .in3({1'b0,min2}), .in4(min1), .s(display), .out(y));
   Mux4to1 mux2(.in1({2'b00,alarmhour2}), .in2(alarmhour1), .in3({1'b0,alarmmin2}), .in4(alarmmin1), .s(display), .out(yalarm));
   Mux2to1 displaysel(.in1(yalarm), .in0(y),.sel(alarmflag) ,.out(muxout));
   SevenSegDecWithEn s1(display, muxout,segments, anode_active);
   
   always @ (*)begin
   begin
   
   if(hour1 == alarmhour1 & min1 == alarmmin1 && alarmmin2 == min2 & alarmhour2 == hour2 && clocksecs == 6'd0) trigger = 1'b1; else trigger  = 1'b0;
   
   if(display == 1 & clk_1 & ~adjust)
   dp =1'b0;
   else dp =1'b1;
   end
   end
    
endmodule
