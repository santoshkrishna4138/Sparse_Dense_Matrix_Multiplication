`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2021 16:00:01
// Design Name: 
// Module Name: MUL_BLOCK
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


module MUL_BLOCK(clk,reset,dense_in,wea,ena,addra,din,mul_out,web,enb,addrb,sclr   );
input clk;
input reset;
input sclr;
input[31:0] dense_in;
output reg wea,ena;
output reg web,enb;
input  [31:0]din;
output reg [10:0]addra;
output reg [10:0]addrb;
output [63:0] mul_out;
reg[31:0]A,B;
reg [4:0]state,next_state;
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
`define state12 5'd11
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

mult_gen_0 M0(.CLK(clk), .A(A), .B(B), .P(mul_out),.SCLR(sclr));
reg reset_e,enable_e,reset_o,enable_o;
wire [10:0]count_e,count_o;
counter_even even_counter(reset_e,clk,enable_e,count_e);
counter_odd odd_counter(reset_o,clk,enable_o,count_o);
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
`state10:begin   next_state=`state6; end
`state11:begin   next_state=`state12; end
`state12:begin   next_state=`state13; end
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

always@(state,reset,count_o,count_e,dense_in,din)
begin 
if(!reset) 
begin
wea=0;
ena=0;
addra=0;


web=0;
enb=0;
addrb=0;

A=0;
B=0;

reset_e=1;
enable_e=0;

reset_o=1;
enable_o=0;
end
else begin
case(state)
`state1: 
begin
wea=0;
ena=0;
addra=0;


web=0;
enb=0;
addrb=0;

A=0;
B=0;

reset_e=0;
enable_e=0;

reset_o=0;
enable_o=0;
end
`state2: 
begin
wea=0;
ena=1;
addra=count_e;


web=0;
enb=1;
addrb=count_o;

A=0;
B=0;

reset_e=0;
enable_e=0;

reset_o=0;
enable_o=0;
end

`state3: 
begin
wea=0;
ena=1;
addra=count_e;


web=0;
enb=1;
addrb=count_o;

A=0;
B=0;

reset_e=0;
enable_e=0;

reset_o=0;
enable_o=0;
end

`state4: 
begin
wea=0;
ena=1;
addra=count_e;


web=0;
enb=1;
addrb=count_o;

A=0;
B=0;

reset_e=0;
enable_e=0;

reset_o=0;
enable_o=0;
end

`state5:
begin
wea=0;
ena=1;
addra=count_e;


web=0;
enb=1;
addrb=count_o;

A=din;
B=dense_in;

reset_e=0;
enable_e=1;

reset_o=0;
enable_o=1;
end

`state6:
begin
wea=0;
ena=1;
addra=count_e;


web=0;
enb=1;
addrb=count_o;

A=0;
B=0;

reset_e=0;
enable_e=0;

reset_o=0;
enable_o=0;
end

`state7:
begin
wea=0;
ena=1;
addra=count_e;


web=0;
enb=1;
addrb=count_o;

A=0;
B=0;

reset_e=0;
enable_e=0;

reset_o=0;
enable_o=0;
end

`state8:
begin
wea=0;
ena=1;
addra=count_e;


web=0;
enb=1;
addrb=count_o;

A=0;
B=0;

reset_e=0;
enable_e=0;

reset_o=0;
enable_o=0;
end

`state9:
begin
wea=0;
ena=1;
addra=count_e;


web=0;
enb=1;
addrb=count_o;

A=0;
B=0;

reset_e=0;
enable_e=0;

reset_o=0;
enable_o=0;
end

`state10:
begin
wea=0;
ena=1;
addra=count_e;


web=0;
enb=1;
addrb=count_o;

A=dense_in;
B=din;

reset_e=0;
enable_e=1;

reset_o=0;
enable_o=1;
end

 
default: begin 
wea=0;
ena=0;
addra=count_e;


web=0;
enb=0;
addrb=count_o;

A=0;
B=0;

reset_e=0;
enable_e=0;

reset_o=0;
enable_o=0;
 end

endcase
end
end

endmodule
