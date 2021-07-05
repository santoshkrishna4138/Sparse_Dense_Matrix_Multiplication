`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2021 11:12:24
// Design Name: 
// Module Name: comparator
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


module comparator(clk, A, B, L, G, E);

    input clk;
    input [31:0] A, B;
    output reg L, G, E;
    
    always @ (posedge clk)
    begin
        if(A < B)
        begin
            L <= 1;
            E <= 0;
            G <= 0;
        end
        
        if(A == B)
        begin
            L <= 0;
            E <= 1;
            G <= 0;
        end
        
        if(A > B)
        begin
            L <= 0;
            E <= 0;
            G <= 1;
        end
     end

endmodule
