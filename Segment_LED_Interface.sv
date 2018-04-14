`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2017 03:51:45 PM
// Design Name: 
// Module Name: Segment_LED_Interface
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


module Segment_LED_Interface(
    input logic num,//1-bit number to represent chanel 1 or chanel 2, if the bonus is implemented, make more bits.
    input logic clk,
    output logic [6:0]led_pins,//outputs for led, 0=on, Sa=[0] and Sg=[6]
    output logic [6:0]anod
    );
    
    always_ff @ (posedge clk)
    begin
    anod<=6'b111110;
    case(num)
        1'b0://displays zero, may need change
            begin 
            led_pins[6:5]=1'b1;
            led_pins[4:0]=1'b0;
            end
        1'b1://displays one
            begin
            led_pins[0]=1'b1;
            led_pins[6:3]=1'b1;
            led_pins[2:1]=1'b0;
            
            end
        default: led_pins=1'b1;//turns off display if something unexpected happens
    endcase 
    end
    
endmodule
