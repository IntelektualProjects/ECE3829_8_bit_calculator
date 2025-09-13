`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2025 07:01:58 PM
// Design Name: 
// Module Name: FSM
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


module FSM(
    input clk,
    input btnL,
    input btnR,
    input [7:0] sw,
    output [3:0] an,
    output [6:0] seg,
    output reg [3:0] led
    );
    
    // Finite State Machine States
    parameter INONE = 2'b00;
    parameter INTWO = 2'b01;
    parameter OPERATION = 2'b10;
    parameter RESULT = 2'b11;
    // may need extra state to clear the switch input values
    // or make state transition logical statement
    
    // state variables
    reg [1:0] current_state;
    reg [1:0] next_state;
    
    // User input value instantiations
    reg [7:0] operand_one = 8'b0;
    reg [7:0] operand_two = 8'b0;
    reg [2:0] alu_op;
    
    // ALU Unit Instantiation
    wire [7:0] alu_result;
    ALU a0 (alu_op, operand_one, operand_two, alu_result);
    
    // Debouncer instantiation
    wire btnL_d;
    wire btnR_d;
    Debouncer c0 (clk, btnL, btnL_d);
    Debouncer c1 (clk, btnR, btnR_d);
    
    reg btnR_d_prev;
    always @(posedge clk) btnR_d_prev <= btnR_d;
    
    wire btnR_rising_edge = btnR_d & ~btnR_d_prev;
    
    // Display Instantiation
    wire [15:0] display_val = (current_state != RESULT) ? {operand_two, operand_one}: {8'b0, alu_result};
    DisplayTop d0 (clk, display_val, an, seg);
    
    // Sequential State Change Logic
    always @(posedge clk) begin
        if(btnL_d) begin
            current_state <= INONE;
        end else
            current_state <= next_state;
    end
    
     // Next-State Logic Combinational Block
    always @(*) begin
        case (current_state)
            INONE: begin  // Initialization
                    if(btnR_rising_edge)
                        next_state = INTWO;
                    else
                        next_state = INONE;
                    end
            INTWO:begin  // User input value
                    if(btnR_rising_edge)
                        next_state = OPERATION;
                     else
                        next_state = INTWO;
                  end
            OPERATION:begin  // User value displayed on 7 Seg
                    if(btnR_rising_edge)
                        next_state = RESULT;
                    else
                        next_state = OPERATION;
                  end
            RESULT: begin // Countdown to Led flashing (pause function too)
                    if(btnL_d)
                        next_state = INONE;
                    else
                        next_state = RESULT;
                    end
            default: next_state = INONE;
        endcase
    end
    
    // Sequential State Transiltion Update Logic
    always @(posedge clk) begin
        if(current_state == INONE && next_state == INTWO) begin
            operand_one <= sw;
        end 
        else if(current_state == INTWO && next_state == OPERATION) begin
            operand_two <= sw;
        end
        else if(current_state == OPERATION && next_state == RESULT) begin
            alu_op <= sw[2:0]; // account for only 3-bit value
        end
    end
    
    // led debugging
    always @(*) begin
        case(current_state)
            INONE:
                led = 4'b1;
            INTWO:
                led = 4'b10;
            OPERATION:
                led = 4'b100;
            RESULT:
                led = 4'b1000;
        endcase
    end
    
endmodule
