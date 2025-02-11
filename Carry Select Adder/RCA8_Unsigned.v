`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2025 09:54:12
// Design Name: 
// Module Name: RCA8_Unsigned
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

module RCA8_Unsigned (A, B, Cin, Sum, Cout);

    input [7:0] A, B; //8 bit Inputs
    input Cin; //Carry In at LSB
    
    output reg [7:0] Sum; //64 bit Sum Output
    output reg Cout; //Carry Out Generated at MSB
    
    reg [7:0] c; //Intermediate Carry Ins
    
    integer i; //for loop variable
    
    always @ (A, B, Cin)
        begin        
        for (i = 0; i < 8; i = i+1)
            begin
            if (i == 0) 
                begin
                Sum[i] = A[i] ^ B[i] ^ Cin; //Sum at LSB using Cin
                c[i] = (A[i] & B[i]) | (Cin & (A[i]^B[i]));  //Carry at LSB using Cin
                end
            else 
                begin
                Sum[i] = A[i] ^ B[i] ^ c[i-1]; //Sum at Remaining bits using previous bit carry
                c[i] = (A[i] & B[i]) | (c[i-1] & (A[i]^B[i])); //Carry of remaining bits using previous bit carry
                end
            end
            
        Cout = c[7]; //Carry at MSB  
        end
endmodule
