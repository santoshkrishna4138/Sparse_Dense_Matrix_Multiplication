`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2021 13:48:33
// Design Name: 
// Module Name: mul_new_COO
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


module mul_sparse(clk, rst, datain1, datain2, dataout1, dataout2 ,addrext, valid, zeros);

    input clk, rst;
    input [31:0] datain1, datain2;      //Input data i.e dense matrix values row-wise. 
                                        //Ex: If the first row of the dense matrix is being received then the 1st and 2nd
                                        // elements of the 1st row will come in though datain1 and datain2 respectively
                                        // Then the 3rd and 4th element of the same row and so on
    
    output [9:0] addrext;               //Address sent to the external device that stores the dense matrix.
                                        //Only the row number is sent (0 to 559).
                                        //If the value sent is 5, then it expects the external device to send values from row 
                                        //number 5 (starting from index 0) 
    
    output [63:0] dataout1, dataout2;   //The final matrix product will appear through these ports, similar to the input ports, 
                                        //the values belong to the same row
                                        
    output reg valid, zeros;            //Valid: Only when this pin is HIGH, then the data on the output ports are valid
                                        //Zeros: If all the values of a row in the ouput matrix are zeros, then this pin goes high for 1 clock cycle
    
    wire sclk;                          //Value goes high once ever 28 clock cycles
    reg sclk_rst;                   
    
    slow_clk S_clk(clk, sclk_rst, sclk);    //Module implementing this slower clock
	
	wire [31:0] row_wire, col_wire;
    reg [13:0] addrsp;
    reg [13:0] addrrow;
    wire [31:0] sparse;
    assign addrext = col_wire[9:0];
    
    blk_mem_gen_sparse spv_ram(.clka(clk), .addra(addrsp), .dina(32'b0), .douta(sparse), .wea(1'b0));       //BRAM storing sparse values
    blk_mem_gen_col col_ram(.clka(clk), .addra(addrsp), .dina(32'b0), .douta(col_wire),  .wea(1'b0));       //BRAM storing column values
    blk_mem_gen_COO row_ram(.clka(clk), .addra(addrrow), .dina(32'b0), .douta(row_wire), .wea(1'b0));       //BRAM storing row values
    
    
    wire [63:0] P [0:1];
    
    mult_gen_0 M0(.CLK(clk), .A(sparse), .B(datain1), .P(P[0]));        //Multiplier IP
    mult_gen_0 M1(.CLK(clk), .A(sparse), .B(datain2), .P(P[1]));
    
    
    reg bp;
    wire [63:0] adder1, adder2;
    
    c_addsub_0 A1(.CLK(clk), .A(dataout1), .B(P[0]), .BYPASS(bp), .S(adder1));      //Adder IP
    c_addsub_0 A2(.CLK(clk), .A(dataout2), .B(P[1]), .BYPASS(bp), .S(adder2));
    
    
    reg we_res;
    reg [8:0] addr_resa1, addr_resb1;
    
    //BRAMs that store the partial sums to be added with the next set of partial sums
    blk_mem_gen_res B_res1(.clka(clk), .addra(addr_resa1), .dina(adder1), .wea(we_res), 
                         .clkb(clk), .addrb(addr_resb1), .doutb(dataout1));
                         
    blk_mem_gen_res B_res2(.clka(clk), .addra(addr_resa1), .dina(adder2), .wea(we_res), 
                         .clkb(clk), .addrb(addr_resb1), .doutb(dataout2));
    
    

    reg counter_rst;
    wire [280 -1:0] counter;
    shift_reg R(clk, counter_rst, counter);     //Shift register

    wire L, G, E;
    reg [31:0] row_reg;
    comparator c(sclk, row_reg, row_wire, L, G, E);
    
                    
    always @ (posedge clk)
    if(!rst)
    begin
        sclk_rst <= 0;
        counter_rst <= 0;
        addrsp <= 0;
        addrrow <= 1;
        bp <= 1;
        we_res <= 0;
        addr_resa1 <= 0;
        addr_resb1 <= 0;
        row_reg <= 0;
        valid <= 0;
    end
    else
    begin
        counter_rst <= 1;
        sclk_rst <= 1;
        
        if(counter[276])
            addrsp <= addrsp + 1;
        
        if(counter[11])
            we_res <= 1;
        
        
        if(we_res)
        begin
            if(addr_resa1 == 279)
                addr_resa1 <= 0;
            else
                addr_resa1 <= addr_resa1 + 1;
            
            case(addr_resa1)
                270: addr_resb1 <= 0;
                271: addr_resb1 <= 1;
                272: addr_resb1 <= 2;
                273: addr_resb1 <= 3;
                274: addr_resb1 <= 4;
                275: addr_resb1 <= 5;
                276: addr_resb1 <= 6;
                277: addr_resb1 <= 7;
                278: addr_resb1 <= 8;
                279: addr_resb1 <= 9;
                
                default: addr_resb1 <= addr_resa1 + 10;
            endcase
            
            if(counter[5])
            begin
                row_reg <= row_wire;
                addrrow <= addrrow + 1;
                if(E)
                begin
                    bp <= 0;
                    valid <= 0;
                end
                else
                begin
                    bp <= 1;
                    valid <= 1;
                end
            end
            else
                zeros <= 0;

        end
    end
	
endmodule
