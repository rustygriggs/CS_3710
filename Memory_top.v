`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:29 10/19/2016 
// Design Name: 
// Module Name:    Memory_top 
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
module Memory_top(
	input clk,
	input vga_addr,
	output vga_data
    );
	
	block_ram1 block_RAM_1(.clka(clk), .addra(vga_addr[15:0]), .douta(vga_data), .wea(1'b0),
		  					  .dina(16'd0), .clkb(clk), .web(1'b0), .dinb(16'd0), .addrb(13'd0));

endmodule
