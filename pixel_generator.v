`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:53 09/12/2016 
// Design Name: 
// Module Name:    pixel_generator 
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
module pixel_generator(
	input clk,
	input [9:0] pixel_counter,
	input [9:0] line_counter,
	input active,
	output reg [7:0] color
    );
	 
	 reg [7:0] checkerboard;
	 reg [30:0] seed; 
	 initial seed = 17;
	 
	 wire [12:0] char_addr;
	 wire [7:0] glyph;
	 wire [7:0] creative;
	 wire [9:0] glyph_address;
	 wire pixel_en;
	 wire [15:0] glyph_bits;
	 
	 compute_char_addr compute_char_add(pixel_counter, line_counter, char_addr);
	//this is just for filler until we have the real thing
    text_buffer text_buf(.clka(clk), .addra(char_addr[12:0]), .douta({glyph, creative}), .wea(1'b0),
								  .dina(16'd0), .clkb(clk), .web(1'b0), .dinb(16'd0), .addrb(13'd0));
	 compute_glyph_addr compute_glyph_add(glyph, line_counter, glyph_address);
	 //again, just for filler
	 glyph_buffer glyph_buf(.clka(clk), .addra(glyph_address), .douta(glyph_bits), .wea(1'b0),
									.dina(16'd0), .clkb(clk), .web(1'b0), .dinb(16'd0), .addrb(10'd0));
	 extract_pixel extract_pix(glyph_bits, pixel_counter, line_counter, pixel_en);
	 
	 //light up the right pixel
	 always @ (posedge clk) begin
		 if (active) begin
			if (!pixel_en) begin
				color = creative;
			end
			else begin
				color = 8'b00000000;
			end
		 end
		 else begin
			color = 8'b00000000;
		 end
	 end
	 
	 /*

	 always @ (posedge clk) begin
		//random
		seed = {seed[22:0], (seed[30:23] ^ seed[27:20])};
		
		//checkerboard
		checkerboard = line_counter[5]^pixel_counter[5];
		
		if (active) begin
			case (sw) 
					8'b00000000: color = 8'b00000000;
					8'b10000000: color = line_counter[7:0];
					8'b01000000: color = checkerboard;
					8'b00100000: color = 8'b11100000;
					8'b00010000: color = 8'b00011100;
					8'b00001000: color = 8'b00000011;
					8'b00000100: color = 8'b10101010;
					8'b00000010: color = 8'b01010101;
					8'b00000001: color = pixel_counter[7:0];
					default: color = seed[7:0]; //random
			endcase	
		end
		else begin
			color = 8'b00000000;
		end
	 end
	 */


endmodule
