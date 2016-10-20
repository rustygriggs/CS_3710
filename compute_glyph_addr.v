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
	input [9:0] line_counter,
	output [9:0] glyph_addr
    );
	 
	 assign glyph_addr = {glyph, line_counter[2:1]};

endmodule
