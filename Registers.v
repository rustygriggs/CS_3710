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

	reg [15:0]pc;
	reg [15:0]reg1;
	reg [15:0]reg2;
	reg [15:0]reg3;
	reg [15:0]reg4;
	reg [15:0]reg5;
	reg [15:0]reg6;
	reg [15:0]reg7;
	reg [15:0]reg8;
	reg [15:0]pcp;
	reg [15:0]cmp;
	reg [15:0]inst;
	reg [15:0]sp;
	reg [15:0]addr;	

	parameter PC = 4'd0, R1 = 4'd1, R2 = 4'd2, R3 = 4'd3, R4 = 4'd4, R5 = 4'd5;
	parameter R6 = 4'd6, R7 = 4'd7, R8 = 4'd8, PCP = 4'd9, CMP = 4'd10, INST = 4'd11;
	parameter SP = 4'd12, ADDR = 4'd13;

	assign r1_data_out = register1 == PC ? pc:
							register1 == R1 ? reg1:
							register1 == R2 ? reg2:
							register1 == R3 ? reg3:
							register1 == R4 ? reg4:
							register1 == R5 ? reg5:
							register1 == R6 ? reg6:
							register1 == R7 ? reg7:
							register1 == R8 ? reg8:
							register1 == PCP ? pcp:
							register1 == CMP ? cmp:
							register1 == INST ? inst:
							register1 == SP ? sp: addr;
	
	assign r2_data_out = register2 == PC ? pc:
							register2 == R1 ? reg1:
							register2 == R2 ? reg2:
							register2 == R3 ? reg3:
							register2 == R4 ? reg4:
							register2 == R5 ? reg5:
							register2 == R6 ? reg6:
							register2 == R7 ? reg7:
							register2 == R8 ? reg8:
							register2 == PCP ? pcp:
							register2 == CMP ? cmp:
							register2 == INST ? inst:
							register2 == SP ? sp: addr;
	
	always@(posedge clk)
	begin
		if(write == 1'd1)
		begin
			case(register1)
				PC:
					pc <= data_in;
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
				PCP:
					pcp <= data_in;
				CMP:
					cmp <= data_in;
				INST:
					inst <= data_in;
				SP:
					sp <= data_in;
				ADDR:
					addr <= data_in;
			endcase
		end
	end
endmodule
