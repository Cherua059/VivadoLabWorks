`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2025 11:59:03
// Design Name: 
// Module Name: RCA64_Behavioral_tb
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

module RCA64_Behavioral_tb();

    parameter n = 16;
    wire [n-1:0] Sum;
    wire Cout;
    wire V;
    
    reg [n-1:0] a, b;
    reg cin;

    //RCA_Behavioral_Signed #(n) rca (a, b, cin, Sum, Cout, V);
    RCA_Behavioral_Unsigned #(n) rca (a, b, cin, Sum, Cout, V);
        
    initial 
        begin
        $monitor("A = %d: B = %d, Cin = %b --> S = %d, Cout = %b, Overflow = %b", a, b, cin, Sum, Cout, V);
        a = 16'hffaa; b = 0; cin=1'b0;
        #100 a = 16'hffaa; b = 16'hffaa; cin=1'b1;
        #100 a = 34; b = 42; cin = 1'b0;
        #100 a = 7981; b = 4342; cin = 1'b0;
        #100 a = 5456; b = 4542; cin = 1'b1;
        #100 a = 16'hffff; b = 16'hffaa; cin=1'b1;
        end

endmodule
