`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.01.2025 18:21:44
// Design Name: 
// Module Name: CSA_tb
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

module CSA_tb();

    reg signed [31:0] A, B;                                            
    reg Cin;                                                          
    
    wire signed [31:0] Sum;                                             
    wire Cout, Z;
    
    CSA csa (A, B, Cin, Sum, Cout, Z);
    
    initial
        begin
        $monitor("A = %d: B = %d, Cin = %b --> Sum = %d, Cout = %b, Zero = %b", A, B, Cin, Sum, Cout, Z);
            A = 32'b00000000000000000000000000000000; B = 32'b00000000000000000000000000000000; Cin=1'b0;
        #50 A = 32'b11111111111111111111111111111111; B = 32'b00000000000000000000000000000000; Cin=1'b0;
        #50 A = 34353; B = 42455; Cin = 1'b0;
        #50 A = 32'b11111110000000000000001111111111; B = 32'b00000000000000000000000000000000; Cin=1'b1;
        #50 A = 32'b11111111111111111111111111111111; B = 32'b00000000000000000000000000000000; Cin=1'b1;
        #50 A = 32'b11111100000000000000011111111111; B = 32'b00000000000000001111111100000001; Cin=1'b1;
        end 

endmodule
