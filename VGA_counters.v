`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:37 09/12/2016 
// Design Name: 
// Module Name:    VGA_counters 
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
module VGA_counters(
	input clk,
	output reg [9:0] pixel_counter,
	output reg [9:0] line_counter,
	output reg [1:0] pixel_state,
	output reg active
    );
	 
	 parameter PIXEL_CNT_MAX = 799;
	 parameter LINE_CNT_MAX = 524;
	 parameter ACTIVE_START_PIXELS = 47;
	 parameter ACTIVE_END_PIXELS = 687;
	 parameter ACTIVE_START_LINES = 32;
	 parameter ACTIVE_END_LINES = 512;
 	 parameter PIXEL_ST_MAX = 3;

	 
	 
	 always @(posedge clk) begin 
		//increment pixel state (for 25 MHz)
		pixel_state = pixel_state + 1'b1;
	 end	
	 
	 //set active
	 always @(posedge clk) begin
		 if (pixel_state == PIXEL_ST_MAX) begin
			//increment and check pixel counter
			
			if (pixel_counter == PIXEL_CNT_MAX) 
				pixel_counter = 0;
			else
				pixel_counter = pixel_counter + 1'b1;
			
			//increment and check line counter
			if (line_counter == LINE_CNT_MAX)
				line_counter = 0;
			else if (pixel_counter == PIXEL_CNT_MAX)
				line_counter = line_counter + 1'b1;
				
		 end
				
//			if (pixel_counter > ACTIVE_START_PIXELS && pixel_counter < ACTIVE_END_PIXELS 
//				 && line_counter > ACTIVE_START_LINES && line_counter < ACTIVE_END_LINES) begin //these numbers might be off by 1
			if (pixel_counter < 640 && line_counter < 480)	begin
				active = 1'b1;
			end
			else 
				active = 1'b0;
	 end

endmodule
