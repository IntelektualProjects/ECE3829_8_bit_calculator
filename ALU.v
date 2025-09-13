`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2025 07:29:03 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [2:0] opcode,
    input [7:0] in1,
    input [7:0] in2,
    output reg [7:0] result
    );
    
    always @(*) begin
        case(opcode)
            3'b000: result = in1 ^ in2;
            3'b001: result = in1 & in2;
            3'b010: result = in1 | in2;
            3'b011: result = in1 + in2;
            3'b100: result = in1 + ((~in1) + 8'b1); // Twos complement subtraction
            default: result = 8'b0;
        endcase
    end
endmodule
