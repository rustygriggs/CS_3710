`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:51:52 09/19/2016 
// Design Name: 
// Module Name:    compute_char_addr 
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
module Compute_Char_Addr(
	input [6:0] pixel_counter,
	input [5:0] line_counter,
	output [14:0] char_addr
    );
	 
	parameter CHAR_OFFSET = 11'h600;
	
	assign char_addr = {2'd0, line_counter, pixel_counter} + CHAR_OFFSET;

endmodule
