`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:57 11/17/2016 
// Design Name: 
// Module Name:    Keyboard 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Keyboard(
	input key_data,
	input key_clk,
	output [7:0] data_wire
    );

	reg [3:0] data_count;
	reg [7:0] data_curr;
	reg [7:0] data_prev;
	reg [7:0] data_reg;
	
	reg shift;
	reg [7:0] ascii;
	
	initial begin
	data_reg <= 8'hf0;
	data_count <= 4'h1;
	data_curr <= 8'hf0;
	data_prev <= 8'hf0;
	shift <= 1'b0;
	ascii <= 8'b0;
	end
	
	always@(posedge key_clk) begin
	
		case(data_count)
		1:;
		2: data_curr[0] <= key_data;
		3: data_curr[1] <= key_data;
		4: data_curr[2] <= key_data;
		5: data_curr[3] <= key_data;
		6: data_curr[4] <= key_data;
		7: data_curr[5] <= key_data;
		8: data_curr[6] <= key_data;
		9: data_curr[7] <= key_data;
		10: ;
		11: begin
			data_reg <= data_curr;
			data_prev <= data_reg;
		end
		endcase
		
		if (data_count <= 10)
			data_count <= data_count + 1'b1;
		else if (data_count == 11)
			data_count <= 1;
	end
	
	assign data_wire = ascii;//{7'd0, flag};
	
	// Enables shift for keys
	
	always@(posedge key_clk) begin
		if (data_reg == 8'h12 || data_reg == 8'h59) begin
			if (data_prev == 8'hF0)
				shift <= 1'b0;
			else
				shift <= 1'b1;
		end
	end
	
	always@(*) begin
	
		if (data_prev == 8'hF0)
			ascii = 8'hFF;
		else begin
					
			if (shift == 1'b0) begin
				if (data_reg == 8'h0E)//`
					ascii = 8'h60;
				else if (data_reg == 8'h16)//1
					ascii = 8'h31;
				else if (data_reg == 8'h1E)//2
					ascii = 8'h32;
				else if (data_reg == 8'h26)//3
					ascii = 8'h33;
				else if (data_reg == 8'h25)//4
					ascii = 8'h34;
				else if (data_reg == 8'h2E)//5
					ascii = 8'h35;
				else if (data_reg == 8'h36)//6
					ascii = 8'h36;
				else if (data_reg == 8'h3D)//7
					ascii = 8'h37;
				else if (data_reg == 8'h3E)//8
					ascii = 8'h38;
				else if (data_reg == 8'h46)//9
					ascii = 8'h39;
				else if (data_reg == 8'h45)//0
					ascii = 8'h30;
				else if (data_reg == 8'h4E)//-
					ascii = 8'h2D;
				else if (data_reg == 8'h55)//=
					ascii = 8'h3D;
				
				else if (data_reg == 8'h15)//q
					ascii = 8'h71;
				else if (data_reg == 8'h1D)//w
					ascii = 8'h77;
				else if (data_reg == 8'h24)//e
					ascii = 8'h65;
				else if (data_reg == 8'h2D)//r
					ascii = 8'h72;
				else if (data_reg == 8'h2C)//t
					ascii = 8'h74;
				else if (data_reg == 8'h35)//y
					ascii = 8'h79;
				else if (data_reg == 8'h3C)//u
					ascii = 8'h75;
				else if (data_reg == 8'h43)//i
					ascii = 8'h69;
				else if (data_reg == 8'h44)//o
					ascii = 8'h6F;
				else if (data_reg == 8'h4D)//p
					ascii = 8'h70;
				else if (data_reg == 8'h54)//[
					ascii = 8'h5B;
				else if (data_reg == 8'h5B)//]
					ascii = 8'h5D;
				else if (data_reg == 8'h5D)//\
					ascii = 8'h5C;
				
				else if (data_reg == 8'h1C)//a
					ascii = 8'h61;
				else if (data_reg == 8'h1B)//s
					ascii = 8'h73;
				else if (data_reg == 8'h23)//d
					ascii = 8'h64;
				else if (data_reg == 8'h2B)//f
					ascii = 8'h66;
				else if (data_reg == 8'h34)//g
					ascii = 8'h67;
				else if (data_reg == 8'h33)//h
					ascii = 8'h68;
				else if (data_reg == 8'h3B)//j
					ascii = 8'h6A;
				else if (data_reg == 8'h42)//k
					ascii = 8'h6B;
				else if (data_reg == 8'h4B)//l
					ascii = 8'h6C;
				else if (data_reg == 8'h4C)//;
					ascii = 8'h3B;
				else if (data_reg == 8'h52)//'
					ascii = 8'h27;
				
				else if (data_reg == 8'h1A)//z
					ascii = 8'h7A;
				else if (data_reg == 8'h22)//x
					ascii = 8'h78;
				else if (data_reg == 8'h21)//c
					ascii = 8'h63;
				else if (data_reg == 8'h2A)//v
					ascii = 8'h76;
				else if (data_reg == 8'h32)//b
					ascii = 8'h62;
				else if (data_reg == 8'h31)//n
					ascii = 8'h6E;
				else if (data_reg == 8'h3A)//m
					ascii = 8'h6D;
				else if (data_reg == 8'h41)//,
					ascii = 8'h2C;
				else if (data_reg == 8'h49)//.
					ascii = 8'h2E;
				else if (data_reg == 8'h4A)///
					ascii = 8'h2F;
				
				else if (data_reg == 8'h29)//Space
					ascii = 8'h20;
				else if (data_reg == 8'h66)//Back
					ascii = 8'h8;
				else if (data_reg == 8'h0D)//TAB
					ascii = 8'h9;
				else if (data_reg == 8'h5A)//Enter
					ascii = 8'hD;
				
				else if (data_reg == 8'hF0)//End bit for signal/release of key
					ascii = 8'hFF;
				else
					ascii = 8'hFF;
			end		
			else begin
				if (data_reg == 8'h0E)//~
					ascii = 8'h7E;
				else if (data_reg == 8'h16)//!
					ascii = 8'h21;
				else if (data_reg == 8'h1E)//@
					ascii = 8'h40;
				else if (data_reg == 8'h26)//#
					ascii = 8'h23;
				else if (data_reg == 8'h25)//$
					ascii = 8'h24;
				else if (data_reg == 8'h2E)//%
					ascii = 8'h25;
				else if (data_reg == 8'h36)//^
					ascii = 8'h5E;
				else if (data_reg == 8'h3D)//&
					ascii = 8'h26;
				else if (data_reg == 8'h3E)//*
					ascii = 8'h2A;
				else if (data_reg == 8'h46)//(
					ascii = 8'h28;
				else if (data_reg == 8'h45)//)
					ascii = 8'h29;
				else if (data_reg == 8'h4E)//_
					ascii = 8'h5F;
				else if (data_reg == 8'h55)//+
					ascii = 8'h2B;
				
				else if (data_reg == 8'h15)//Q
					ascii = 8'h51;
				else if (data_reg == 8'h1D)//W
					ascii = 8'h57;
				else if (data_reg == 8'h24)//E
					ascii = 8'h45;
				else if (data_reg == 8'h2D)//R
					ascii = 8'h52;
				else if (data_reg == 8'h2C)//T
					ascii = 8'h54;
				else if (data_reg == 8'h35)//Y
					ascii = 8'h59;
				else if (data_reg == 8'h3C)//U
					ascii = 8'h55;
				else if (data_reg == 8'h43)//I
					ascii = 8'h49;
				else if (data_reg == 8'h44)//O
					ascii = 8'h4F;
				else if (data_reg == 8'h4D)//P
					ascii = 8'h50;
				else if (data_reg == 8'h54)//{
					ascii = 8'h7B;
				else if (data_reg == 8'h5B)//}
					ascii = 8'h7D;
				else if (data_reg == 8'h5D)//|
					ascii = 8'h7C;
				
				else if (data_reg == 8'h1C)//A
					ascii = 8'h41;
				else if (data_reg == 8'h1B)//S
					ascii = 8'h53;
				else if (data_reg == 8'h23)//D
					ascii = 8'h44;
				else if (data_reg == 8'h2B)//F
					ascii = 8'h46;
				else if (data_reg == 8'h34)//G
					ascii = 8'h47;
				else if (data_reg == 8'h33)//H
					ascii = 8'h48;
				else if (data_reg == 8'h3B)//J
					ascii = 8'h4A;
				else if (data_reg == 8'h42)//K
					ascii = 8'h4B;
				else if (data_reg == 8'h4B)//L
					ascii = 8'h4C;
				else if (data_reg == 8'h4C)//:
					ascii = 8'h3A;
				else if (data_reg == 8'h52)//"
					ascii = 8'h22;
				
				else if (data_reg == 8'h1A)//Z
					ascii = 8'h5A;
				else if (data_reg == 8'h22)//X
					ascii = 8'h58;
				else if (data_reg == 8'h21)//C
					ascii = 8'h43;
				else if (data_reg == 8'h2A)//V
					ascii = 8'h56;
				else if (data_reg == 8'h32)//B
					ascii = 8'h42;
				else if (data_reg == 8'h31)//N
					ascii = 8'h4E;
				else if (data_reg == 8'h3A)//M
					ascii = 8'h4D;
				else if (data_reg == 8'h41)//<
					ascii = 8'h3C;
				else if (data_reg == 8'h49)//>
					ascii = 8'h3E;
				else if (data_reg == 8'h4A)//?
					ascii = 8'h3F;
				
				else if (data_reg == 8'h29)//Space
					ascii = 8'h20;
				else if (data_reg == 8'h66)//Back
					ascii = 8'h8;
				else if (data_reg == 8'h0D)//TAB
					ascii = 8'h9;
				else if (data_reg == 8'h5A)//Enter
					ascii = 8'hD;
				
				else if (data_reg == 8'hF0)//End bit for signal/release of key
					ascii = 8'hFF;
				else
					ascii = 8'hFF;
			end
		end
	end
	
endmodule
