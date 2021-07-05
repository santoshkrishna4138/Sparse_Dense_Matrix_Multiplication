`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2021 11:15:42
// Design Name: 
// Module Name: shift_reg
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


module shift_reg(clk, rst, D);
    
    input clk, rst;
    output reg [560:0] D;
    
    always @ (posedge clk)
    if(!rst)
        D <= 1'b1;
    else
        D <= {D[560 - 1:0], D[560]};
        
endmodule
