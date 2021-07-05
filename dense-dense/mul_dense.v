`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2021 18:50:35
// Design Name: 
// Module Name: mul_dense
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


module mul_dense(clk, rst, datain1, datain2, dataout1, dataout2, valid);

    input clk, rst;
    input [31:0] datain1, datain2;      //Data from off chip comes in through these ports.
    
    output [63:0] dataout1, dataout2;
    output reg valid;                   //If HIGH, then the output ports contain a valid number (Matrix product)
    
    wire sclk;                          //Value goes high once ever 28 clock cycles
    reg sclk_rst;                   
    
    slow_clk S_clk(clk, sclk_rst, sclk);    //Module implementing this slower clock

    wire [63:0] P [0:1];
    reg [31:0] constant1, constant2;
    
    mult_gen_0 M0(.CLK(clk), .A(constant1), .B(datain1), .P(P[0]));         //Multiplier IP
    mult_gen_0 M1(.CLK(clk), .A(constant1), .B(datain2), .P(P[1]));
    
    reg bp;
    wire [63:0] adder1, adder2;
    
    c_addsub_0 A1(.CLK(clk), .A(dataout1), .B(P[0]), .BYPASS(bp), .S(adder1));      //Adder IP
    c_addsub_0 A2(.CLK(clk), .A(dataout2), .B(P[1]), .BYPASS(bp), .S(adder2));
    
    reg we_res;
    reg [8:0] addr_resa1, addr_resb1;
    wire [63:0] res_wire1, res_wire2;

    //BRAMs that store partial sums
    blk_mem_gen_res B_res1(.clka(clk), .addra(addr_resa1), .dina(adder1), .wea(we_res), 
                         .clkb(clk), .addrb(addr_resb1), .doutb(dataout1), .enb(we_res));
                         
    blk_mem_gen_res B_res2(.clka(clk), .addra(addr_resa1), .dina(adder2), .wea(we_res), 
                         .clkb(clk), .addrb(addr_resb1), .doutb(dataout2), .enb(we_res));
    
    
    wire [560:0] counter;
    reg counter_rst;
    shift_reg SR(clk, counter_rst, counter);        //Shift register, all control signals are based on this
    
    
    reg [31:0] add_counter;
    
    wire L, G, E;                           //Output of comparator, Less than, Greater than, Equal to

    comparator c(sclk, add_counter, 32'd559, L, G, E);  //Comparator

    always @ (posedge clk)
    if(!rst)
    begin
        sclk_rst <= 0;
        counter_rst <= 0;
        bp <= 0;
        we_res <= 0;
        addr_resa1 <= 0;
        addr_resb1 <= 9;
        add_counter <= 0;
        valid <= 0;
    end
    else
    begin
        counter_rst <= 1;
        sclk_rst <= 1;
        
        if(counter[1])
        begin
            constant1 <= datain1;
            constant2 <= datain2;
        end
        
        if(counter[281])
            constant1 <= constant2; 
        
        if(counter[14])
            we_res <= 1;

        if(we_res)
        begin
            if(addr_resa1 == 279)
                addr_resa1 <= 0;
            else
                if(!counter[14])
                    addr_resa1 <= addr_resa1 + 1;

            if(addr_resb1 == 279)
                addr_resb1 <= 0;
            else
                if(!counter[5])
                    addr_resb1 <= addr_resb1 + 1;

            
            if(counter[289] || counter[8])
                valid <= 0;
            
            if((counter[290] || counter[9]) && bp)
                valid <= 1;
            
            if(counter[287] || counter[6])
            begin
                
                if(E)
                begin
                    bp <= 1;
                    valid <= 1;
                    add_counter <= 0;
                end
                
                if(L)
                begin
                    bp <= 0;
                    valid <= 0;
                    add_counter <= add_counter + 1;
                end

            end

        end
    end
	
endmodule

