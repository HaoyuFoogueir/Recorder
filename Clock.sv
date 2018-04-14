`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2017 07:24:00 PM
// Design Name: 
// Module Name: Clock
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


module Clock(
    input logic rst,
    input logic og_clk,
    output logic nw_clk=0
    );
    logic [8:0]count=0;
     always_ff @ (posedge og_clk)
     begin
        if(rst||(count==8'd49))//counting 100 for the 100 MHz to be 1MHz
            begin
            count<=8'd0; 
            nw_clk<=~nw_clk;
            end
        else
            count<=count+8'd1;
     end
endmodule
