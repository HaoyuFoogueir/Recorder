`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2017 07:35:26 PM
// Design Name: 
// Module Name: Main
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


module Main(
    input logic clock,
    input logic reset,
    input logic ply_but,
    input logic rec_but,
    input logic chn,//chanel switch
    input logic mem1_adr,
    input logic mem2_adr,
    output logic [7:0] led,
    output logic mem1,
    output logic mem2,
    input logic mic,
    output logic speak
    );
    logic ena_des;
    logic des_done;
    logic [15:0] des_data;
    logic ena_ser;
    logic ser_done;
    logic [15:0] ser_data;
    logic onem_clk;//one mega hertz clock
    logic timer_en;
    logic time_done;
    logic clock_sync;
    logic reset_sync;
    logic ply_sync;
    logic rec_sync;
    logic chn_sync;
    logic led_num;
    logic time_rst;
    logic en_ram1;
    logic en_ram2;
    logic wea;
    logic [16:0] addr;
    
    logic [7:0] led_pin;
    logic [7:0] an;
Deserializer dut1( 
    .onem_clk(clock_i),//dont remember if needs to be 1MHz or 100MHz, input
    .ena_des(enable_i),//input
    pdm_data_i,// input
    .des_done(done_o),//output 
    .des_data(data_o),//output
    pdm_lrsel_o,//output
    pdm_clk_o//output
    );

Serializer dut2(
    .onem_clk(clock_i),// same as deseralizer, input 
    .ena_ser(enable_i),//input
    .ser_done(done_o),//output
    .ser_data(data_i),//input
    pwm_audio_o,//output
    pwm_sdaudio_o//output
);

Clock dut3(
    .reset(rst),//input
    .clock(og_clk),//input
    .onem_clk(nw_clk)//output
);

Timer dut4(
    .time_en(rst),//input
    .clock(clk),//input
    .timer_en(en),//input
    .time_done(done) //input
);

Synchronizer dut5(
    .clock(clk),//input
    .reset(rst),//input
    .rec_but(rec),//input
    .ply_but(ply),//input
    .chn(num),//need to change the synchronizer that has rec or ply num to just one chanel select. input
    .reset_sync(orst),//ouput
    .rec_sync(orec),//output
    .ply_sync(oply),//output
    .chn_sync(onum)//output
);
Segment_LED_Interface dut6(
    .led_num(num),//input
    .clock(clk),//input
    .led_pin(led_pins),//make pins to be connected, output
    .an(anode)
    
);

Controller dut7(
    .clock(clk),//input
    .reset_sync(rst),//input
    .rec_sync(rec),//input
    .ply_sync(ply),//input
    .chn_sync(num),//input
    .en_ram1(EN_ram1),//output
    .en_ram2(EN_ram2),//output
    .wea(wea),//output
    .ena_des(EN_deser),//output
    .ena_ser(EN_ser),//output,
    .timer_en(EN_time),//output
    .time_rst(reset_time)//output
);

Addr_cont dut8( 
    .onem_clk(clock),
    .reset_sync(reset),
    .time_done(timer_done),
    .ser_done(ser_done),
    .des_done(des_done),
    .addr(mem_add)
    );
endmodule
