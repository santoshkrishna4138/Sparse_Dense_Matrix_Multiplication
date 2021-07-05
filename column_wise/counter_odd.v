`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2020 12:24:43
// Design Name: 
// Module Name: blocking_counter
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


module counter_odd(reset,clk,enable,count);
input reset,clk;
input enable;
parameter COUNT_LEN=10;
output reg[COUNT_LEN:0]count;

always@(posedge clk)
begin
if(reset) begin

count=1;

end
else if(enable)
begin
count=count+2;
end
else begin
count=count;
end

end
endmodule
