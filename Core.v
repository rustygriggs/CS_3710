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
	input [15:0] outData,
	output [15:0] inData,
	output [14:0] addr,
	output reg W
    );
	
	parameter N = 2; // number of clock cycles. May want more if instructions take longer
	
	reg [14:0] PC = 15'h2400;
	parameter MA1 = 15'h71;
	parameter MA2 = 15'h600;
	reg [15:0] data = 15'h37;
	reg [N-1:0] cycle = 2'b0;
	reg [5:0]opcode;
	
	//initial opcode = 1;
	initial W = 1'b0;
	
	parameter reset = 6'd0, load = 6'd1, store = 6'd2, incr = 6'd3, pause = 6'd4;
	parameter cycle0 = 2'd0, cycle1 = 2'd1, cycle2 = 2'd2, cycle3 = 2'd3; 
	
	assign addr = (cycle == 0 ? PC : (outData[5:0] == 1 ? MA1 : MA2));
	assign inData = data;
	
	always@(posedge clk)
	begin
		case(cycle)
		
			cycle0:
			begin
				//addr <= PC;
				W <= 0;
			end
			
			cycle1:
			begin
				opcode <= outData[5:0];
				case(opcode)
					reset:
					begin
						PC <= 16'h2400;
					end
					load:
					begin
						//addr <= MA1;
						W <= 0;
					end
					store:
					begin
						//addr <= MA2;
						//inData <= data;
						W <= 1;
					end
					incr:
					begin
						//addr <= MA2;
						//inData <= data + 15'd1;
						W <= 1;
					end
				endcase
			end
			
			cycle2:
			begin
				case(opcode)
					load:
					begin
						data <= outData;
						W <= 0;
					end
					store:
					begin
						W <= 0;
					end
					incr:
					begin
						W <= 0;
					end
				endcase
			end
			
			cycle3:
			begin
				PC <= PC + 15'd1;
			end
		endcase
		
		cycle <= cycle + 2'd1;
	
	end
endmodule
