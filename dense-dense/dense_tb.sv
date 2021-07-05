`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2021 12:06:59
// Design Name: 
// Module Name: dense_tb
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


module dense_tb(clk, rst, datain1, datain2, dataout1, dataout2, valid);
    input clk;
    input [63:0] dataout1, dataout2;
    input valid;
    
    output reg rst;
    output reg [31:0] datain1, datain2;

    int A [559:0][559:0], B [559:0][559:0], R [559:0][559:0];
    
    initial
    begin
    for (int i = 0; i < 560; i++)
        for (int j = 0; j < 560; j++)
        begin
            A[i][j] = $urandom%10;
            B[i][j] = $urandom%10;
        end
    end
    
    int i, j, x, y, l, m;
    int count;
    initial
    begin
        i = 0; j = 0; x = 0; y = 0; l = 0; m = 0;
        count = 0;
        rst = 0;
        repeat (20) @(posedge clk);
        rst = 1;
        @(posedge clk);
        while(1)
        begin
            @(posedge clk);
            if(count == 0 || count == 560)
            begin
                datain1 = A[i][j];
                datain2 = A[i][j+1];
                
                if(j == 558)
                begin
                    j = 0;
                    i = i + 1;
                end
                else
                    j = j + 2;
                if(count == 560)
                    count = 0;
            end
            else
            begin
                datain1 = B[x][y];
                datain2 = B[x][y+1];
                if(y == 558)
                begin
                    y = 0;
                    if (x == 559)
                        x = 0;
                    else
                        x = x + 1;
                end
                else
                    y = y + 2;
            end
            count = count + 1;
            
            if (valid)
            begin
                R[l][m] = dataout1;
                R[l][m+1] = dataout2;
                if(m == 558)
                begin
                    m = 0;
                    l = l + 1;
                end
                else
                    m = m + 2;
                    
                if(l == 560)
                    $finish;
                    
            end
       end

    end
    

    
endmodule
