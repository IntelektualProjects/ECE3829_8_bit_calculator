`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 01:49:20 PM
// Design Name: 
// Module Name: DisplayTop
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


module DisplayTop(
    input clk,
    input [15:0] display_value,
    output [3:0] an,
    output [6:0] seg
    );
    
    wire clkout;
    wire [3:0] mux_out;
    wire [1:0] counter_out;
    // ones, tens, hundreds, thousands
    // module instantiations and wiring for display
    Four_to_One_MUX a2 (display_value[3:0], display_value[7:4], display_value[11:8], display_value[15:12], counter_out, mux_out);
    DisplayCLK a3 (clk, clkout);
    Two_bit_counter a4 (clkout, counter_out);
    Two_Four_Decoder a5 (counter_out, an);
    BCDtoSevenSeg a6 (mux_out, seg);
    
    
endmodule
