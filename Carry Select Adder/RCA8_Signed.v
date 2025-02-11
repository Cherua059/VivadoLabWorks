`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2025 09:54:12
// Design Name: 
// Module Name: RCA8_Signed
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


module RCA8_Signed (A, B, Cin, Sum, Cout, V);

    input signed [7:0] A, B; //N bits Inputs in signed format
    input Cin; //Carry In at LSB
    
    output reg signed [7:0] Sum; ///N bits Sum Output in signed format
    output reg Cout; //Carry Out Generated at MSB
    output reg V; //Overflow
    
    reg [7:0] c; //Intermediate Carry Ins
    
    integer i; //loop variable
    
    always @ (A, B, Cin)
        begin        
        for (i = 0; i < 8; i = i+1)
            begin
            if (i == 0) //first loop -> LSB
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
        V = Cout ^ c[6]; //checking for overflow condition        
        end
        
endmodule

