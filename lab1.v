`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2025 14:04:45
// Design Name: 
// Module Name: lab1
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


module lab1();

reg signed [3:0] operand1; 
reg signed [3:0] operand2;
reg signed [7:0] result;

initial
    begin
    
    operand1 = 6;
    operand2 = 5;
    
    result = operand1 + operand2;       //Add operator
    $display("Time = %d, Addition = %d", $time, result);
    
    #10 result = operand1 - operand2;   // subtraction operator
    $display("Time = %d, Subtraction = %d", $time, result);
    
    #10 result = operand1 * operand2;   // multiply operator    
    $display("Time = %d, Multiplication = %d", $time, result);
    
    #10 result = operand1 % operand2;   //modulus operator    
    $display("Time = %d, Modulus = %d", $time, result);
    
    #10 result = operand1 ** operand2;  //power operator
    $display("Time = %d, Power = %d", $time, result);
    
    #10 result = !operand1;             //logical negation
    $display("Time = %d, Logical negation = %d", $time, result);
    
    #10 result = operand1 > operand2;   //greater than
    $display("Time = %d, Greater than = %d", $time, result);
    
    #10 result = operand1 < operand2;   //less than
    $display("Time = %d, Less than = %d", $time, result);
    
    #10 result = operand1 >= operand2;  //greater than or equal
    $display("Time = %d, Greater than or equal = %d", $time, result);
    
    #10 result = operand1 <= operand2;  //less than or equal
    $display("Time = %d, Less than or equal = %d", $time, result);
    
    #10 result = operand1 == operand2;  //equality
    $display("Time = %d, Equality = %d", $time ,result);
    
    #10 result = operand1 != operand2;  //inequality
    $display("Time = %d, Inequality = %d", $time, result);
    
    #10 result = operand1 & operand2;   //bitwise and
    $display("Time = %d, bitwise And = %d", $time, result);
    
    #10 result = operand1 | operand2;   //bitwise or
    $display("Time = %d, Bitwise or = %d", $time, result);
    
    #10 result = operand1 ^ operand2;   //bitwise xor
    $display("Time = %d, Bitwise xor = %d", $time, result);
    
    #10 result = operand1 ^~ operand2;  //bitwise xnor
    $display("Time = %d, Bitwise xnor = %d", $time, result);
    
    #10 result = operand1 >> operand2;  //right shift
    $display("Time = %d, Right Shift = %d", $time, result);
    
    #10 result = operand1 << operand2;  //left shift 
    $display("Time = %d, Left Shift = %d", $time, result);
    
    #10 result = operand1 >>> operand2; //arithmetic right shift
    $display("Time = %d, Arithmetic Right Shift = %d", $time, result);
    
    #10 result = operand1 <<< operand2; //arithmetic leftt shift
    $display("Time = %d, Arithmetic Left Shift = %d", $time, result);
    
    $finish();
    
    end    
endmodule
