`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2025 09:20:53 PM
// Design Name: 
// Module Name: DisplayTest
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


module DisplayTest(
    input clk,
    input [7:0] sw,
    output [3:0] an,
    output [6:0] seg
    );
    
    DisplayTop d0 (clk, {8'b0, sw}, an, seg);
endmodule
