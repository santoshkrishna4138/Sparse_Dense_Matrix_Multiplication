`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2021 03:20:43
// Design Name: 
// Module Name: ADDITION_BLOCK
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


module ADDITION_BLOCK(clk,reset,prod,row_index,wea,ena,addra,dina,douta,index,index1,enable);
input clk;
input reset;
input [31:0]row_index;
input[63:0]prod;
 output reg wea,ena;
 output reg[9:0] addra;
 output reg [63:0]dina;
input  [63:0]douta;
reg[4:0]state,next_state;
reg[31:0] addr[1:0];
input index,index1;


/*
 PORT (
   A : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
   B : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
   CLK : IN STD_LOGIC;
   S : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
 );
prod+douta;
*/
wire [63:0] sum;
output reg enable;
c_addsub_1 adder_block_i (prod,douta,clk,sum);
  
  
`define state1 5'd0
`define state2 5'd1
`define state3 5'd2
`define state4 5'd3
`define state5 5'd4
`define state6 5'd5
`define state7 5'd6
`define state8 5'd7
`define state9 5'd8
`define state10 5'd9
`define state11 5'd10
`define state7a 5'd11
`define state13 5'd12
`define state14 5'd13
`define state15 5'd14
`define state16 5'd15
`define state17 5'd16
`define state18 5'd17
`define state19 5'd18
`define state20 5'd19
`define state21 5'd20
`define state22 5'd21
`define state23 5'd22
`define state24 5'd23
`define state25 5'd24

always@(posedge clk)
begin
if(!reset)
state=0;
else
state=next_state;
end


always@(state,reset) begin
if(!reset)
begin
next_state=`state1;
end
else
case(state)//something
`state1: begin next_state=`state2; end
`state2:begin next_state=`state3; end
`state3:begin   next_state=`state4; end
`state4:begin   next_state=`state5;end
`state5:begin   next_state=`state6; end
`state6:begin   next_state=`state7; end
`state7:begin   next_state=`state8; end
`state8:begin   next_state=`state9; end
`state9:begin   next_state=`state10; end
`state10:begin   next_state=`state11; end
`state11:begin   next_state=`state7a; end
`state7a:begin   next_state=`state8; end
`state13:begin   next_state=`state14; end
`state14:begin   next_state=`state15; end
`state15:begin   next_state=`state16; end
`state16:begin   next_state=`state17; end
`state17:begin   next_state=`state18; end
`state18:begin   next_state=`state19; end
`state19:begin   next_state=`state20; end

default: begin  next_state=`state1; end

endcase

end
reg[31:0]addr_[1:0];
reg index_,index1_;
always@(posedge clk)
begin
if(!reset) begin
addr_[0]=0;
addr_[1]=0;

end

else begin
addr_[0]=addr[0];
addr_[1]=addr[1];

end

end

always@(state,reset,prod,douta,index,index1,addr_[0],addr_[1],row_index,sum)
begin 
if(!reset) 
begin
 wea=0;
 ena=0;
 addra=0;
 dina=0;
 addr[1]=0;
  addr[0]=0;
enable=0;
end
else begin
case(state)
`state1: begin 
 addr[1]=0;
  addr[0]=0;
 wea=0;
ena=0;
addra=0;
dina=0;
enable=0;

 end
`state2:begin 
enable=0;
 wea=0;
ena=0;
addra=0;
dina=0;
 addr[1]=addr_[1];
 addr[0]=addr_[0];
//index=index_;
 //index1=index1_;
end
`state3:begin
 enable=0;
 addr[1]=addr_[1];
addr[0]=addr_[0]; 
 wea=0;
ena=0;
addra=0;
dina=0;
 addr[1]=addr_[1];
 addr[0]=addr_[0];
//index=index_;
// index1=index1_;
 end
`state4:begin   
 enable=0;
 wea=0;
ena=0;
addra=0;
dina=0;
 addr[1]=addr_[1];
addr[0]=addr_[0];
//index=index_;
 //index1=index1_;

end
`state5:begin
 enable=0;
 addr[1]=addr_[1];
addr[0]=addr_[0];   
 wea=0;
ena=0;
addra=0;
dina=0;
//index=index_;
//index1=index1_;
 addr[index1]=addr_[index1];
addr[index]=row_index;

 end
`state6:begin 
 enable=0;
 wea=0;
ena=0;
addra=0;
dina=0;
 addr[1]=addr_[1];
addr[0]=addr_[0];
//index=index_;/
//index1=index1_;
 end
`state7:begin 
 enable=0;
 wea=0;
ena=1;
addra=0;
dina=0;
 addr[1]=addr_[1];
addr[0]=addr_[0];
//index=index_;
//index1=index1_;
 end
`state8:begin   
enable=0;
 wea=0;
ena=1;
 addr[1]=addr_[1];
addr[0]=addr_[0];
addra=addr[index];
dina=0;
//index=index_;
//index1=index1_;

 end
`state9:begin  
enable=0;
wea=0;
ena=1;
 addr[1]=addr_[1];
addr[0]=addr_[0];
addra=addr[index];
dina=0;
//index=index_;
//index1=index1_;
 end
`state10:begin
 enable=0;
 addr[1]=addr_[1];
addr[0]=addr_[0];   
 wea=0;
ena=1;
addra=0;
dina=0;
 addr[index1]=row_index;
addr[index]=addr_[index];
//index=index_;
//index1=index1_;
 end
`state11:begin
enable=1;
 
 addr[1]=addr_[1];
addr[0]=addr_[0];   
  wea=0;
 ena=1;
 addra=0;
 dina=0;
  addr[1]=addr_[1];
addr[0]=addr_[0];
//index=index1_;
//index1=index_;
  end 
`state7a: begin
enable=0;
 addr[1]=addr_[1];
addr[0]=addr_[0];   
  wea=1;
 ena=1;
 addra=addr[index1];
 dina=sum;
  addr[1]=addr_[1];
addr[0]=addr_[0];
//index=index_;
//index1=index1_;

end
 
default: begin
 enable=0;
 wea=0;
ena=0;
addra=0;
dina=0;
 addr[1]=addr_[1];
addr[0]=addr_[0];
//index=index_;
//index1=index1_;
//index1=index1_;
//index1=index1_;
//index1=index1_;
//index1=index1_;
//index1=index1_;

end
endcase
end


end



endmodule
