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
	input ps2_data,
	input ps2_clk,
	input [15:0]data_out,
	output [15:0]data_in,
	output [14:0]mem_addr,
	output write
    );
	 
	//parameter resume = 1'd1;
	//reg [15:0]dispatch_data_in; 
	//wire dispatch_w;
	//reg [14:0]dispatch_mem_addr = 15'h605;
	
	wire [15:0]core_data_in;
	wire core_w;
	wire [14:0]core_mem_addr;
	wire [15:0]core_data_out;
	
	wire [7:0]char;
	
	Core Core_Module(clk, core_data_out, core_data_in, core_mem_addr, core_w);
	 
	Keyboard Keyboard_Module(ps2_data, ps2_clk, char); 
	
	assign mem_addr = core_mem_addr;
	assign write = core_w;
	assign data_in = core_data_in;
	
	assign core_data_out = (core_mem_addr == 15'h7FFF) ? {8'h0, char} : data_out;
	
	
	//always@(posedge clk)
	//begin
	//	if(!resume)
	//	begin
	//		if(dispatch_mem_addr != 16'h2400)
	//			dispatch_mem_addr <= dispatch_mem_addr + 15'd1;	
				
	//		dispatch_data_in <= {8'd0, char};
			
		//if enter received change resume to 1
		//resume <= 1;
		//end
	//end

endmodule
