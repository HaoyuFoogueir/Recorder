`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2017 07:17:00 PM
// Design Name: 
// Module Name: Controller
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

//there is alot of shit that isnt needed in this but its staying until 
module Controller(
    input clk,
    input logic rst,
    input logic rec,
    input logic ply,
    input logic num,
    output logic EN_ram1,
    output logic EN_ram2,
    output logic wea,
    output logic EN_deser,
    output logic EN_ser,
    output logic EN_time,
    output logic reset_time
    
    );
        parameter idle=1'b0;
        parameter reco=2'b01;
        parameter play=2'b10;
    
    logic state;
    logic flag=0;
    always_ff @(posedge clk)
        case(state)
            idle:
            begin
                 addr<=0;
                 EN_ram1<=0;
                 EN_ram2<=0;
                 wea<=0;
                 EN_deser<=0;
                 EN_ser<=0;
                 EN_time<=0;
                 reset_time<=0;
                 if(rec==0&&ply==0) flag<=0;
                 if(!flag)
                    begin
                    if(rec) 
                    begin
                    state<=reco;
                    flag<=1;
                    end
                    else
                    if(ply)
                    begin
                    state<=play;
                    flag<=1;
                    end
                 end
                 else state<=idle;
            end
            reco:
            begin
                if(num)EN_ram1<=1;
                else EN_ram2<=1;
                EN_deser<=1;
                wea<=1;
                if(tme) state<=idle;
            end
            play:
            begin
                if(num)EN_ram1<=1;
                else EN_ram2<=1;
                EN_ser<=1;
                wea<=0;
                if(tme) state<=idle;
            end
        endcase
endmodule
