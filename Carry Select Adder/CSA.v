`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2025 09:54:12
// Design Name: 
// Module Name: CSA
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


module CSA(A, B, Cin, Sum, Cout, Z);

    input signed [31:0] A, B;                                               //32 Bit inputs
    input Cin;                                                              //1 Bit Carry In
    
    output signed [31:0] Sum;                                               //32 Bit Sum/Result
    output Cout, Z;                                                         //Single Bit Carry Out and Zero flag
    
    wire [7:0] S_inter;                                                      //7 Bit intermediate Sum to store Level1 output
    wire [23:0] S_inter_Low, S_inter_High;                                   //24 Bit intermediate Sum values for remaining bits (both possibilities i.e. redundant logic)
    wire CintL1;                                                             //Carry generated from Level-1
    wire CintL2, CintL2a, CintL2b;                                           //Carry generated from Level-2, Level2 when carry in from previous stage is 0 and 1 respectively
    wire CintL3, CintL3a, CintL3b;                                           //Carry generated from Level-3, Level3 when carry in from previous stage is 0 and 1 respectively
    wire CintL4a, CintL4b;                                                   //Carry generated from Level-4, Level4 when carry in from previous stage is 0 and 1 respectively
    
    //LEVEL-1
    RCA8_Unsigned L1 (A[7:0], B[7:0], Cin, Sum[7:0], CintL1);               //Addition of First 8 bits
    
    //LEVEL-2
    RCA8_Unsigned L2a (A[15:8], B[15:8], 0, S_inter_Low[7:0], CintL2a);     //Addition of next 8 bits when Cin is 0
    RCA8_Unsigned L2b (A[15:8], B[15:8], 1, S_inter_High[7:0], CintL2b);    //Addition of next 8 bits when Cin is 1
    mux2x1 L2 (S_inter_Low[7:0], S_inter_High[7:0], CintL1, Sum[15:8]);     //Mux to choose corresponding Sum depending on Cin from level-1
    mux2x1 L2_carry (CintL2a, CintL2b, CintL1, CintL2);                     //Mux to choose corresponding Carry depending on Cin from level-1
    
    //LEVEL-3
    RCA8_Unsigned L3a (A[23:16], B[23:16], 0, S_inter_Low[15:8], CintL3a);  //Addition of next 8 bits when Cin is 0
    RCA8_Unsigned L3b (A[23:16], B[23:16], 1, S_inter_High[15:8], CintL3b); //Addition of next 8 bits when Cin is 1
    mux2x1 L3 (S_inter_Low[15:8], S_inter_High[15:8], CintL2, Sum[23:16]);  //Mux to choose corresponding Sum depending on Cin from level-2
    mux2x1 L3_carry (CintL3a, CintL3b, CintL2, CintL3);                     //Mux to choose corresponding Carry depending on Cin from level-2
    
    //LEVEL-4
    RCA8_Signed L4a (A[31:24], B[31:24], 0, S_inter_Low[23:16], CintL4a);   //Signed Addition of final 8 bits when Cin is 0
    RCA8_Signed L4b (A[31:24], B[31:24], 1, S_inter_High[23:16], CintL4b);  //Signed Addition of final 8 bits when Cin is 1
    mux2x1 L4 (S_inter_Low[23:16], S_inter_High[23:16], CintL3, Sum[31:24]);//Mux to choose corresponding Sum depending on Cin from level-3
    mux2x1 L4_carry (CintL4a, CintL4b, CintL3, Cout);                       //Mux to choose corresponding Carry depending on Cin from level-3
    
    assign Z = (|Sum == 0)? 1 : 0;                                          //Using bitwise Or for checking Zero
    
endmodule
