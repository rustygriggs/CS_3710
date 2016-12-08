`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:15:53 11/17/2016 
// Design Name: 
// Module Name:    SevenSeg 
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
module SevenSeg(
	input clk,
	input [15:0] data_reg,
	output [3:0] en,
   output a, b, c, d, e, f, g, dp
    );

	// Clock management

	//7-seg display
	
	// Digit change count
	reg [15:0] dig_count;
	initial dig_count = 0;
	
	// Digit changer
	always@(posedge clk)
	begin
			dig_count <= dig_count + 1'b1;
	end
	
	// Temporary variables to hold 7-seg data	
	reg [7:0] temp;
	reg [3:0] dig_temp;
	reg [3:0] en_temp;
	
	initial temp = 0;
	initial dig_temp = 0;
	initial en_temp = 0;
	
	// Digit selector
	always@(posedge clk)
	begin
		case(dig_count[15:14])
		2'b00: begin
			dig_temp = data_reg[3:0];
			en_temp = 4'b1110;
		end
		2'b01: begin
			dig_temp = data_reg[7:4];
			en_temp = 4'b1101;
		end
		2'b10: begin
			dig_temp = data_reg[11:8];
			en_temp = 4'b1011;
		end
		2'b11: begin
			dig_temp = data_reg[15:12];
			en_temp = 4'b0111;
		end
		
		endcase
	end
	
	assign en = en_temp;
	
	// Digit producer
	always@(*)
	begin
		case(dig_temp)
			4'h0 : temp = 8'b00000011;
			4'h1 : temp = 8'b10011111;
			4'h2 : temp = 8'b00100101;
			4'h3 : temp = 8'b00001101;
			4'h4 : temp = 8'b10011001;
			4'h5 : temp = 8'b01001001;
			4'h6 : temp = 8'b01000001;
			4'h7 : temp = 8'b00011111;
			4'h8 : temp = 8'b00000001;
			4'h9 : temp = 8'b00001001;
			4'hA : temp = 8'b00010001;
			4'hB : temp = 8'b11000001;
			4'hC : temp = 8'b01100011;
			4'hD : temp = 8'b10000101;
			4'hE : temp = 8'b01100001;
			4'hF : temp = 8'b01110001;
			default : temp = 8'b11111101;
		endcase
	end
	
	assign {a,b,c,d,e,f,g,dp} = temp;


endmodule
