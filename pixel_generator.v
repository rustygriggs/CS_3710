`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:53 09/12/2016 
// Design Name: 
// Module Name:    pixel_generator 
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
module Pixel_Generator(
	input clk,
	input [1:0] pixel_state,
	input [9:0] pixel_counter,
	input [8:0] line_counter,
	input active,
	input [15:0] vga_data,
	output reg [7:0] color,
	output [14:0] vga_addr
    );
	 
	 reg [7:0] checkerboard;
	 reg [30:0] seed; 
	 initial seed = 17;
	 
	 wire [14:0] char_addr;
	 wire [7:0] glyph;
	 wire [7:0] creative;
	 wire [14:0] glyph_addr;
	 wire pixel_en;
	 wire [15:0] glyph_bits;
	 
	 Compute_Char_Addr Compute_Char_Add(pixel_counter[9:3], line_counter[8:3], char_addr);	 
	 
	 Compute_Glyph_Addr Compute_Glyph_Add(glyph, line_counter[2:1], glyph_addr);
	 
	 Extract_Pixel Extract_Pix(glyph_bits, pixel_counter[2:0], line_counter[0], pixel_en);

	 assign vga_addr = (pixel_state == 2'b0 ? char_addr : glyph_addr);
	 assign glyph = vga_data[7:0];
	 //assign creative = vga_data[15:8];
	 assign glyph_bits = vga_data;

	 /*always@(posedge clk)
	 begin
		if(pixel_state == 0) begin
			vga_addr = char_addr;		
		end
		else if(pixel_state == 1) begin
		   glyph = vga_data[7:0];
			creative = vga_data[15:8];
			vga_addr = glyph_addr;
		end
		else if (pixel_state == 2) begin
			glyph_bits = vga_data;
		end
		
	 end*/
	 	 
	 //light up the right pixel
	 always @ (posedge clk) begin
		 if (active) begin
			if (!pixel_en) begin
			//	color = creative;
				color = 8'b11111111;
			end
			else begin
				color = 8'b00000000;
			end
		 end
		 else begin
			color = 8'b00000000;
		 end
	 end


endmodule
