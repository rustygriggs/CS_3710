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
module VGA_Output(
	input clk,
	input [9:0] pixel_counter,
	input [9:0] line_counter,
	input [1:0] pixel_state,
	input [7:0] color_in,
	output reg h_sync,
	output reg v_sync,
	output reg [7:0] color_out
    );
	 
//	 parameter HSYNC_START = 703;
	 parameter H_SYNC_START = 655;
	 parameter H_SYNC_END = 751;

//	 parameter VSYNC_START = 522;
	 parameter V_SYNC_START = 489;
	 parameter V_SYNC_END = 491;
	 parameter PIXEL_ST_MAX = 3;

	always @ (posedge clk) begin
			if (pixel_counter >= H_SYNC_START && pixel_counter < H_SYNC_END) //check this number
				h_sync = 1'b0;
			else h_sync = 1'b1;
			
			if (line_counter >= V_SYNC_START && line_counter < V_SYNC_END) // check this number
				v_sync = 1'b0;
			else v_sync = 1'b1;
			
			if (pixel_state == PIXEL_ST_MAX) 
				color_out = color_in;
	end
	
endmodule
