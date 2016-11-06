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
	input [5:0]instruction,
	input [15:0] data_in_A,
	input [15:0] data_in_B,
	output [15:0] data_out
    );

	parameter NOT = 6'd0, AND = 6'd1, OR = 6'd2, SHIFTR = 6'd3, SHIFTL = 6'd4;
	parameter ADD = 6'd5, SUB = 6'd6;
	
	parameter S1 = 16'd1, S2 = 16'd2, S3 = 16'd3, S4 = 16'd4, S5 = 16'd5, S6 = 16'd6;
	parameter S7 = 16'd7, S8 = 16'd8, S9 = 16'd9, S10 = 16'd10, S11 = 16'd11, S12 = 16'd12;
	parameter S13 = 16'd13, S14 = 16'd14, S15 = 16'd15, S16 = 16'd16;
	
	assign data_out = instruction == NOT ? ~data_in_A:
							instruction == AND ? data_in_A & data_in_B:
							instruction == OR ? data_in_A | data_in_B:
							instruction == SHIFTR ? 
								data_in_B == S1 ? {1'b0,data_in_A[15:1]}:
								data_in_B == S2 ? {2'b0,data_in_A[15:2]}:
								data_in_B == S3 ? {3'b0,data_in_A[15:3]}:
								data_in_B == S4 ? {4'b0,data_in_A[15:4]}:
								data_in_B == S5 ? {5'b0,data_in_A[15:5]}:
								data_in_B == S6 ? {6'b0,data_in_A[15:6]}:
								data_in_B == S7 ? {7'b0,data_in_A[15:7]}:
								data_in_B == S8 ? {8'b0,data_in_A[15:8]}:
								data_in_B == S9 ? {9'b0,data_in_A[15:9]}:
								data_in_B == S10 ? {10'b0,data_in_A[15:10]}:
								data_in_B == S11 ? {11'b0,data_in_A[15:11]}:
								data_in_B == S12 ? {12'b0,data_in_A[15:12]}:
								data_in_B == S13 ? {13'b0,data_in_A[15:13]}:
								data_in_B == S14 ? {14'b0,data_in_A[15:14]}:
								data_in_B == S15 ? {15'b0,data_in_A[15:15]}: {16'b0}:
							instruction == SHIFTL ? 
								data_in_B == S1 ? {data_in_A[14:0],1'b0}:
								data_in_B == S2 ? {data_in_A[13:0],2'b0}:
								data_in_B == S3 ? {data_in_A[12:0],3'b0}:
								data_in_B == S4 ? {data_in_A[11:0],4'b0}:
								data_in_B == S5 ? {data_in_A[10:0],5'b0}:
								data_in_B == S6 ? {data_in_A[9:0],6'b0}:
								data_in_B == S7 ? {data_in_A[8:0],7'b0}:
								data_in_B == S8 ? {data_in_A[7:0],8'b0}:
								data_in_B == S9 ? {data_in_A[6:0],9'b0}:
								data_in_B == S10 ? {data_in_A[5:0],10'b0}:
								data_in_B == S11 ? {data_in_A[4:0],11'b0}:
								data_in_B == S12 ? {data_in_A[3:0],12'b0}:
								data_in_B == S13 ? {data_in_A[2:0],13'b0}:
								data_in_B == S14 ? {data_in_A[1:0],14'b0}:
								data_in_B == S15 ? {data_in_A[0:0],15'b0}: {16'b0}:
							instruction == ADD ? data_in_A + data_in_B: data_in_A - data_in_B;
	
//	always@(*) begin
//		case(instruction)
//			
//			NOT:
//				data_out = ~data_in_A;
//			AND:
//				data_out = data_in_A & data_in_B;
//			OR:
//				data_out = data_in_A | data_in_B;
//			SHIFTR:
//				case(data_in_B)
//					S1:
//						data_out = {1'b0,data_in_A[15:1]};
//					S2:
//						data_out = {2'b0,data_in_A[15:2]};
//					S3:
//						data_out = {3'b0,data_in_A[15:3]};
//					S4:
//						data_out = {4'b0,data_in_A[15:4]};
//					S5:
//						data_out = {5'b0,data_in_A[15:5]};
//					S6:
//						data_out = {6'b0,data_in_A[15:6]};
//					S7:
//						data_out = {7'b0,data_in_A[15:7]};
//					S8:
//						data_out = {8'b0,data_in_A[15:8]};
//					S9:
//						data_out = {9'b0,data_in_A[15:9]};
//					S10:
//						data_out = {10'b0,data_in_A[15:10]};
//					S11:
//						data_out = {11'b0,data_in_A[15:11]};
//					S12:
//						data_out = {12'b0,data_in_A[15:12]};
//					S13:
//						data_out = {13'b0,data_in_A[15:13]};
//					S14:
//						data_out = {14'b0,data_in_A[15:14]};
//					S15:
//						data_out = {15'b0,data_in_A[15]};
//					S16:
//						data_out = {16'd0};
//				endcase
//			SHIFTL:
//				case(data_in_B)
//					S1:
//						data_out = {data_in_A[14:0],1'b0};
//					S2:
//						data_out = {data_in_A[13:0],2'b0};
//					S3:
//						data_out = {data_in_A[12:0],3'b0};
//					S4:
//						data_out = {data_in_A[11:0],4'b0};
//					S5:
//						data_out = {data_in_A[10:0],5'b0};
//					S6:
//						data_out = {data_in_A[9:0],6'b0};
//					S7:
//						data_out = {data_in_A[8:0],7'b0};
//					S8:
//						data_out = {data_in_A[7:0],8'b0};
//					S9:
//						data_out = {data_in_A[6:0],9'b0};
//					S10:
//						data_out = {data_in_A[5:0],10'b0};
//					S11:
//						data_out = {data_in_A[4:0],11'b0};
//					S12:
//						data_out = {data_in_A[3:0],12'b0};
//					S13:
//						data_out = {data_in_A[2:0],13'b0};
//					S14:
//						data_out = {data_in_A[1:0],14'b0};
//					S15:
//						data_out = {data_in_A[0],15'b0};
//					S16:
//						data_out = {16'd0};
//				endcase
//			ADD:
//				data_out = data_in_A + data_in_B;
//			SUB:
//				data_out = data_in_A - data_in_B;
//		endcase
//	end
endmodule
