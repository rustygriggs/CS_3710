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
	input [3:0] register,
	input [15:0] data_in,
	input write,
	output reg [15:0] data_out
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

	always@(*) begin
		case(write)
			1'b0:
				case(register)
					PC:
						data_out = pc;
					R1:
						data_out = reg1;
					R2:
						data_out = reg2;
					R3:
						data_out = reg3;
					R4:
						data_out = reg4;
					R5:
						data_out = reg5;
					R6:
						data_out = reg6;
					R7:
						data_out = reg7;
					R8:
						data_out = reg8;
					PCP:
						data_out = pcp;
					CMP:
						data_out = cmp;
					INST:
						data_out = inst;
					SP:
						data_out = sp;
					ADDR:
						data_out = addr;
				endcase
			1'b1:
				case(register)
					PC:
						pc = data_in;
					R1:
						reg1 = data_in;
					R2:
						reg2 = data_in;
					R3:
						reg3 = data_in;
					R4:
						reg4 = data_in;
					R5:
						reg5 = data_in;
					R6:
						reg6 = data_in;
					R7:
						reg7 = data_in;
					R8:
						reg8 = data_in;
					PCP:
						pcp = data_in;
					CMP:
						cmp = data_in;
					INST:
						inst = data_in;
					SP:
						sp = data_in;
					ADDR:
						addr = data_in;
				endcase
		endcase
	end
endmodule
