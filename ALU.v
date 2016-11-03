`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:52:05 10/31/2016 
// Design Name: 
// Module Name:    ALU 
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
 module ALU(
	input [3:0]instruction,
	input [15:0] inDataA,
	input [15:0] inDataB,
	output reg [15:0] outData
    );

	parameter NOT = 6'd0, AND = 6'd1, OR = 6'd2, SHIFTR = 6'd3, SHIFTL = 6'd4;
	parameter ADD = 6'd5, SUB = 6'd6;
	
	parameter S1 = 16'd1, S2 = 16'd2, S3 = 16'd3, S4 = 16'd4, S5 = 16'd5, S6 = 16'd6;
	parameter S7 = 16'd7, S8 = 16'd8, S9 = 16'd9, S10 = 16'd10, S11 = 16'd11, S12 = 16'd12;
	parameter S13 = 16'd13, S14 = 16'd14, S15 = 16'd15, S16 = 16'd16;

	always@(*) begin
		case(instruction)
			
			NOT:
				outData = ~inDataA;
			AND:
				outData = inDataA & inDataB;
			OR:
				outData = inDataA | inDataB;
			SHIFTR:
				case(inDataB)
					S1:
						outData = {1'b0,inDataA[15:1]};
					S2:
						outData = {2'b0,inDataA[15:2]};
					S3:
						outData = {3'b0,inDataA[15:3]};
					S4:
						outData = {4'b0,inDataA[15:4]};
					S5:
						outData = {5'b0,inDataA[15:5]};
					S6:
						outData = {6'b0,inDataA[15:6]};
					S7:
						outData = {7'b0,inDataA[15:7]};
					S8:
						outData = {8'b0,inDataA[15:8]};
					S9:
						outData = {9'b0,inDataA[15:9]};
					S10:
						outData = {10'b0,inDataA[15:10]};
					S11:
						outData = {11'b0,inDataA[15:11]};
					S12:
						outData = {12'b0,inDataA[15:12]};
					S13:
						outData = {13'b0,inDataA[15:13]};
					S14:
						outData = {14'b0,inDataA[15:14]};
					S15:
						outData = {15'b0,inDataA[15]};
					S16:
						outData = {16'0};
				endcase
			SHIFTL:
				case(inDataB)
					S1:
						outData = {inDataA[14:0],1'b0};
					S2:
						outData = {inDataA[13:0],2'b0};
					S3:
						outData = {inDataA[12:0],3'b0};
					S4:
						outData = {inDataA[11:0],4'b0};
					S5:
						outData = {inDataA[10:0],5'b0};
					S6:
						outData = {inDataA[9:0],6'b0};
					S7:
						outData = {inDataA[8:0],7'b0};
					S8:
						outData = {inDataA[7:0],8'b0};
					S9:
						outData = {inDataA[6:0],9'b0};
					S10:
						outData = {inDataA[5:0],10'b0};
					S11:
						outData = {inDataA[4:0],11'b0};
					S12:
						outData = {inDataA[3:0],12'b0};
					S13:
						outData = {inDataA[2:0],13'b0};
					S14:
						outData = {inDataA[1:0],14'b0};
					S15:
						outData = {inDataA[0],15'b0};
					S16:
						outData = {16'0};
				endcase
			ADD:
				outData = inDataA + inDataB;
			SUB:
				outData = inDataA - inDataB;
		endcase
	end
endmodule
