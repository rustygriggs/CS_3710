`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:03:45 09/12/2016 
// Design Name: 
// Module Name:    VGA_top 
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
module VGA_Top(
		input clk,
		input [15:0] vga_data,
		output h_sync,
		output v_sync,
		output [7:0] color_out,
		output [14:0] vga_address
		);
		
		wire [9:0] line_counter;
		wire [1:0] pixel_state;
		wire [9:0] pixel_counter;
		wire active;
		wire [7:0] color_intermediate;		
		
		VGA_Counters Count(clk, pixel_counter, line_counter, pixel_state, active);
		
		Pixel_Generator PixelGen(clk, pixel_state, pixel_counter, line_counter[8:0], active, vga_data, color_intermediate, vga_address);
		
		VGA_Output VGA_Out(clk, pixel_counter, line_counter, pixel_state, color_intermediate, h_sync, v_sync, color_out);

		
endmodule
