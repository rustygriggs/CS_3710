`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:26:00 09/19/2016 
// Design Name: 
// Module Name:    compute_glyph_addr 
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
module compute_glyph_addr(
	input [7:0] glyph,
	input [1:0] line_counter,
	output [14:0] glyph_addr
    );
	 
	 parameter GLYPH_OFFSET = 11'h400;
	 
	 assign glyph_addr = {5'd0, glyph, line_counter} + GLYPH_OFFSET;

endmodule
