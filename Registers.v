`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:08:43 11/02/2016 
// Design Name: 
// Module Name:    Registers 
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
module Registers(
	input clk,
	input [4:0] register1,
	input [4:0] register2,
	input [15:0] data_in,
	input write,
	output [15:0] r1_data_out,
	output [15:0] r2_data_out
    );

	reg [15:0]reg1 = 0;
	reg [15:0]reg2 = 0;
	reg [15:0]reg3 = 0;
	reg [15:0]reg4 = 0;
	reg [15:0]reg5 = 0;
	reg [15:0]reg6 = 0;
	reg [15:0]reg7 = 0;
	reg [15:0]reg8 = 0;
	reg [15:0]cmp = 0;
	reg [15:0]sp = 0;	
	reg [15:0]rst = 0;
	reg [15:0]rsc = 0;

	parameter R1 = 5'd1, R2 = 5'd2, R3 = 5'd3, R4 = 5'd4, R5 = 5'd5;
	parameter R6 = 5'd6, R7 = 5'd7, R8 = 5'd8, CMP = 5'd9, SP = 5'd10, R_Str = 5'd20, R_Scr = 5'd21;

	assign r1_data_out = register1 == R1 ? reg1:
							register1 == R2 ? reg2:
							register1 == R3 ? reg3:
							register1 == R4 ? reg4:
							register1 == R5 ? reg5:
							register1 == R6 ? reg6:
							register1 == R7 ? reg7:
							register1 == R8 ? reg8:
							register1 == CMP ? cmp: 
							register1 == R_Str ? rst: 
							register1 == R_Scr ? rsc: sp;
	
	assign r2_data_out = register2 == R1 ? reg1:
							register2 == R2 ? reg2:
							register2 == R3 ? reg3:
							register2 == R4 ? reg4:
							register2 == R5 ? reg5:
							register2 == R6 ? reg6:
							register2 == R7 ? reg7:
							register2 == R8 ? reg8:
							register2 == CMP ? cmp: 
							register2 == R_Str ? rst: 
							register2 == R_Scr ? rsc: sp;
	
	always@(posedge clk)
	begin
		if(write == 1'd1)
		begin
			case(register1)
				R1:
					reg1 <= data_in;
				R2:
					reg2 <= data_in;
				R3:
					reg3 <= data_in;
				R4:
					reg4 <= data_in;
				R5:
					reg5 <= data_in;
				R6:
					reg6 <= data_in;
				R7:
					reg7 <= data_in;
				R8:
					reg8 <= data_in;
				CMP:
					cmp <= data_in;
				SP:
					sp <= data_in;
				R_Str:
					rst <= data_in;
				R_Scr:
					rsc <= data_in;
			endcase
		end
	end
endmodule
