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
		input externalClk,
		output Hsync,
		output Vsync,
		output [7:0] colorOut
    );
		// Cloock Stuff
		IBUFG pad_to_clock_logic(.I(externalClk), .O(internalClk));
		BUFG clock_logic_to_clk(.I(internalClk), .O(clk));

		wire [15:0] VGA_Data, VGA_Addr;

		VGA_top VGA_module(clk, VGA_Data, Hsync, Vsync, colorOut, VGA_Addr);

endmodule
