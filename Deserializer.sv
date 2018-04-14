`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2017 06:23:37 PM
// Design Name: 
// Module Name: Deserializer
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


module Deserializer(input clock_i,
                    input enable_i,
                    input pdm_data_i,
                    output logic done_o,
                    output logic [15:0] data_o,
                    output logic pdm_lrsel_o,
                    output logic pdm_clk_o);
                    
    logic [3:0] counter = 4'd15;
    logic [6:0] clk_cnt = 0;
    logic nw_clk = 0;
    
always @(*)
begin
    pdm_lrsel_o = 1;
    pdm_clk_o = nw_clk;
end

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
    if(enable_i)
    begin
        data_o[4'd15-counter] <= pdm_data_i;
        if(counter == 4'd15)
        begin
            counter <= 4'd0;
            done_o <= 1'b1;
        end
        else
        begin 
            counter = counter+1;
        end
    end
    if(done_o) done_o <= ~done_o;    
end      
endmodule
