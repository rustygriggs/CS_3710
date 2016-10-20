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
	input [1:0] pixel_state,
	input [9:0] pixel_counter,
	input [9:0] line_counter,
	input active,
	input [15:0] vga_data,
	output reg [7:0] color,
	output [14:0] vga_addr
    );
	 
	 reg [7:0] checkerboard;
	 reg [30:0] seed; 
	 initial seed = 17;
	 
	 wire [14:0] char_addr;
	 wire [7:0] glyph;
	 wire [7:0] creative;
	 wire [14:0] glyph_addr;
	 wire pixel_en;
	 wire [15:0] glyph_bits;
	 
	 compute_char_addr compute_char_add(pixel_counter, line_counter, char_addr);	 
	 
	 compute_glyph_addr compute_glyph_add(glyph, line_counter, glyph_addr);
	 
	 extract_pixel extract_pix(glyph_bits, pixel_counter, line_counter, pixel_en);

	 assign vga_addr = (pixel_state == 3'b0 ? char_addr : glyph_addr);
	 assign glyph = vga_data[7:0];
	 assign creative = vga_data[15:8];
	 assign glyph_bits = vga_data;

	 /*always@(posedge clk)
	 begin
		if(pixel_state == 0) begin
			vga_addr = char_addr;		
		end
		else if(pixel_state == 1) begin
		   glyph = vga_data[7:0];
			creative = vga_data[15:8];
			vga_addr = glyph_addr;
		end
		else if (pixel_state == 2) begin
			glyph_bits = vga_data;
		end
		
	 end*/
	 
	 
	//this is just for filler until we have the real thing
    //text_buffer text_buf(.clka(clk), .addra(char_addr[12:0]), .douta({glyph, creative}), .wea(1'b0),
		//						  .dina(16'd0), .clkb(clk), .web(1'b0), .dinb(16'd0), .addrb(13'd0));
	 
	 //again, just for filler
	 //glyph_buffer glyph_buf(.clka(clk), .addra(glyph_address), .douta(glyph_bits), .wea(1'b0),
	//								.dina(16'd0), .clkb(clk), .web(1'b0), .dinb(16'd0), .addrb(10'd0));
	 
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


endmodule
