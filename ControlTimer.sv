`timescale 1us / 1ns

module Timer(
    input logic rst,
    input logic clk,
    input logic en,
    output logic done 
    );
    logic [27:0]count=0;
     always_ff @ (posedge clk)
     begin
        if(done==1&&en==0) done<=~done;
        if(rst||(count==28'd199999999))//counting 100 for the 100 MHz to be 1MHz
            begin
            count<=28'd0;
            done<=1;
            end
        else if(en)
            count<=count+28'd1;
     end
endmodule
