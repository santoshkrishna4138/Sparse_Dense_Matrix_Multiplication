`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2021 14:03:14
// Design Name: 
// Module Name: topmod
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


module topmod(clk,reset,gamma,row,op1,op2,op1_enable);
    reg done;
    reg done_add,done_mul;
    output  [63:0]op1;
    output [63:0]op2;
    output reg op1_enable;
    input clk;
    input reset;
    input[31:0]gamma,row;
    parameter number_of_brams=16;
    parameter depth_of_brams=10;
    
    `define esta1 5'd0
    `define esta2 5'd1
    `define esta3 5'd2
    `define esta4 5'd3
    `define esta5 5'd4
    `define esta6 5'd5
    `define esta7 5'd6
    `define esta8 5'd7
    `define esta9 5'd8
    `define esta10 5'd9
    `define esta11 5'd10
    `define esta12 5'd11
    `define esta13 5'd12
    `define esta14 5'd13
    `define esta15 5'd14
    `define esta16 5'd15
    `define esta17 5'd16
    `define esta18 5'd17
    `define esta19 5'd18
    `define esta20 5'd19
    `define esta21 5'd20
    `define esta22 5'd21
    `define esta23 5'd22
    `define esta24 5'd23
    `define esta25 5'd24
    //reg done;
    wire clka;
    reg reset1;
    // bram for sparse
    reg [31:0]val,ri;
   /* (* keep = "true" *)*/ reg [4:0]state;
    reg [4:0]next_state;
    wire[10:0] addra[15:0];
    wire[10:0] addrb[15:0];
    wire wea[15:0];
    wire web[15:0];
    wire[31:0]dina[15:0];
    wire[31:0]douta[15:0];
    wire[31:0]dinb[15:0];
    wire[31:0]doutb[15:0];
    wire ena[15:0];
    wire enb[15:0];
    /////
    ////
    //BS
    wire[10:0] addra_a[15:0];
    wire[10:0] addrb_a[15:0];
    wire wea_a[15:0];
    wire web_a[15:0];
    wire[31:0]dina_a[15:0];
    wire[31:0]douta_a[15:0];
    wire[31:0]dinb_a[15:0];
    wire[31:0]doutb_a[15:0];
    wire ena_a[15:0];
    wire enb_a[15:0];
    wire[10:0] addra_s[15:0];
    wire[10:0] addrb_s[15:0];
    wire wea_s[15:0];
    wire web_s[15:0];
    wire[31:0]dina_s[15:0];
    wire[31:0]douta_s[15:0];
    wire[31:0]dinb_s[15:0];
    wire[31:0]doutb_s[15:0];
    wire ena_s[15:0];
    wire enb_s[15:0];
genvar i;
    generate
    for(i=0;i<16;i=i+1) begin : block_name
    blk_mem_gen_0 sparse (
        .clka(clk),    // input wire clka
        .ena(ena[i]),      // input wire ena
        .wea(wea[i]),      // input wire [0 : 0] wea
        .addra(addra[i]),  // input wire [3 : 0] addra
        .dina(dina[i]),    // input wire [5 : 0] dina
        .douta(douta[i]),  // output wire [5 : 0] douta
        .clkb(clk),    // input wire clkb
        .enb(enb[i]),      // input wire enb
        .web(web[i]),      // input wire [0 : 0] web
        .addrb(addrb[i]),  // input wire [3 : 0] addrb
        .dinb(dinb[i]),    // input wire [5 : 0] dinb
        .doutb(doutb[i])  // output wire [5 : 0] doutb
      );
    end
    endgenerate
    
    
    wire enable_sr_flip;
    wire index,index1;
    sr_flip sd(clk,done&&(!done_add),enable_sr_flip,index,index1 );
    
    wire ena_pp[15:0], enb_pp[0:15],ena_pp_addition[15:0],ena_pp_summation[15:0];
    reg ena_pp_sum[15:0],wea_pp_sum[15:0];
    reg [9:0]addra_pp_sum[15:0];
     reg enb_pp_sum[15:0],web_pp_sum[15:0];
       reg [9:0]addrb_pp_sum[15:0];
    wire wea_pp[15:0],web_pp[0:15],wea_pp_addition[15:0],wea_pp_summation[15:0];
    wire [9:0]addra_pp[15:0],addrb_pp[0:15],addra_pp_addition[15:0],addra_pp_summation[15:0];
    wire [63:0] dina_pp[15:0],dinb_pp[0:15];
    wire [63:0] douta_pp[15:0],doutb_pp[0:15];
     wire [63:0] dina_pp_addition[15:0];
     wire [63:0] dina_pp_summation[15:0];
     reg [63:0] dina_pp_sum[15:0];
     reg [63:0] dinb_pp_sum[15:0];
    /*
   clka : IN STD_LOGIC;
       rsta : IN STD_LOGIC;
       ena : IN STD_LOGIC;
       wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
       addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
       dina : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
       douta : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
       clkb : IN STD_LOGIC;
       rstb : IN STD_LOGIC;
       enb : IN STD_LOGIC;
       web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
       addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
       dinb : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
       doutb : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    
    */
     genvar j;
     generate 
     for(j=0;j<16;j=j+1) begin : partial 
  blk_mem_gen_1 partial_product (
      clk, 
     // (!op1_enable),
          ena_pp[j],
          wea_pp[j] ,
          addra_pp[j],
          dina_pp[j] ,
          douta_pp[j],
          clk,
       //   (!op1_enable),
          enb_pp[j],
          web_pp[j],
          addrb_pp[j],
          dinb_pp[j],
           doutb_pp[j]
      );
    end
    endgenerate
    wire [63:0] mul_out[15:0];
 /* (* keep = "true" *) */  wire  [10:0] count_up ;
    wire done1;
matrix INIT_BLOCK (clk,reset,gamma,row,wea_a[0],wea_a[1],wea_a[2],wea_a[3],wea_a[4],wea_a[5],wea_a[6],wea_a[7],wea_a[8],wea_a[9],wea_a[10],wea_a[11],wea_a[12],wea_a[13],wea_a[14],wea_a[15],web_a[0],web_a[1],web_a[2],web_a[3],web_a[4],web_a[5],web_a[6],web_a[7],web_a[8],web_a[9],web_a[10],web_a[11],web_a[12],web_a[13],web_a[14],web_a[15],ena_a[0],ena_a[1],ena_a[2],ena_a[3],ena_a[4],ena_a[5],ena_a[6],ena_a[7],ena_a[8],ena_a[9],ena_a[10],ena_a[11],ena_a[12],ena_a[13],ena_a[14],ena_a[15],enb_a[0],enb_a[1],enb_a[2],enb_a[3],enb_a[4],enb_a[5],enb_a[6],enb_a[7],enb_a[8],enb_a[9],enb_a[10],enb_a[11],enb_a[12],enb_a[13],enb_a[14],enb_a[15],addra_a[0],addra_a[1],addra_a[2],addra_a[3],addra_a[4],addra_a[5],addra_a[6],addra_a[7],addra_a[8],addra_a[9],addra_a[10],addra_a[11],addra_a[12],addra_a[13],addra_a[14],addra_a[15],addrb_a[0],addrb_a[1],addrb_a[2],addrb_a[3],addrb_a[4],addrb_a[5],addrb_a[6],addrb_a[7],addrb_a[8],addrb_a[9],addrb_a[10],addrb_a[11],addrb_a[12],addrb_a[13],addrb_a[14],addrb_a[15],dina[0],dina[1],dina[2],dina[3],dina[4],dina[5],dina[6],dina[7],dina[8],dina[9],dina[10],dina[11],dina[12],dina[13],dina[14],dina[15],dinb[0],dinb[1],dinb[2],dinb[3],dinb[4],dinb[5],dinb[6],dinb[7],dinb[8],dinb[9],dinb[10],dinb[11],dinb[12],dinb[13],dinb[14],dinb[15],done1);//active high reset
MUL_BLOCK MUL_BLK0(clk,done&&(!done_mul),gamma,wea_s[0],ena_s[0],addra_s[0],douta[0],mul_out[0],web_s[0],enb_s[0],addrb_s[0] ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK0(clk,done&&(!done_add),mul_out[0],doutb[0],wea_pp_addition[0],ena_pp_addition[0],addra_pp_addition[0],dina_pp_addition[0],douta_pp[0],index,index1,enable_sr_flip);//active low reset
MUL_BLOCK MUL_BLK1(clk,done&&(!done_mul),gamma,wea_s[1],ena_s[1],addra_s[1],douta[1],mul_out[1],web_s[1],enb_s[1],addrb_s[1]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK1(clk,done&&(!done_add),mul_out[1],doutb[1],wea_pp_addition[1],ena_pp_addition[1],addra_pp_addition[1],dina_pp_addition[1],douta_pp[1],index,index1);//active low reset
MUL_BLOCK MUL_BLK2(clk,done&&(!done_mul),gamma,wea_s[2],ena_s[2],addra_s[2],douta[2],mul_out[2],web_s[2],enb_s[2],addrb_s[2]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK2(clk,done&&(!done_add),mul_out[2],doutb[2],wea_pp_addition[2],ena_pp_addition[2],addra_pp_addition[2],dina_pp_addition[2],douta_pp[2],index,index1);//active low reset
MUL_BLOCK MUL_BLK3(clk,done&&(!done_mul),gamma,wea_s[3],ena_s[3],addra_s[3],douta[3],mul_out[3],web_s[3],enb_s[3],addrb_s[3]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK3(clk,done&&(!done_add),mul_out[3],doutb[3],wea_pp_addition[3],ena_pp_addition[3],addra_pp_addition[3],dina_pp_addition[3],douta_pp[3],index,index1);//active low reset
MUL_BLOCK MUL_BLK4(clk,done&&(!done_mul),gamma,wea_s[4],ena_s[4],addra_s[4],douta[4],mul_out[4],web_s[4],enb_s[4],addrb_s[4]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK4(clk,done&&(!done_add),mul_out[4],doutb[4],wea_pp_addition[4],ena_pp_addition[4],addra_pp_addition[4],dina_pp_addition[4],douta_pp[4],index,index1);//active low reset
MUL_BLOCK MUL_BLK5(clk,done&&(!done_mul),gamma,wea_s[5],ena_s[5],addra_s[5],douta[5],mul_out[5],web_s[5],enb_s[5],addrb_s[5]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK5(clk,done&&(!done_add),mul_out[5],doutb[5],wea_pp_addition[5],ena_pp_addition[5],addra_pp_addition[5],dina_pp_addition[5],douta_pp[5],index,index1);//active low reset
MUL_BLOCK MUL_BLK6(clk,done&&(!done_mul),gamma,wea_s[6],ena_s[6],addra_s[6],douta[6],mul_out[6],web_s[6],enb_s[6],addrb_s[6]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK6(clk,done&&(!done_add),mul_out[6],doutb[6],wea_pp_addition[6],ena_pp_addition[6],addra_pp_addition[6],dina_pp_addition[6],douta_pp[6],index,index1);//active low reset
MUL_BLOCK MUL_BLK7(clk,done&&(!done_mul),gamma,wea_s[7],ena_s[7],addra_s[7],douta[7],mul_out[7],web_s[7],enb_s[7],addrb_s[7]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK7(clk,done&&(!done_add),mul_out[7],doutb[7],wea_pp_addition[7],ena_pp_addition[7],addra_pp_addition[7],dina_pp_addition[7],douta_pp[7],index,index1);//active low reset
MUL_BLOCK MUL_BLK8(clk,done&&(!done_mul),gamma,wea_s[8],ena_s[8],addra_s[8],douta[8],mul_out[8],web_s[8],enb_s[8],addrb_s[8] ,reset   );//active low reset
ADDITION_BLOCK ADD_BLK8(clk,done&&(!done_add),mul_out[8],doutb[8],wea_pp_addition[8],ena_pp_addition[8],addra_pp_addition[8],dina_pp_addition[8],douta_pp[8],index,index1);//active low reset
MUL_BLOCK MUL_BLK9(clk,done&&(!done_mul),gamma,wea_s[9],ena_s[9],addra_s[9],douta[9],mul_out[9],web_s[9],enb_s[9],addrb_s[9]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK9(clk,done&&(!done_add),mul_out[9],doutb[9],wea_pp_addition[9],ena_pp_addition[9],addra_pp_addition[9],dina_pp_addition[9],douta_pp[9],index,index1);//active low reset
MUL_BLOCK MUL_BLK10(clk,done&&(!done_mul),gamma,wea_s[10],ena_s[10],addra_s[10],douta[10],mul_out[10],web_s[10],enb_s[10],addrb_s[10]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK10(clk,done&&(!done_add),mul_out[10],doutb[10],wea_pp_addition[10],ena_pp_addition[10],addra_pp_addition[10],dina_pp_addition[10],douta_pp[10],index,index1);//active low reset
MUL_BLOCK MUL_BLK11(clk,done&&(!done_mul),gamma,wea_s[11],ena_s[11],addra_s[11],douta[11],mul_out[11],web_s[11],enb_s[11],addrb_s[11]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK11(clk,done&&(!done_add),mul_out[11],doutb[11],wea_pp_addition[11],ena_pp_addition[11],addra_pp_addition[11],dina_pp_addition[11],douta_pp[11],index,index1);//active low reset
MUL_BLOCK MUL_BLK12(clk,done&&(!done_mul),gamma,wea_s[12],ena_s[12],addra_s[12],douta[12],mul_out[12],web_s[12],enb_s[12],addrb_s[12]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK12(clk,done&&(!done_add),mul_out[12],doutb[12],wea_pp_addition[12],ena_pp_addition[12],addra_pp_addition[12],dina_pp_addition[12],douta_pp[12],index,index1);//active low reset
MUL_BLOCK MUL_BLK13(clk,done&&(!done_mul),gamma,wea_s[13],ena_s[13],addra_s[13],douta[13],mul_out[13],web_s[13],enb_s[13],addrb_s[13]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK13(clk,done&&(!done_add),mul_out[13],doutb[13],wea_pp_addition[13],ena_pp_addition[13],addra_pp_addition[13],dina_pp_addition[13],douta_pp[13],index,index1);//active low reset
MUL_BLOCK MUL_BLK14(clk,done&&(!done_mul),gamma,wea_s[14],ena_s[14],addra_s[14],douta[14],mul_out[14],web_s[14],enb_s[14],addrb_s[14]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK14(clk,done&&(!done_add),mul_out[14],doutb[14],wea_pp_addition[14],ena_pp_addition[14],addra_pp_addition[14],dina_pp_addition[14],douta_pp[14],index,index1);//active low reset
MUL_BLOCK MUL_BLK15(clk,done&&(!done_mul),gamma,wea_s[15],ena_s[15],addra_s[15],douta[15],mul_out[15],web_s[15],enb_s[15],addrb_s[15]  ,reset  );//active low reset
ADDITION_BLOCK ADD_BLK15(clk,done&&(!done_add),mul_out[15],doutb[15],wea_pp_addition[15],ena_pp_addition[15],addra_pp_addition[15],dina_pp_addition[15],douta_pp[15],index,index1);//active low reset

reg varibale_for_resetting_bram;
counter_up cup(reset||reset1,clk,(wea_pp_addition[0])&&(!done_add),count_up);
/*counter_up(reset,clk,enable,count);*/

always@(posedge clk) begin
if(reset) begin
done<=0;
end
else begin
done<=done1;
end

end

always@(posedge clk) begin
if(reset) begin
done_add=0;
done_mul=0;
end

else begin
if(count_up==560)begin
done_add=1;
done_mul=1;
end
else if(count_up==559) begin
done_add=0;
done_mul=1;
end
else begin
done_add=0;
done_mul=0;
end
end


end


assign addra[0]=done?addra_s[0]:addra_a[0];
assign addra[1]=done?addra_s[1]:addra_a[1];
assign addra[2]=done?addra_s[2]:addra_a[2];
assign addra[3]=done?addra_s[3]:addra_a[3];
assign addra[4]=done?addra_s[4]:addra_a[4];
assign addra[5]=done?addra_s[5]:addra_a[5];
assign addra[6]=done?addra_s[6]:addra_a[6];
assign addra[7]=done?addra_s[7]:addra_a[7];
assign addra[8]=done?addra_s[8]:addra_a[8];
assign addra[9]=done?addra_s[9]:addra_a[9];
assign addra[10]=done?addra_s[10]:addra_a[10];
assign addra[11]=done?addra_s[11]:addra_a[11];
assign addra[12]=done?addra_s[12]:addra_a[12];
assign addra[13]=done?addra_s[13]:addra_a[13];
assign addra[14]=done?addra_s[14]:addra_a[14];
assign addra[15]=done?addra_s[15]:addra_a[15];
assign addrb[0]=done?addrb_s[0]:addrb_a[0];
assign addrb[1]=done?addrb_s[1]:addrb_a[1];
assign addrb[2]=done?addrb_s[2]:addrb_a[2];
assign addrb[3]=done?addrb_s[3]:addrb_a[3];
assign addrb[4]=done?addrb_s[4]:addrb_a[4];
assign addrb[5]=done?addrb_s[5]:addrb_a[5];
assign addrb[6]=done?addrb_s[6]:addrb_a[6];
assign addrb[7]=done?addrb_s[7]:addrb_a[7];
assign addrb[8]=done?addrb_s[8]:addrb_a[8];
assign addrb[9]=done?addrb_s[9]:addrb_a[9];
assign addrb[10]=done?addrb_s[10]:addrb_a[10];
assign addrb[11]=done?addrb_s[11]:addrb_a[11];
assign addrb[12]=done?addrb_s[12]:addrb_a[12];
assign addrb[13]=done?addrb_s[13]:addrb_a[13];
assign addrb[14]=done?addrb_s[14]:addrb_a[14];
assign addrb[15]=done?addrb_s[15]:addrb_a[15];
assign ena[0]=done?ena_s[0]:ena_a[0];
assign enb[0]=done?enb_s[0]:enb_a[0];
assign web[0]=done?web_s[0]:web_a[0];
assign wea[0]=done?wea_s[0]:wea_a[0];
assign ena[1]=done?ena_s[1]:ena_a[1];
assign enb[1]=done?enb_s[1]:enb_a[1];
assign web[1]=done?web_s[1]:web_a[1];
assign wea[1]=done?wea_s[1]:wea_a[1];
assign ena[2]=done?ena_s[2]:ena_a[2];
assign enb[2]=done?enb_s[2]:enb_a[2];
assign web[2]=done?web_s[2]:web_a[2];
assign wea[2]=done?wea_s[2]:wea_a[2];
assign ena[3]=done?ena_s[3]:ena_a[3];
assign enb[3]=done?enb_s[3]:enb_a[3];
assign web[3]=done?web_s[3]:web_a[3];
assign wea[3]=done?wea_s[3]:wea_a[3];
assign ena[4]=done?ena_s[4]:ena_a[4];
assign enb[4]=done?enb_s[4]:enb_a[4];
assign web[4]=done?web_s[4]:web_a[4];
assign wea[4]=done?wea_s[4]:wea_a[4];
assign ena[5]=done?ena_s[5]:ena_a[5];
assign enb[5]=done?enb_s[5]:enb_a[5];
assign web[5]=done?web_s[5]:web_a[5];
assign wea[5]=done?wea_s[5]:wea_a[5];
assign ena[6]=done?ena_s[6]:ena_a[6];
assign enb[6]=done?enb_s[6]:enb_a[6];
assign web[6]=done?web_s[6]:web_a[6];
assign wea[6]=done?wea_s[6]:wea_a[6];
assign ena[7]=done?ena_s[7]:ena_a[7];
assign enb[7]=done?enb_s[7]:enb_a[7];
assign web[7]=done?web_s[7]:web_a[7];
assign wea[7]=done?wea_s[7]:wea_a[7];
assign ena[8]=done?ena_s[8]:ena_a[8];
assign enb[8]=done?enb_s[8]:enb_a[8];
assign web[8]=done?web_s[8]:web_a[8];
assign wea[8]=done?wea_s[8]:wea_a[8];
assign ena[9]=done?ena_s[9]:ena_a[9];
assign enb[9]=done?enb_s[9]:enb_a[9];
assign web[9]=done?web_s[9]:web_a[9];
assign wea[9]=done?wea_s[9]:wea_a[9];
assign ena[10]=done?ena_s[10]:ena_a[10];
assign enb[10]=done?enb_s[10]:enb_a[10];
assign web[10]=done?web_s[10]:web_a[10];
assign wea[10]=done?wea_s[10]:wea_a[10];
assign ena[11]=done?ena_s[11]:ena_a[11];
assign enb[11]=done?enb_s[11]:enb_a[11];
assign web[11]=done?web_s[11]:web_a[11];
assign wea[11]=done?wea_s[11]:wea_a[11];
assign ena[12]=done?ena_s[12]:ena_a[12];
assign enb[12]=done?enb_s[12]:enb_a[12];
assign web[12]=done?web_s[12]:web_a[12];
assign wea[12]=done?wea_s[12]:wea_a[12];
assign ena[13]=done?ena_s[13]:ena_a[13];
assign enb[13]=done?enb_s[13]:enb_a[13];
assign web[13]=done?web_s[13]:web_a[13];
assign wea[13]=done?wea_s[13]:wea_a[13];
assign ena[14]=done?ena_s[14]:ena_a[14];
assign enb[14]=done?enb_s[14]:enb_a[14];
assign web[14]=done?web_s[14]:web_a[14];
assign wea[14]=done?wea_s[14]:wea_a[14];
assign ena[15]=done?ena_s[15]:ena_a[15];
assign enb[15]=done?enb_s[15]:enb_a[15];
assign web[15]=done?web_s[15]:web_a[15];
assign wea[15]=done?wea_s[15]:wea_a[15]; 

assign ena_pp[0]=done_add?ena_pp_summation[0]:ena_pp_addition[0];
assign addra_pp[0]=done_add?addra_pp_summation[0]:addra_pp_addition[0];
assign wea_pp[0]=done_add?wea_pp_summation[0]:wea_pp_addition[0];
assign ena_pp[1]=done_add?ena_pp_summation[1]:ena_pp_addition[1];
assign addra_pp[1]=done_add?addra_pp_summation[1]:addra_pp_addition[1];
assign wea_pp[1]=done_add?wea_pp_summation[1]:wea_pp_addition[1];
assign ena_pp[2]=done_add?ena_pp_summation[2]:ena_pp_addition[2];
assign addra_pp[2]=done_add?addra_pp_summation[2]:addra_pp_addition[2];
assign wea_pp[2]=done_add?wea_pp_summation[2]:wea_pp_addition[2];
assign ena_pp[3]=done_add?ena_pp_summation[3]:ena_pp_addition[3];
assign addra_pp[3]=done_add?addra_pp_summation[3]:addra_pp_addition[3];
assign wea_pp[3]=done_add?wea_pp_summation[3]:wea_pp_addition[3];
assign ena_pp[4]=done_add?ena_pp_summation[4]:ena_pp_addition[4];
assign addra_pp[4]=done_add?addra_pp_summation[4]:addra_pp_addition[4];
assign wea_pp[4]=done_add?wea_pp_summation[4]:wea_pp_addition[4];
assign ena_pp[5]=done_add?ena_pp_summation[5]:ena_pp_addition[5];
assign addra_pp[5]=done_add?addra_pp_summation[5]:addra_pp_addition[5];
assign wea_pp[5]=done_add?wea_pp_summation[5]:wea_pp_addition[5];
assign ena_pp[6]=done_add?ena_pp_summation[6]:ena_pp_addition[6];
assign addra_pp[6]=done_add?addra_pp_summation[6]:addra_pp_addition[6];
assign wea_pp[6]=done_add?wea_pp_summation[6]:wea_pp_addition[6];
assign ena_pp[7]=done_add?ena_pp_summation[7]:ena_pp_addition[7];
assign addra_pp[7]=done_add?addra_pp_summation[7]:addra_pp_addition[7];
assign wea_pp[7]=done_add?wea_pp_summation[7]:wea_pp_addition[7];
assign ena_pp[8]=done_add?ena_pp_summation[8]:ena_pp_addition[8];
assign addra_pp[8]=done_add?addra_pp_summation[8]:addra_pp_addition[8];
assign wea_pp[8]=done_add?wea_pp_summation[8]:wea_pp_addition[8];
assign ena_pp[9]=done_add?ena_pp_summation[9]:ena_pp_addition[9];
assign addra_pp[9]=done_add?addra_pp_summation[9]:addra_pp_addition[9];
assign wea_pp[9]=done_add?wea_pp_summation[9]:wea_pp_addition[9];
assign ena_pp[10]=done_add?ena_pp_summation[10]:ena_pp_addition[10];
assign addra_pp[10]=done_add?addra_pp_summation[10]:addra_pp_addition[10];
assign wea_pp[10]=done_add?wea_pp_summation[10]:wea_pp_addition[10];
assign ena_pp[11]=done_add?ena_pp_summation[11]:ena_pp_addition[11];
assign addra_pp[11]=done_add?addra_pp_summation[11]:addra_pp_addition[11];
assign wea_pp[11]=done_add?wea_pp_summation[11]:wea_pp_addition[11];
assign ena_pp[12]=done_add?ena_pp_summation[12]:ena_pp_addition[12];
assign addra_pp[12]=done_add?addra_pp_summation[12]:addra_pp_addition[12];
assign wea_pp[12]=done_add?wea_pp_summation[12]:wea_pp_addition[12];
assign ena_pp[13]=done_add?ena_pp_summation[13]:ena_pp_addition[13];
assign addra_pp[13]=done_add?addra_pp_summation[13]:addra_pp_addition[13];
assign wea_pp[13]=done_add?wea_pp_summation[13]:wea_pp_addition[13];
assign ena_pp[14]=done_add?ena_pp_summation[14]:ena_pp_addition[14];
assign addra_pp[14]=done_add?addra_pp_summation[14]:addra_pp_addition[14];
assign wea_pp[14]=done_add?wea_pp_summation[14]:wea_pp_addition[14];
assign ena_pp[15]=done_add?ena_pp_summation[15]:ena_pp_addition[15];
assign addra_pp[15]=done_add?addra_pp_summation[15]:addra_pp_addition[15];
assign wea_pp[15]=done_add?wea_pp_summation[15]:wea_pp_addition[15];

assign dina_pp[0]=done_add?dina_pp_summation[0]:dina_pp_addition[0];
assign dina_pp[1]=done_add?dina_pp_summation[1]:dina_pp_addition[1];
assign dina_pp[2]=done_add?dina_pp_summation[2]:dina_pp_addition[2];
assign dina_pp[3]=done_add?dina_pp_summation[3]:dina_pp_addition[3];
assign dina_pp[4]=done_add?dina_pp_summation[4]:dina_pp_addition[4];
assign dina_pp[5]=done_add?dina_pp_summation[5]:dina_pp_addition[5];
assign dina_pp[6]=done_add?dina_pp_summation[6]:dina_pp_addition[6];
assign dina_pp[7]=done_add?dina_pp_summation[7]:dina_pp_addition[7];
assign dina_pp[8]=done_add?dina_pp_summation[8]:dina_pp_addition[8];
assign dina_pp[9]=done_add?dina_pp_summation[9]:dina_pp_addition[9];
assign dina_pp[10]=done_add?dina_pp_summation[10]:dina_pp_addition[10];
assign dina_pp[11]=done_add?dina_pp_summation[11]:dina_pp_addition[11];
assign dina_pp[12]=done_add?dina_pp_summation[12]:dina_pp_addition[12];
assign dina_pp[13]=done_add?dina_pp_summation[13]:dina_pp_addition[13];
assign dina_pp[14]=done_add?dina_pp_summation[14]:dina_pp_addition[14];
assign dina_pp[15]=done_add?dina_pp_summation[15]:dina_pp_addition[15];


wire [10:0]count_even_sum,count_odd_sum;
//wire[10:0]count_even_sum1,
wire [10:0]count_odd_sum1;
always@(posedge clk)
begin
if(!done_add)
state=0;
else
state=next_state;
end


always@(state,done_add,count_even_sum) begin
if(!done_add)
begin
next_state=`esta1;
end
else
case(state)//something
`esta1: begin next_state=`esta2; end
`esta2:begin next_state=`esta3; end
`esta3:begin   next_state=`esta4; end
`esta4:begin   next_state=`esta5;end
`esta5:begin next_state=`esta6; end
`esta6:begin   next_state=`esta7; end
`esta7:begin   next_state=`esta8; end
`esta8:begin   if(count_even_sum==558)next_state=`esta13; else next_state=`esta9; end
`esta9:begin   if(count_even_sum==558)next_state=`esta13; else next_state=`esta8; end
`esta11:begin   next_state=`esta12; end
//`state11:begin   next_state=`esta12; end
`esta12:begin   next_state=`esta13; end
`esta13:begin   next_state=`esta25; end
`esta25: begin next_state=`esta14; end

`esta14:begin   next_state=`esta15; end
`esta15:begin   next_state=`esta16; end
`esta16:begin   next_state=`esta17; end
`esta17:begin   next_state=`esta18; end
`esta18:begin   next_state=`esta20; end
`esta20:begin   if(count_even_sum==558)next_state=`esta21;else next_state=`esta24;  end
`esta24: begin if(count_even_sum==558)next_state=`esta21;else next_state=`esta20; end
`esta21: begin next_state=`esta21; end
default: begin  next_state=`esta1; end

endcase

end

/*ENTITY c_addsub_0 IS
  PORT (
    A : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    S : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );*/
reg [63:0]A[15:0];
reg [63:0]B[15:0];
wire [63:0]S[15:0];

  
integer l,m,n,o,p;
assign ena_pp_summation[0]=ena_pp_sum[0];
assign wea_pp_summation[0]=wea_pp_sum[0];
assign addra_pp_summation[0]=addra_pp_sum[0];
assign ena_pp_summation[1]=ena_pp_sum[1];
assign wea_pp_summation[1]=wea_pp_sum[1];
assign addra_pp_summation[1]=addra_pp_sum[1];
assign ena_pp_summation[2]=ena_pp_sum[2];
assign wea_pp_summation[2]=wea_pp_sum[2];
assign addra_pp_summation[2]=addra_pp_sum[2];
assign ena_pp_summation[3]=ena_pp_sum[3];
assign wea_pp_summation[3]=wea_pp_sum[3];
assign addra_pp_summation[3]=addra_pp_sum[3];
assign ena_pp_summation[4]=ena_pp_sum[4];
assign wea_pp_summation[4]=wea_pp_sum[4];
assign addra_pp_summation[4]=addra_pp_sum[4];
assign ena_pp_summation[5]=ena_pp_sum[5];
assign wea_pp_summation[5]=wea_pp_sum[5];
assign addra_pp_summation[5]=addra_pp_sum[5];
assign ena_pp_summation[6]=ena_pp_sum[6];
assign wea_pp_summation[6]=wea_pp_sum[6];
assign addra_pp_summation[6]=addra_pp_sum[6];
assign ena_pp_summation[7]=ena_pp_sum[7];
assign wea_pp_summation[7]=wea_pp_sum[7];
assign addra_pp_summation[7]=addra_pp_sum[7];
assign ena_pp_summation[8]=ena_pp_sum[8];
assign wea_pp_summation[8]=wea_pp_sum[8];
assign addra_pp_summation[8]=addra_pp_sum[8];
assign ena_pp_summation[9]=ena_pp_sum[9];
assign wea_pp_summation[9]=wea_pp_sum[9];
assign addra_pp_summation[9]=addra_pp_sum[9];
assign ena_pp_summation[10]=ena_pp_sum[10];
assign wea_pp_summation[10]=wea_pp_sum[10];
assign addra_pp_summation[10]=addra_pp_sum[10];
assign ena_pp_summation[11]=ena_pp_sum[11];
assign wea_pp_summation[11]=wea_pp_sum[11];
assign addra_pp_summation[11]=addra_pp_sum[11];
assign ena_pp_summation[12]=ena_pp_sum[12];
assign wea_pp_summation[12]=wea_pp_sum[12];
assign addra_pp_summation[12]=addra_pp_sum[12];
assign ena_pp_summation[13]=ena_pp_sum[13];
assign wea_pp_summation[13]=wea_pp_sum[13];
assign addra_pp_summation[13]=addra_pp_sum[13];
assign ena_pp_summation[14]=ena_pp_sum[14];
assign wea_pp_summation[14]=wea_pp_sum[14];
assign addra_pp_summation[14]=addra_pp_sum[14];
assign ena_pp_summation[15]=ena_pp_sum[15];
assign wea_pp_summation[15]=wea_pp_sum[15];
assign addra_pp_summation[15]=addra_pp_sum[15];
assign enb_pp[0]=enb_pp_sum[0];
assign web_pp[0]=web_pp_sum[0];
assign addrb_pp[0]=addrb_pp_sum[0];
assign enb_pp[1]=enb_pp_sum[1];
assign web_pp[1]=web_pp_sum[1];
assign addrb_pp[1]=addrb_pp_sum[1];
assign enb_pp[2]=enb_pp_sum[2];
assign web_pp[2]=web_pp_sum[2];
assign addrb_pp[2]=addrb_pp_sum[2];
assign enb_pp[3]=enb_pp_sum[3];
assign web_pp[3]=web_pp_sum[3];
assign addrb_pp[3]=addrb_pp_sum[3];
assign enb_pp[4]=enb_pp_sum[4];
assign web_pp[4]=web_pp_sum[4];
assign addrb_pp[4]=addrb_pp_sum[4];
assign enb_pp[5]=enb_pp_sum[5];
assign web_pp[5]=web_pp_sum[5];
assign addrb_pp[5]=addrb_pp_sum[5];
assign enb_pp[6]=enb_pp_sum[6];
assign web_pp[6]=web_pp_sum[6];
assign addrb_pp[6]=addrb_pp_sum[6];
assign enb_pp[7]=enb_pp_sum[7];
assign web_pp[7]=web_pp_sum[7];
assign addrb_pp[7]=addrb_pp_sum[7];
assign enb_pp[8]=enb_pp_sum[8];
assign web_pp[8]=web_pp_sum[8];
assign addrb_pp[8]=addrb_pp_sum[8];
assign enb_pp[9]=enb_pp_sum[9];
assign web_pp[9]=web_pp_sum[9];
assign addrb_pp[9]=addrb_pp_sum[9];
assign enb_pp[10]=enb_pp_sum[10];
assign web_pp[10]=web_pp_sum[10];
assign addrb_pp[10]=addrb_pp_sum[10];
assign enb_pp[11]=enb_pp_sum[11];
assign web_pp[11]=web_pp_sum[11];
assign addrb_pp[11]=addrb_pp_sum[11];
assign enb_pp[12]=enb_pp_sum[12];
assign web_pp[12]=web_pp_sum[12];
assign addrb_pp[12]=addrb_pp_sum[12];
assign enb_pp[13]=enb_pp_sum[13];
assign web_pp[13]=web_pp_sum[13];
assign addrb_pp[13]=addrb_pp_sum[13];
assign enb_pp[14]=enb_pp_sum[14];
assign web_pp[14]=web_pp_sum[14];
assign addrb_pp[14]=addrb_pp_sum[14];
assign enb_pp[15]=enb_pp_sum[15];
assign web_pp[15]=web_pp_sum[15];
assign addrb_pp[15]=addrb_pp_sum[15];


assign dina_pp_summation[0]= 0;
assign dina_pp_summation[1]= 0;
assign dina_pp_summation[2]= 0;
assign dina_pp_summation[3]= 0;
assign dina_pp_summation[4]= 0;
assign dina_pp_summation[5]= 0;
assign dina_pp_summation[6]= 0;
assign dina_pp_summation[7]= 0;
assign dina_pp_summation[8]= 0;
assign dina_pp_summation[9]= 0;
assign dina_pp_summation[10]= 0;
assign dina_pp_summation[11]= 0;
assign dina_pp_summation[12]= 0;
assign dina_pp_summation[13]= 0;
assign dina_pp_summation[14]= 0;
assign dina_pp_summation[15]= 0;

assign dinb_pp[0]=dinb_pp_sum[0];
assign dinb_pp[1]=dinb_pp_sum[1];
assign dinb_pp[2]=dinb_pp_sum[2];
assign dinb_pp[3]=dinb_pp_sum[3];
assign dinb_pp[4]=dinb_pp_sum[4];
assign dinb_pp[5]=dinb_pp_sum[5];
assign dinb_pp[6]=dinb_pp_sum[6];
assign dinb_pp[7]=dinb_pp_sum[7];
assign dinb_pp[8]=dinb_pp_sum[8];
assign dinb_pp[9]=dinb_pp_sum[9];
assign dinb_pp[10]=dinb_pp_sum[10];
assign dinb_pp[11]=dinb_pp_sum[11];
assign dinb_pp[12]=dinb_pp_sum[12];
assign dinb_pp[13]=dinb_pp_sum[13];
assign dinb_pp[14]=dinb_pp_sum[14];
assign dinb_pp[15]=dinb_pp_sum[15];
reg enable_output,enable_output_odd;
adder_output add_op1(op1,clk,enable_output,douta_pp[0],douta_pp[1],douta_pp[2],douta_pp[3],douta_pp[4],douta_pp[5],douta_pp[6],douta_pp[7],douta_pp[8],douta_pp[9],douta_pp[10],douta_pp[11],douta_pp[12],douta_pp[13],douta_pp[14],douta_pp[15]);
adder_output add_op2(op2,clk,enable_output,doutb_pp[0],doutb_pp[1],doutb_pp[2],doutb_pp[3],doutb_pp[4],doutb_pp[5],doutb_pp[6],doutb_pp[7],doutb_pp[8],doutb_pp[9],doutb_pp[10],doutb_pp[11],doutb_pp[12],doutb_pp[13],doutb_pp[14],doutb_pp[15]);


reg enable;
reg reset_even;
reg [63:0] sums [29:0],sums_[29:0];

//reg enable_reset_even;
counter_even ce_op1((!done_add)||(reset_even),clk,enable,count_even_sum);
//counter_even ce_op1_reset((!done_add),clk,enable_reset_even,count_even_sum1);

always@(state,done_add,count_even_sum)
begin
if(!done_add)
begin
//varibale_for_resetting_bram=1;
reset1=0;
reset_even=0;
//enable_reset_even=0;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=0;
addra_pp_sum[l]=0;
dina_pp_sum[l]=0;
end
enable_output=0;
enable=0;

op1_enable=0;
end
else begin
case(state)
`esta1: begin
//varibale_for_resetting_bram=0;
reset_even=0;
//enable_reset_even=0;
reset1=0;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=0;
addra_pp_sum[l]=0;
dina_pp_sum[l]=0;
end
enable_output=0;
enable=0;

op1_enable=0;

end

`esta2: begin
reset_even=0;
reset1=0;
//enable_reset_even=0;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=0;
enable=1;

op1_enable=0;
end
`esta3: begin
reset_even=0;
reset1=0;
//enable_reset_even=0;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=0;
enable=1;

op1_enable=0;
end

`esta4: begin
reset_even=0;
reset1=0;
//enable_reset_even=0;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=1;

op1_enable=0;
end

`esta5: begin
reset_even=0;
reset1=0;
//enable_reset_even=0;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=1;

op1_enable=0;
end
`esta6: begin
reset_even=0;
reset1=0;
//enable_reset_even=0;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=1;

op1_enable=0;
end

`esta7: begin
reset_even=0;
reset1=0;
//enable_reset_even=0;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=1;

op1_enable=0;
end

`esta8: begin
reset_even=0;
reset1=0;
//enable_reset_even=0;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=1;

op1_enable=1;
end


`esta9: begin
reset_even=0;
reset1=0;
//enable_reset_even=0;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=1;

op1_enable=1;
end



`esta13: begin
reset_even=1;
reset1=0;
//enable_reset_even=1;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=1;
addra_pp_sum[l]=0;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=0;

op1_enable=1;
end

`esta25: begin
reset_even=0;
reset1=0;
//enable_reset_even=1;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=1;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=1;

op1_enable=1;
end


`esta14: begin
reset1=0;
reset_even=0;
//enable_reset_even=1;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=1;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=1;

op1_enable=1;
end
`esta15: begin
reset1=0;
reset_even=0;
//enable_reset_even=1;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=1;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=1;

op1_enable=1;
end

`esta16: begin
reset1=0;
reset_even=0;
//enable_reset_even=1;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=1;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=1;

op1_enable=1;
end

`esta17: begin
reset1=0;
reset_even=0;
//enable_reset_even=1;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=1;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=1;
enable=1;

op1_enable=1;
end

`esta18: begin
reset1=0;
reset_even=0;
//enable_reset_even=1;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=1;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=0;
enable=1;

op1_enable=0;
end


`esta20: begin
reset1=0;
reset_even=0;
//enable_reset_even=1;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=1;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=0;
enable=1;

op1_enable=0;

end
`esta24: begin
reset1=0;
reset_even=0;
//enable_reset_even=1;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=1;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end
enable_output=0;
enable=1;

op1_enable=0;

end
`esta21: begin
reset1=1;
reset_even=0;
//enable_reset_even=0;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=1;
addra_pp_sum[l]=0;
dina_pp_sum[l]=0;
end
enable_output=0;
enable=0;

op1_enable=0;

end

default: begin
enable_output=0;
reset_even=0;
//enable_reset_even=0;
reset1=0;
op1_enable=1;
enable=1;
for(l=0;l<16;l=l+1) begin
wea_pp_sum[l]=0;
ena_pp_sum[l]=1;
addra_pp_sum[l]=count_even_sum;
dina_pp_sum[l]=0;
end

end
endcase

end


end






reg enable_odd;
//reg enable_odd_reset;
//reg [10:0] count_odd_sum;
counter_odd co_op2((!done_add)||(reset_even),clk,enable,count_odd_sum);
//counter_odd co_op2_reset(!done_add,clk,enable_reset_even,count_odd_sum1);
/*counter_odd(reset,clk,enable,count);*/

//OP2'S OUTPUT

always@(state,done_add,count_odd_sum)
begin
if(!done_add)
begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=0;
addrb_pp_sum[m]=0;
dinb_pp_sum[m]=0;
end
//enable_output_odd=0;
//enable_odd=0;

//=0;
end
else begin
case(state)
`esta1: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=0;
addrb_pp_sum[m]=0;
dinb_pp_sum[m]=0;
end
//enable_output_odd=0;
//enable_odd=0;

//=0;

end

`esta2: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=0;
//enable_odd=1;

//=0;
end
`esta3: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=0;
//enable_odd=1;

//=0;
end

`esta4: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=1;
//enable_odd=1;

//=0;
end

`esta5: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=1;
//enable_odd=1;

//=0;
end
`esta6: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=1;
//enable_odd=1;

//=0;
end

`esta7: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=1;
//enable_odd=1;

//=0;
end

`esta8: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=1;
//enable_odd=1;

//=1;
end

`esta13: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=0;
dinb_pp_sum[m]=0;
end
//enable_output_odd=1;
//enable_odd=0;

//=1;
end

`esta25: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=1;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=1;
//enable_odd=0;

//=1;
end


`esta14: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=1;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=1;
//enable_odd=0;

//=1;
end
`esta15: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=1;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=1;
//enable_odd=0;

//=1;
end

`esta16: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=1;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=1;
//enable_odd=0;

//=1;
end

`esta17: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=1;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=1;
//enable_odd=0;

//=1;
end

`esta18: begin
//=0;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=1;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=0;
//enable_odd=0;

//=1;
end


`esta20: begin
//=1;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=1;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=0;
//enable_odd=0;

//=0;

end
`esta24: begin
//=1;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=1;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end
//enable_output_odd=0;
//enable_odd=0;

//=0;

end

`esta21: begin
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=0;
dinb_pp_sum[m]=0;
end
//enable_output_odd=0;
//enable_odd=0;

//=0;


end


default: begin

//enable_output_odd=0;
//=0;
//=1;
//enable_odd=1;
for(m=0;m<16;m=m+1) begin
web_pp_sum[m]=0;
enb_pp_sum[m]=1;
addrb_pp_sum[m]=count_odd_sum;
dinb_pp_sum[m]=0;
end

end
endcase

end


end










endmodule
