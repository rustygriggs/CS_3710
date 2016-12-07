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
	input [4:0] debug_in,
	output [15:0] r1_data_out,
	output [15:0] r2_data_out,
	output [15:0] debug_out
    );
	
	reg [15:0]reg0 = 0;
	reg [15:0]reg1 = 0;
	reg [15:0]reg2 = 0;
	reg [15:0]reg3 = 0;
	reg [15:0]reg4 = 0;
	reg [15:0]reg5 = 0;
	reg [15:0]reg6 = 0;
	reg [15:0]reg7 = 0;
	reg [15:0]reg8 = 0;
	reg [15:0]reg9 = 0;
	reg [15:0]reg10 = 0;
	reg [15:0]reg11 = 0;
	reg [15:0]reg12 = 0;
	reg [15:0]reg13 = 0;
	reg [15:0]reg14 = 0;
	reg [15:0]reg15 = 0;
	reg [15:0]reg16 = 0;
	reg [15:0]reg17 = 0;
	reg [15:0]reg18 = 0;
	reg [15:0]reg19 = 0;
	reg [15:0]reg20 = 0;
	reg [15:0]reg21 = 0;
	reg [15:0]reg22 = 0;
	reg [15:0]reg23 = 0;
	reg [15:0]reg24 = 0;
	reg [15:0]reg25 = 0;
	reg [15:0]reg26 = 0;
	reg [15:0]reg27 = 0;
	reg [15:0]cmp = 0;
	reg [15:0]sp = 0;	
	reg [15:0]rst = 0;
	reg [15:0]rsc = 0;

	parameter R0 = 5'd0, R1 = 5'd1, R2 = 5'd2, R3 = 5'd3, R4 = 5'd4, R5 = 5'd5;
	parameter R6 = 5'd6, R7 = 5'd7, R8 = 5'd8, R9 = 5'd9, R10 = 5'd10;
	parameter R11 = 5'd11, R12 = 5'd12, R13 = 5'd13, R14 = 5'd14, R15 = 5'd15;
	parameter R16 = 5'd16, R17 = 5'd17, R18 = 5'd18, R19 = 5'd19, R20 = 5'd20;
	parameter R21 = 5'd21, R22 = 5'd22, R23 = 5'd23, R24 = 5'd24, R25 = 5'd25;
	parameter R26 = 5'd26, R27 = 5'd27, CMP = 5'd28, R_Str = 5'd29, R_Scr = 5'd30, SP = 5'd31;

	
	assign debug_out = debug_in == R0 ? reg0:
							debug_in == R1 ? reg1:
							debug_in == R2 ? reg2:
							debug_in == R3 ? reg3:
							debug_in == R4 ? reg4:
							debug_in == R5 ? reg5:
							debug_in == R6 ? reg6:
							debug_in == R7 ? reg7:
							debug_in == R8 ? reg8:
							debug_in == R9 ? reg9:
							debug_in == R10 ? reg10:
							debug_in == R11 ? reg11:
							debug_in == R12 ? reg12:
							debug_in == R13 ? reg13:
							debug_in == R14 ? reg14:
							debug_in == R15 ? reg15:
							debug_in == R16 ? reg16:
							debug_in == R17 ? reg17:
							debug_in == R18 ? reg18:
							debug_in == R19 ? reg19:
							debug_in == R20 ? reg20:
							debug_in == R21 ? reg21:
							debug_in == R22 ? reg22:
							debug_in == R23 ? reg23:
							debug_in == R24 ? reg24:
							debug_in == R25 ? reg25:
							debug_in == R26 ? reg26:
							debug_in == R27 ? reg27:
							debug_in == CMP ? cmp: 
							debug_in == R_Str ? rst: 
							debug_in == R_Scr ? rsc: sp;
	
	assign r1_data_out = register1 == R0 ? reg0:
							register1 == R1 ? reg1:
							register1 == R2 ? reg2:
							register1 == R3 ? reg3:
							register1 == R4 ? reg4:
							register1 == R5 ? reg5:
							register1 == R6 ? reg6:
							register1 == R7 ? reg7:
							register1 == R8 ? reg8:
							register1 == R9 ? reg9:
							register1 == R10 ? reg10:
							register1 == R11 ? reg11:
							register1 == R12 ? reg12:
							register1 == R13 ? reg13:
							register1 == R14 ? reg14:
							register1 == R15 ? reg15:
							register1 == R16 ? reg16:
							register1 == R17 ? reg17:
							register1 == R18 ? reg18:
							register1 == R19 ? reg19:
							register1 == R20 ? reg20:
							register1 == R21 ? reg21:
							register1 == R22 ? reg22:
							register1 == R23 ? reg23:
							register1 == R24 ? reg24:
							register1 == R25 ? reg25:
							register1 == R26 ? reg26:
							register1 == R27 ? reg27:
							register1 == CMP ? cmp: 
							register1 == R_Str ? rst: 
							register1 == R_Scr ? rsc: sp;
	
	assign r2_data_out = register2 == R0 ? reg0:
							register2 == R1 ? reg1:
							register2 == R2 ? reg2:
							register2 == R3 ? reg3:
							register2 == R4 ? reg4:
							register2 == R5 ? reg5:
							register2 == R6 ? reg6:
							register2 == R7 ? reg7:
							register2 == R8 ? reg8:
							register2 == R9 ? reg9:
							register2 == R10 ? reg10:
							register2 == R11 ? reg11:
							register2 == R12 ? reg12:
							register2 == R13 ? reg13:
							register2 == R14 ? reg14:
							register2 == R15 ? reg15:
							register2 == R16 ? reg16:
							register2 == R17 ? reg17:
							register2 == R18 ? reg18:
							register2 == R19 ? reg19:
							register2 == R20 ? reg20:
							register2 == R21 ? reg21:
							register2 == R22 ? reg22:
							register2 == R23 ? reg23:
							register2 == R24 ? reg24:
							register2 == R25 ? reg25:
							register2 == R26 ? reg26:
							register2 == R27 ? reg27:
							register2 == CMP ? cmp: 
							register2 == R_Str ? rst: 
							register2 == R_Scr ? rsc: sp;
	
	always@(posedge clk)
	begin
		if(write == 1'd1)
		begin
			case(register1)
				R0:
					reg0 <= data_in;
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
				R9:
					reg9 <= data_in;
				R10:
					reg10 <= data_in;
				R11:
					reg11 <= data_in;
				R12:
					reg12 <= data_in;
				R13:
					reg13 <= data_in;
				R14:
					reg14 <= data_in;
				R15:
					reg15 <= data_in;
				R16:
					reg16 <= data_in;
				R17:
					reg17 <= data_in;
				R18:
					reg18 <= data_in;
				R19:
					reg19 <= data_in;
				R20:
					reg20 <= data_in;
				R21:
					reg21 <= data_in;
				R22:
					reg22 <= data_in;
				R23:
					reg23 <= data_in;
				R24:
					reg24 <= data_in;
				R25:
					reg25 <= data_in;
				R25:
					reg25 <= data_in;
				R26:
					reg26 <= data_in;
				R27:
					reg27 <= data_in;
				CMP:
					cmp <= data_in;
				R_Str:
					rst <= data_in;
				R_Scr:
					rsc <= data_in;
				SP:
					sp <= data_in;
			endcase
		end
	end
endmodule
