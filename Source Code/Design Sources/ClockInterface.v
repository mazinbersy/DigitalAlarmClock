`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2024 10:25:14 PM
// Design Name: 
// Module Name: ClockInterface
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


module ClockInterface( input clk, reset, BTNU, BTND, BTNL, BTNR, BTNC, enablealarm,
output [6:0] segments, output [3:0] anode_active, output  dp, LD0, LD12, LD13, LD14, LD15, buzzer);

clockDivider #(250000)divide(.clk(clk),.rst(reset),.clk_out(clk_200));
clockDivider #(50000000) decimal(.clk(clk), .rst(reset), .clk_out(clk_1));
clockDivider #(10000000) buzzerclk(.clk(clk), .rst(reset), .clk_out(clk_5));


pushdownDetector btn1(.clk(clk_200), .rst(reset), .in(BTNC),  .out(BTNC_out));
pushdownDetector btn2(.clk(clk_200), .rst(reset), .in(BTND),  .out(BTND_out));
pushdownDetector btn3(.clk(clk_200), .rst(reset), .in(BTNU),  .out(BTNU_out));
pushdownDetector btn4(.clk(clk_200), .rst(reset), .in(BTNL),  .out(BTNL_out));
pushdownDetector btn5(.clk(clk_200), .rst(reset), .in(BTNR),  .out(BTNR_out));

digitalClock Main(.clk_1(Clock), .clk_200(clk_200), .en(en), .houren(houren), .minen(minen), .reset(reset), .adjust(adjust),
.segments(segments), .anode_active(anode_active), .dp(dp), .updown(updown), .alarmmin(alarmminreg), .alarmhour(alarmhourreg), .alarmflag(alarmdisplayflag), .trigger(trigger), 
.alhouren(alhouren),.alminen(alminen), .alupdown(alupdown));
wire trigger; wire clk_1,clk_200, clk_5;
reg en, houren, minen, updown, alarmdisplayflag;
reg alhouren, alminen, alupdown;
reg Clock;
reg beginning;
reg [4:0] alarmhourreg;
reg [5:0] alarmminreg;
reg [2:0] state, nextState;
reg adjust;
parameter [2:0] Clock_mode = 3'b000, Adjust_clockmin = 3'b001, Adjust_clockhour = 3'b010, Adjust_alarmmin = 3'b100,
Adjust_alarmhour = 3'b101, Alarm_mode = 3'b110;
always @ ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} or state) begin
    case (state)
    Clock_mode: begin
                                
                       
                 if(trigger & enablealarm)
                 nextState = Alarm_mode;      
                
                  else if ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00001) begin
                    nextState = Adjust_clockmin;
                            minen = 1'b1; 
                               houren = 1'b0;
                                alupdown = 1'b0;
                                alminen = 1'b0; 
                                alhouren =1'b0; 
                            en = 1'b0;
                            alarmdisplayflag =1'b0;
                end 
                else begin
                    nextState = Clock_mode;
                    Clock  = clk_1;
                     updown = 1'b1;
                        minen = 1'b0; 
                        houren = 1'b0;
                          alupdown = 1'b0;
                            alminen = 1'b0; 
                            alhouren =1'b0;
                        alarmdisplayflag =1'b0;
                        en = 1'b1;
                end
                
            end
    
    Adjust_clockmin: begin      
                            if(BTNU_out) begin
                            updown = 1'b1; 

                               end
                            else begin
                            updown = 1'b0;
        
                            end
                                 Clock = (BTNU_out | BTND_out);
                                 adjust=1'b1;

                            if ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00100) begin
                            
                                nextState = Adjust_clockhour;
                            minen = 1'b0; 
                               houren = 1'b1;
                                alupdown = 1'b0;
                                alminen = 1'b0; 
                                alhouren =1'b0; 
                            en = 1'b0;

                            alarmdisplayflag =1'b0;
                            end
                            else if ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00010) begin
                          
                                nextState = Adjust_alarmhour;
                                updown = 1'b0;
                                 minen = 1'b0; 
                               houren = 1'b0;
                                alminen = 1'b0; 
                                alhouren =1'b1;
                                alarmdisplayflag = 1'b1;      
                                en = 1'b0;
                            end else if({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00001) begin
                            
                            nextState = Clock_mode;
                            updown = 1'b1;
                        minen = 1'b0; 
                        houren = 1'b0;
                          alupdown = 1'b0;
                            alminen = 1'b0; 
                            alhouren =1'b0;
                        alarmdisplayflag =1'b0;
                        en = 1'b1;
                            end 
                            else  begin 
                            nextState = Adjust_clockmin;
                            
                                minen = 1'b1; 
                               houren = 1'b0;
                                alupdown = 1'b0;
                                alminen = 1'b0; 
                                alhouren =1'b0; 
                            en = 1'b0;
                            alarmdisplayflag =1'b0;
                            end
                        end
            Adjust_clockhour: begin
            
                            if(BTNU_out) begin 
                               updown = 1'b1; 
                              
                                end
                                else begin  
                                updown = 1'b0;
                                
                                end
                         Clock = (BTNU_out | BTND_out);
                            adjust=1'b1;
                                        
                            if ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00100) begin
                                nextState = Adjust_alarmmin;
                                updown = 1'b0;
                                 minen = 1'b0; 
                               houren = 1'b0;
                                alminen = 1'b1; 
                                alhouren =1'b0;
                                alarmdisplayflag = 1'b1;      
                                en = 1'b0;

                            end else if({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00010) begin
                                 nextState = Adjust_clockmin;
                            minen = 1'b1; 
                               houren = 1'b0;
                                alupdown = 1'b0;
                                alminen = 1'b0; 
                                alhouren =1'b0; 
                            en = 1'b0;
                            alarmdisplayflag =1'b0;
                            end else if ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00001) begin
                           
                                nextState = Clock_mode;
                                updown = 1'b1;
                        minen = 1'b0; 
                        houren = 1'b0;
                          alupdown = 1'b0;
                            alminen = 1'b0; 
                            alhouren =1'b0;
                        alarmdisplayflag =1'b0;
                        en = 1'b1;
                            end
                            else begin
                                nextState = Adjust_clockhour;
                            minen = 1'b0; 
                               houren = 1'b1;
                                alupdown = 1'b0;
                                alminen = 1'b0; 
                                alhouren =1'b0; 
                            en = 1'b0;
                            alarmdisplayflag =1'b0;
                            end
                        end
                
         Adjust_alarmmin: begin
                            if(BTNU_out) begin 
                                        alupdown = 1'b1;    
                                         end
                                         else begin  
                                         alupdown = 1'b0;                                     
                                         end
                            Clock = (BTNU_out | BTND_out);
                            adjust=1'b1;

                             if ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00100) begin
                                nextState = Adjust_alarmhour;
                                updown = 1'b0;
                                 minen = 1'b0; 
                               houren = 1'b0;
                                alminen = 1'b0; 
                                alhouren =1'b1;
                                alarmdisplayflag = 1'b1;      
                                en = 1'b0;
                                
                            end else if({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00010) begin
                            nextState = Adjust_clockhour;
                            minen = 1'b0; 
                               houren = 1'b1;
                                alupdown = 1'b0;
                                alminen = 1'b0; 
                                alhouren =1'b0; 
                            en = 1'b0;
                            alarmdisplayflag =1'b0;
                            end else if ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00001) begin
                            
                            nextState = Clock_mode;
                            updown = 1'b1;
                        minen = 1'b0; 
                        houren = 1'b0;
                          alupdown = 1'b0;
                            alminen = 1'b0; 
                            alhouren =1'b0;
                        alarmdisplayflag =1'b0;
                        en = 1'b1;
                            end
                            else begin
                                nextState = Adjust_alarmmin;
                                updown = 1'b0;
                                 minen = 1'b0; 
                               houren = 1'b0;
                                alminen = 1'b1; 
                                alhouren =1'b0;
                                alarmdisplayflag = 1'b1;      
                                en = 1'b0;
                        end
                        end

        Adjust_alarmhour: begin
                            if(BTNU_out) begin 
                                       alupdown = 1'b1;                              
                                        end
                                        else begin  
                                        alupdown = 1'b0;        
                                        end 
                            Clock = (BTNU_out | BTND_out);
                            adjust=1'b1;

                             if ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00100) begin
                                nextState = Adjust_clockmin;
                            minen = 1'b1; 
                               houren = 1'b0;
                                alupdown = 1'b0;
                                alminen = 1'b0; 
                                alhouren =1'b0; 
                            en = 1'b0;
                            alarmdisplayflag =1'b0;
                            end else if ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00010) begin
                                nextState = Adjust_alarmmin;
                                updown = 1'b0;
                                 minen = 1'b0; 
                               houren = 1'b0;
                                alminen = 1'b1; 
                                alhouren =1'b0;
                                alarmdisplayflag = 1'b1;      
                                en = 1'b0;
                            end else if ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00001) begin
                           
                                nextState = Clock_mode;
                                updown = 1'b1;
                        minen = 1'b0; 
                        houren = 1'b0;
                          alupdown = 1'b0;
                            alminen = 1'b0; 
                            alhouren =1'b0;
                        alarmdisplayflag =1'b0;
                        en = 1'b1;
                            end
                            else begin
                                nextState = Adjust_alarmhour;
                                updown = 1'b0;
                                 minen = 1'b0; 
                               houren = 1'b0;
                                alminen = 1'b0; 
                                alhouren =1'b1;
                                alarmdisplayflag = 1'b1;      
                                en = 1'b0;
                            end
                        end
                                            
          Alarm_mode: begin
                               updown = 1'b1;
                                Clock = clk_1;
                                en=1'b1;
                                minen = 1'b0; 
                               houren = 1'b0;
                                alupdown = 1'b0;
                                alminen = 1'b0; 
                                alhouren =1'b0;
                              alarmdisplayflag =1'b0;

                                     if ({BTNU_out, BTND_out, BTNL_out, BTNR_out, BTNC_out} == 5'b00000) begin
                                        nextState = Alarm_mode; 
                                    end
                                    else begin
                                        nextState = Clock_mode;
                                    end
                                end
                  
                endcase
                end

       
   always @ (posedge clk_200, posedge reset) begin
       if(reset)
               state <=Clock_mode;
       else 
               state <=nextState;
       end
    assign LD0 = (state == Adjust_alarmhour |  state == Adjust_alarmmin | state == Adjust_clockhour  | state == Adjust_clockmin | (state==Alarm_mode & ~clk_1)) ? 1'b1: 1'b0;
    assign buzzer = (state == Alarm_mode) ? clk_5 : 1'b0;
    assign LD12 = (state == Adjust_clockmin) ? 1'b1 : 1'b0;
    assign LD13 = (state == Adjust_clockhour) ? 1'b1 : 1'b0;
    assign LD14 = (state == Adjust_alarmmin) ? 1'b1 : 1'b0;
    assign LD15 = (state == Adjust_alarmhour) ? 1'b1 : 1'b0;

       
endmodule
