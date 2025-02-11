`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 15:30:47
// Design Name: 
// Module Name: cla64_tb
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


module cla64_tb();

    reg signed [63:0] a, b;                                            
    reg cin;                                                          
    
    wire signed [63:0] sum;                                             
    wire cout;
    
    cla64 cla (a, b, cin, sum, cout);
    
    initial
        begin
        $monitor("A = %d: B = %d, Cin = %b --> Sum = %d, Cout = %b", a, b, cin, sum, cout);
        a = 16'hffffaaaafffffaaaa; b = 0; cin=1'b0;
        #100 a = 64'hffffaaaafffffaaaa; b = 64'hffffaaaafffffaaaa; cin=1'b1;
        #100 a = 34; b = 42; cin = 1'b0;
        #100 a = 7981312; b = 53454342; cin = 1'b0;
        #100 a = 54568789; b = 4534542; cin = 1'b1;
        #100 a = 64'hfffffffffffffffff; b = 64'hffffaaaafffffaaaa; cin=1'b1;
        end


endmodule
