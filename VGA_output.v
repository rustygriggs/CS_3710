`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:46:41 09/12/2016 
// Design Name: 
// Module Name:    VGA_output 
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
module VGA_output(
	input clk,
	input [9:0] pixel_counter,
	input [9:0] line_counter,
	input [1:0] pixel_state,
	input active,
	input [7:0] colorIn,
	output reg Hsync,
	output reg Vsync,
	output reg [7:0] colorOut
    );
	 
//	 parameter HSYNC_START = 703;
	 parameter HSYNC_START = 655;
	 parameter HSYNC_END = 751;

//	 parameter VSYNC_START = 522;
	 parameter VSYNC_START = 489;
	 parameter VSYNC_END = 491;
	 parameter PIXEL_ST_MAX = 3;

	always @ (posedge clk) begin
			if (pixel_counter >= HSYNC_START && pixel_counter < HSYNC_END) //check this number
				Hsync = 1'b0;
			else Hsync = 1'b1;
			
			if (line_counter >= VSYNC_START && line_counter < VSYNC_END) // check this number
				Vsync = 1'b0;
			else Vsync = 1'b1;
			
			if (pixel_state == PIXEL_ST_MAX) 
				colorOut = colorIn;
	end
	
endmodule
