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
	output [15:0] outData
    );

	parameter NOT = 6'd0, AND = 6'd1, OR = 6'd2, SHIFTR = 6'd3, SHIFTL = 6'd4;
	parameter ADD = 6'd5, SUB = 6'd6;

	always@(*) begin
		case(instruction)
			
			NOT:
				outData = ~inDataA;
			AND:
				outData = inDataA & inDataB;
			OR:
				outData = inDataA | inDataB;
			SHIFTR:
				outData = {1'b0,inDataA[15:1]};
			SHIFTL:
				outData = {inDataA[14:0],1'b0};
			ADD:
				outData = inDataA + inDataB;
			SUB:
				outData = inDataA - inDataB;
		endcase
	end
endmodule
