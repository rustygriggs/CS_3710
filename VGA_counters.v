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
module VGA_Counters(
	input clk,
	output reg [9:0] pixel_counter,
	output reg [9:0] line_counter,
	output reg pixel_state,
	output reg active
    );
	 
	 parameter PIXEL_CNT_MAX = 799;
	 parameter LINE_CNT_MAX = 524;
	 parameter ACTIVE_START_PIXELS = 47;
	 parameter ACTIVE_END_PIXELS = 752;
	 parameter ACTIVE_START_LINES = 32;
	 parameter ACTIVE_END_LINES = 492;
 	 parameter PIXEL_ST_MAX = 1;

	 
	 //set active
	 always @(posedge clk) begin
		 
		 if (pixel_state == PIXEL_ST_MAX) begin
			//increment and check pixel counter
			
			if (pixel_counter == PIXEL_CNT_MAX) 
				pixel_counter <= 0;
			else
				pixel_counter <= pixel_counter + 1'b1;
			
			//increment and check line counter
			if (line_counter == LINE_CNT_MAX)
				line_counter <= 0;
			else if (pixel_counter == PIXEL_CNT_MAX)
				line_counter <= line_counter + 1'b1;
				
		 end
				
		if (pixel_counter < 640 && line_counter < 480)
			active <= 1'b1;
		else 
			active <= 1'b0;
			
		//increment pixel state (for 25 MHz)
		 pixel_state <= pixel_state + 1'b1;
	 end

endmodule
