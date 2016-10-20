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
module VGA_top(
		input clk,
		input [15:0] vgaData,
		output Hsync,
		output Vsync,
		output [7:0] colorOut,
		output [15:0] vgaAddress
		);
		
		wire [9:0] line_counter;
		wire [1:0] pixel_state;
		wire [9:0] pixel_counter;
		wire active;
		wire [7:0] colorIntermediate;		
		
		VGA_counters count(clk, pixel_counter, line_counter, pixel_state, active);
		pixel_generator pixelGen(clk, pixel_state, pixel_counter, line_counter, active, vgaData, colorIntermediate, vgaAddress);
		VGA_output VGA_out(clk, pixel_counter, line_counter, pixel_state, active, colorIntermediate, Hsync, Vsync, colorOut);

		
endmodule
