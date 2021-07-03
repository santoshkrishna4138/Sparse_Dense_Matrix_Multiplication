`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2021 18:50:31
// Design Name: 
// Module Name: sr_flip
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


module sr_flip(clk,reset,enable,index,index1 );
input clk;
input reset;
input enable;
output reg  index,index1;

always@(posedge clk) begin
if(!reset) begin
index=0;
index1=1;
end
else begin
if(enable) begin
index=index+1;
index1=index1+1;
end
else begin
index=index;
index1=index1;
end
end

end
endmodule
