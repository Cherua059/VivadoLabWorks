`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2025 09:54:12
// Design Name: 
// Module Name: mux2x1
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

module mux2x1(In0, In1, S, Y);

    input [7:0] In0, In1; //8 bit inputs
    input S;
    output reg [7:0] Y;
    
    always @ (In0, In1, S)
        begin
        if(S)
            begin
            Y = In1;
            end
        else
            begin
            Y = In0;
            end
        end

endmodule
