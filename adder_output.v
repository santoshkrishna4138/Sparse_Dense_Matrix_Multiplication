`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2021 16:25:39
// Design Name: 
// Module Name: adder_output
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


module adder_output(op1,clk,done,dout1,dout2,dout3,dout4,dout5,dout6,dout7,dout8,dout9,dout10,dout11,dout12,dout13,dout14,dout15,dout16);
input clk;

input done;
input[63:0] dout1;
input[63:0] dout2;
input[63:0] dout3;
input[63:0] dout4;
input[63:0] dout5;
input[63:0] dout6;
input[63:0] dout7;
input[63:0] dout8;
input[63:0] dout9;
input[63:0] dout10;
input[63:0] dout11;
input[63:0] dout12;
input[63:0] dout13;
input[63:0] dout14;
input[63:0] dout15;
input [63:0] dout16;
output [63:0]op1;
wire [63:0]A[15:0];
wire [63:0]B[15:0];
wire [63:0]S[15:0];
 /*PORT (
   A : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
   B : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
   CLK : IN STD_LOGIC;
   CE : IN STD_LOGIC;
   S : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
 );*/
genvar k;
     generate 
     for(k=0;k<15;k=k+1) begin : adder 
  c_addsub_0 adder (
       A[k],B[k],clk,done,S[k]
      );
    end
    endgenerate

assign A[0]=dout1;
assign A[1]=dout2;
assign A[2]=dout3;
assign A[3]=dout4;
assign A[4]=dout5;
assign A[5]=dout6;
assign A[6]=dout7;
assign A[7]=dout8;

assign B[0]=dout9;
assign B[1]=dout10;
assign B[2]=dout11;
assign B[3]=dout12;
assign B[4]=dout13;
assign B[5]=dout14;
assign B[6]=dout15;
assign B[7]=dout16;

assign A[8]=S[0];
assign A[9]=S[1];
assign A[10]=S[2];
assign A[11]=S[3];

assign B[8]=S[4];
assign B[9]=S[5];
assign B[10]=S[6];
assign B[11]=S[7];

assign A[12]=S[8];
assign A[13]=S[9];
assign B[12]=S[10];
assign B[13]=S[11];

assign A[14]=S[12];
assign B[14]=S[13];
assign op1=S[14];


endmodule
