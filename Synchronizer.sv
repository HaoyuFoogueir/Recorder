`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2017 06:38:24 PM
// Design Name: 
// Module Name: Synchronizer
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


module Synchronizer(
input clk,
input logic rst,
input logic rec,
input logic ply,
input logic num,
output logic orst,
output logic orec,
output logic oply,
output logic onum
    );
    logic rsta;
    logic reca;
    logic plya;
    logic numa;

    always_ff @ (posedge clk)
    begin
        rsta<=rst;
        reca<=rec;
        plya<=ply;
        numa<=num;

    end  
    always_ff @ (posedge clk)
    begin
        orst<=rsta;
        orec<=reca;
        oply<=plya;
        onum<=numa;

    end
endmodule
