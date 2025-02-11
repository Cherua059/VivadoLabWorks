`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2025 13:31:32
// Design Name: 
// Module Name: shifter_32
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


/* Design of a 32-bit combinational shifter that can do logical shift (left/right) and arithmetic shift (left/right) by any amount between 0 to 31 bits based on its control signals.
Shifter has a 32-bit operand as input on which the shift is to be applied
A five bit unsigned integer that specifies the amount of shift
And a 2-bit control that specifies the type of shift operation (left/right; logical/arithmetic)
It has one 32-bit output that is the result of the shift operation */
/* The shifter has five stages each of which performs a shift (of the type specified by 2-bit shift-type  control) by an amount represented by the numerical value of the bit that controls the shift amount of the stage: 
for example if the msb of 5-bit shift amount is 1/0, then the first stage shifts the input by 16/0  bits (the shift is of the type specified by the 2-bit shift type control) */

module shifter_32 (a, b, c, z);

    input [31 : 0] a;		                      //operand
    input [4 : 0] b;		                      //shift amount
    input [1 : 0] c;		                      //shift type {c = 00 or 01 for LS, c = 11 for ARS, c = 10 for LRS}
    reg [31 : 0]  z4, z3, z2, z1;	              //intermediate results  of cascaded shift stages 
    output reg [31 : 0] z;                        //added output keyword for Z 
    reg [1 : 0] sel4, sel3, sel2, sel1, sel0;	  //mux controls for the 5-stages of muxes
    
    always @ (a, b, c)
    // setting up control signals (sel4, sel3, sel2, sel1, sel0) for the five stages of 4:1 muxes 
    //based on the shift type and the shift amount to be performed by each stage
    begin
    //changed parameter to be checked in case to 3 bits from 2 bits to prevent truncation, caused issue in some test cases.
    casex ({c, b[4]})              //16-bit shift
        3'bxx0 : sel4 = 2'b11;     //No Shift
        3'b0x1 : sel4 = 2'b10;     //Left Shift
        3'b111 : sel4 = 2'b01;     //Arithmetic Right Shift
        3'b101 : sel4 = 2'b00;     //Logical Right Shift
    endcase 
    
    casex ({c, b[3]})              //8-bit shift
        3'bxx0 : sel3 = 2'b11;     //No Shift
        3'b0x1 : sel3 = 2'b10;     //Left Shift
        3'b111 : sel3 = 2'b01;     //Arithmetic Right Shift
        3'b101 : sel3 = 2'b00;     //Logical Right Shift
    endcase
    
    casex ({c, b[2]})              //4-bit shift
        3'bxx0 : sel2 = 2'b11;     //No Shift
        3'b0x1 : sel2 = 2'b10;     //Left Shift
        3'b111 : sel2 = 2'b01;     //Arithmetic Right Shift
        3'b101 : sel2 = 2'b00;     //Logical Right Shift
    endcase
    
    casex ({c, b[1]})              //2-bit shift
        3'bxx0 : sel1 = 2 'b11;    //No Shift
        3'b0x1 : sel1 = 2 'b10;    //Left Shift
        3'b111 : sel1 = 2 'b01;    //Arithmetic Right Shift
        3'b101 : sel1 = 2 'b00;    //Logical Right Shift
    endcase
    
    casex ({c, b[0]})              //1-bit shift
        3'bxx0 : sel0 = 2 'b11;    //No Shift
        3'b0x1 : sel0 = 2 'b10;    //Left Shift
        3'b111 : sel0 = 2 'b01;    //Arithmetic Right Shift
        3'b101 : sel0 = 2 'b00;    //Logical Right Shift
    endcase
    
    //shift stage 4: performs 16/0-bit shift of the specified type on the input
    case (sel4)
        2'b11 : z4 = a;                             //No shift 
        2'b10 : z4 = {a[15:0], {16{1'b0}}};         //Arithmetic/Logical Left Shift //added another pair of {} for zero padding
        2'b01 : z4 = {{16{a[31]}}, a[31:16]};       //Arithmetic Right Shift
        2'b00 : z4 = {{16{1'b0}}, a[31:16]};        //Logical Right Shift
    endcase
    
    //shift stage 3: performs 8/0-bit shift of the specified type on its input
    case (sel3)
        2'b11 : z3 = z4;
        2'b10 : z3 = {z4[23:0], {8{1'b0}}};
        2'b01 : z3 = {{8{z4[31]}}, z4[31:8]};
        2'b00 : z3 = {{8{1 'b0}}, z4[31 : 8]};
    endcase
    
    //shift stage 2: performs 4/0-bit shift of the specified type on its input
    case (sel2)
        2'b11 : z2 = z3; 
        2'b10 : z2 = {z3[27:0], {4{1'b0}}};
        2'b01 : z2 = {{4{z3[31]}}, z3[31:4]};
        2'b00 : z2 = {{4{1'b0}}, z3[31:4]}; //z3 changed to z2
    endcase
    
    //shift stage 1: performs 2/0-bit shift of the specified type on its input
    case (sel1)
        2'b11 : z1 = z2; 
        2'b10 : z1 = {z2[29:0], {2{1'b0}}};
        2'b01 : z1 = {{2{z2[31]}}, z2[31:2]};
        2'b00 : z1 = {{2{1'b0}}, z2[31:2]};
    endcase
    
    //shift stage 1: performs 1/0-bit shift of the specified type on its input
    case (sel0)
        2'b11 : z = z1; 
        2'b10 : z = {z1[30:0], 1'b0};
        2'b01 : z = {{z1[31]}, z1[31:1]};
        2'b00 : z = {1'b0, z1[31:1]};
    endcase
    end
endmodule

