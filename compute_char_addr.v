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
module compute_char_addr(
	input [9:0] pixel_counter,
	input [9:0] line_counter,
	output [14:0] char_addr
    );
	
	assign char_addr = {2'd0, line_counter[8:3], pixel_counter[9:3]} + 11'h480;

endmodule
