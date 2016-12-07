`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:43 10/25/2016 
// Design Name: 
// Module Name:    Dispatch 
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
module Dispatch(
	input clk,
	input ps2_clk,
	input ps2_data,
	input [15:0]data_out,
	input [7:0] sw,
	input btnl,
	output [15:0]data_in,
	output [14:0]mem_addr,
	output write,
	output [3:0] an,
   output [7:0] seg
    );
	
	wire [15:0]core_data_out;
	wire [7:0]keyboard_data;
	wire [15:0]debug_output;
	wire [15:0]data_reg;
	
	Core Core_Module(clk, core_data_out, sw, btnl, data_in, mem_addr, write, debug_output);

	Keyboard keyboard(ps2_clk, ps2_data, keyboard_data);
	
	SevenSeg sseg(clk, data_reg, an, seg[0], seg[1], seg[2], seg[3], seg[4], seg[5], seg[6], seg[7]);
	
	assign core_data_out = (mem_addr == 15'h7FFF) ? {8'h0, keyboard_data} : data_out;
	
	assign data_reg = sw == 8'd0 ? {8'd0, keyboard_data} : debug_output;
	
endmodule
