`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 01:29:37 PM
// Design Name: 
// Module Name: Four_to_One_MUX
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


module Four_to_One_MUX(
    input [3:0] A,
    input [3:0] B,
    input [3:0] C,
    input [3:0] D,
    input [1:0] selector,
    output [3:0] mux_out
    );
    
    assign mux_out = (selector == 0) ? A:
                      (selector == 1) ? B: 
                      (selector == 2) ? C:D;
endmodule
