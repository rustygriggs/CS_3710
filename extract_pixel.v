`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:42:47 09/20/2016 
// Design Name: 
// Module Name:    extract_pixel 
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
module extract_pixel(
	input [15:0] glyph_bits,
	input [9:0] pixel_counter,
	input [9:0] line_counter,
	output reg pixel_enable
    );

	//look at last bit of line_counter to find if it's odd or even.
	wire line_odd;
	reg [7:0] result_bits;
	
	initial result_bits = 0;
	
	assign line_odd = line_counter[0] & 1'b1;
	
	always @ (*) begin
		if (line_odd) begin
			result_bits = glyph_bits[7:0];
		end
		else begin
			result_bits = glyph_bits[15:8];
		end
		
		//map the pixel_counter 3 least sig bits to result
		case (pixel_counter[2:0]) 
			0: pixel_enable = result_bits[7];
			1: pixel_enable = result_bits[6];
			2: pixel_enable = result_bits[5];
			3: pixel_enable = result_bits[4];
			4: pixel_enable = result_bits[3];
			5: pixel_enable = result_bits[2];
			6: pixel_enable = result_bits[1];
			7: pixel_enable = result_bits[0];
		endcase
	end
	
endmodule
