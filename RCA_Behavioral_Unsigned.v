`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2025 21:46:14
// Design Name: 
// Module Name: RCA_Behavioral_Unsigned
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


module RCA_Behavioral_Unsigned #(parameter N = 16) (A, B, Cin, Sum, Cout, V);

    input [N-1:0] A, B; //64 bit Inputs
    input Cin; //Carry In at LSB
    
    output reg [N-1:0] Sum; //64 bit Sum Output
    output reg Cout; //Carry Out Generated at MSB
    output reg V; //Overflow
    
    reg [N-1:0] c; //Intermediate Carry Ins
    
    integer i; //for loop variable
    
    always @ (A, B, Cin)
        begin        
        for (i = 0; i < N; i = i+1)
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
            
        Cout = c[N-1]; //Carry at MSB        
        if (Cout == 1) //checking for overflow condition
            begin
            V = 1;
            end
        else
            begin
            V = 0;
            end
        end
        
endmodule
