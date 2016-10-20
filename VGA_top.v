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
		input externalClk,
		input [7:0] sw,
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
		
		IBUFG pad_to_clock_logic(.I(externalClk), .O(internalClk));
		BUFG clock_logic_to_clk(.I(internalClk), .O(clk));
		
		
		VGA_counters count(clk, pixel_counter, line_counter, pixel_state, active);
		pixel_generator pixelGen(clk, pixel_counter, line_counter, active, sw, colorIntermediate);
		VGA_output VGA_out(clk, pixel_counter, line_counter, pixel_state, active, colorIntermediate, Hsync, Vsync, colorOut);

		
endmodule
