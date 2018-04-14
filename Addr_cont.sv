`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2017 02:42:03 PM
// Design Name: 
// Module Name: Addr_cont
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


module Addr_cont(
    input logic clock,
    input logic reset,
    input logic timer_done,
    input logic ser_done,
    input logic des_done,
    output logic [16:0] mem_add
    );
    always_ff @(posedge clock) 
    begin
        if(reset) begin
            if(ser_done||des_done)mem_add<= mem_add+16'd1;
            if(timer_done) mem_add<=16'd0;
        end
    end
endmodule
