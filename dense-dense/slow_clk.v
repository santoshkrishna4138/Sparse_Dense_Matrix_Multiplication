`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2021 11:14:08
// Design Name: 
// Module Name: slow_clk
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


module slow_clk(clk, rst, out_clk);
    
    input clk, rst;
    output reg out_clk;
    
    reg [4:0] counter;
    always @ (posedge clk)
	begin
	
		if(!rst)
		begin
			counter <= 0;
			out_clk <= 0;
        end
		else
		begin
            if(counter == 27)
            begin 
                out_clk <= 1;
                counter <= 0;
            end
            else	
            begin
                out_clk <= 0;
                counter <= counter + 1;
            end
       end
	end
endmodule