`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:35:24 10/19/2016 
// Design Name: 
// Module Name:    ComputerV1 
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
module ComputerV1(
		input external_clk,
		output h_sync,
		output v_sync,
		output [7:0] color_out
    );
		wire internal_clk;
		wire clk;
		
		// Clock Stuff
		IBUFG pad_to_clock_logic(.I(external_clk), .O(internal_clk));
		BUFG clock_logic_to_clk(.I(internal_clk), .O(clk));

		wire [15:0] vga_data, proc_data_in, proc_data_out;
		wire [14:0] vga_addr, memory_addr;

		VGA_Top VGA_Module(clk, vga_data, h_sync, v_sync, color_out, vga_addr);
		
		Memory_Top Memory_Module(clk, vga_addr, proc_data_in, w, memory_addr, vga_data, proc_data_out);
		
		Core Core_Module(clk, proc_data_out, proc_data_in, memory_addr, w);
endmodule
