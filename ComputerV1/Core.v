`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:59 10/25/2016 
// Design Name: 
// Module Name:    Core 
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
module Core(
	input clk,
	input [15:0] inData,
	output reg [15:0] outData,
	output reg [14:0] addr,
	output reg W
    );
	
	parameter N = 2; // number of clock cycles. May want more if instructions take longer
	 
	reg [15:0] PC = 16'h2600;
	reg [14:0] MA = 15'd7;
	reg [15:0] data = 15'd27;
	reg [N-1:0] cycle;
	reg opcode;
	
	always@(posedge clk)
	begin
		if(cycle == 2'd3)
			cycle <= 0;
		else
			cycle <= cycle + 2'd1;
	end
	
	wire reset = 6'd0, load = 6'd1, store = 6'd2, incr = 6'd3, pause = 6'd4;
	wire cycle0 = 2'd0, cycle1 = 2'd1, cycle2 = 2'd2, cycle3 = 2'd3; 
	
	always@(*)
	begin
		case(cycle)
		
			cycle0:
			begin
				addr = PC;
				W = 0;
			end
			
			cycle1:
			begin
				opcode = outData;
				case(opcode)
					reset:
					begin
						PC = 16'h2600;
					end
					load:
					begin
						addr = MA;
						W = 0;
					end
					store:
					begin
						addr = MA;
						inData = data;
						W = 1;
					end
					incr:
					begin
						addr = MA;
						inData = data + 15'd1;
						W = 1;
					end
				endcase
			end
			
			cycle2:
			begin
				case(opcode)
					load:
						data = outData;
				endcase
			end
			
			cycle3:
			begin
				PC = PC + 15'd1;
			end
		endcase
	end
endmodule
