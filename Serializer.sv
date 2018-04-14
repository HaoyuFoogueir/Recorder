`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2017 12:59:46 PM
// Design Name: 
// Module Name: Serializer
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


module Serializer #(parameter WORD_LENGTH = 16,
                    parameter SYSTEM_FREQUENCY = 100000000,
                    parameter SAMPLING_FREQUENCY = 1000000)
                   (input clock_i,
                    input logic enable_i,
                    output logic done_o,
                    input logic [15:0] data_i,
                    output logic pwm_audio_o,
                    output logic pwm_sdaudio_o);

    logic [4:0] counter = 5'd16;
    logic [6:0] clk_cnt = 0;
    logic nw_clk;
//    logic [15:0] data_tmp;

always_ff @(posedge clock_i)
begin
    if(clk_cnt==8'd49) //counting 100 for the 100 MHz to be 1MHz
    begin
        clk_cnt<=8'd0;
        nw_clk = ~nw_clk;
    end
    else
        clk_cnt<=clk_cnt+8'd1;
end
    
always_ff @(posedge nw_clk)
begin
    pwm_sdaudio_o <= enable_i;
    if(done_o) done_o = ~done_o;
    if(enable_i)
    begin
        if(counter == 5'd15)
        begin
            done_o = 1'b1;
            counter <= 5'd0;
//          data_tmp <= data_i;
        end       
        else begin 
            counter <= counter+1;
        end  
        pwm_audio_o <= data_i[5'd15-counter];
    end
end
        

endmodule
