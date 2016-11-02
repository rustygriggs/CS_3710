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
module Memory_Top(
	input clk,
	input [14:0] vga_addr,
	input [15:0] proc_data_in,
	input w,
	input [14:0] addr,
	output [15:0] vga_data,
	output [15:0] proc_data_out
    );
	
	//Add this to block_ram1 module when generating it again: //synthesis attribute box_type <block_ram1> "black_box"
	
	Block_Ram1 Block_Ram(.clka(clk), .addra(vga_addr[14:0]), .douta(vga_data[15:0]), .wea(1'b0),
		  					  .dina(16'd0), .clkb(clk), .web(w), .dinb(proc_data_in), .addrb(addr), .doutb(proc_data_out));

endmodule
