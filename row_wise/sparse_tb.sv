`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2021 09:37:57
// Design Name: 
// Module Name: sparse_tb
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


module sparse_tb(clk, rst, datain1, datain2, dataout1, dataout2 ,addrext, valid, zeros);
    input clk;
    input [63:0] dataout1, dataout2;
    input valid, zeros;
    input [9:0] addrext;
    
    output reg rst;
    output reg [31:0] datain1, datain2;

    int A [0:559][0:559], R [0:559][0:559];
    
    initial
    begin
    for (int i = 0; i < 560; i++)
        for (int j = 0; j < 560; j++)
        begin
            A[i][j] = $urandom%10;
        end
    end
    
    int i, j, x, y;
    
    initial
    begin
        i = 0; j = 0; x = 0; y = 0;
        rst = 0;
        repeat (20) @(posedge clk);
        rst = 1;
        while(1)
        begin
            @(posedge clk);
            begin
                datain1 = A[addrext][j];
                datain2 = A[addrext][j+1];
                
                if(j == 558)
                begin
                    j = 0;
                end
                else
                    j = j + 2;
            end
            
            if (valid)
            begin
                R[x][y] = dataout1;
                R[x][y+1] = dataout2;
                if(y == 558)
                begin
                    y = 0;
                    x = x + 1;
                end
                else
                    y = y + 2;
                
                if(x == 560)
                    $finish;    
            end
            
            if(zeros)
                x = x + 1;
       end

    end


endmodule
