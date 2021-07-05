`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2021 12:36:26
// Design Name: 
// Module Name: top
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


module top();

    reg clk =0;
    
    wire rst;
    wire [31:0] datain1, datain2;
    wire [63:0] dataout1, dataout2;
    wire valid;
    
    always #5 clk = ~clk;
    
    dense_tb TB(clk, rst, datain1, datain2, dataout1, dataout2, valid);
    mul_dense U0(clk, rst, datain1, datain2, dataout1, dataout2, valid);

endmodule
