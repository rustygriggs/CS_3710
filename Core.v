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
	input [15:0] data_out,
	output reg [15:0] data_in,
	output reg [14:0] memory_addr,
	output reg write
    );
	
	parameter N = 3; // number of clock cycles. May want more if instructions take longer
	reg [14:0] PC = 15'h2400;
	parameter MA1 = 15'h71;
	parameter MA2 = 15'h600;
	reg [15:0] data = 15'h37;
	reg [N-1:0] cycle = 2'b0;
	reg [5:0]opcode;
	reg [4:0]first_reg;
	reg [4:0]second_reg;
	
	reg [15:0]reg1;
	reg [15:0]reg2;
	reg [15:0]reg3;
	reg [15:0]reg4;
	reg [15:0]reg5;
	reg [15:0]reg6;
	reg [15:0]reg7;
	reg [15:0]reg8;
	
	
	//initial opcode = 1;
	initial write = 1'b0;
	
	parameter reset = 6'd0, load = 6'd1, store = 6'd2, incr = 6'd3, pause = 6'd4;
	parameter cycle0 = 3'd0, cycle1 = 3'd1, cycle2 = 3'd2, cycle3 = 3'd3, cycle4 = 3'd4, cycle5 = 3'd5, cycle6 = 3'd6, cycle7 = 3'd7; 
	
	//assign memory_addr = (cycle == 0 ? PC : (opcode == 1 ? MA1 : MA2));
	
	always@(posedge clk)
	begin
		case(cycle)
		
			cycle0:
			begin
				//addr <= PC;
				memory_addr = PC;
				write = 0;
			end
			
			cycle2:
			begin
				opcode = data_out[5:0];
				//second_reg = data_out[15:11];
				
				case(opcode)
					reset:
					begin
						PC = 16'h2400;
					end
					load:
					begin
						//first_reg = data_out[10:6];
						PC = PC + 15'd1;				
						memory_addr = PC;
						//memory_addr = MA1;
						write = 0;
					end
					store:
					begin
						PC = PC + 15'd1;				
						memory_addr = PC;
						//memory_addr = MA1;
						write = 0;
					end
					incr:
					begin
						PC = PC + 15'd1;				
						memory_addr = PC;
						//data_in = data;
						write = 0;
					end
				endcase
			end
			
			cycle4:
			begin
				case(opcode)
					load:
					begin
						memory_addr = data_out[14:0];
						//reg1 = data_out;
						//data = data_out;
						write = 0;
					end
					store:
					begin
						memory_addr = data_out[14:0];
						data_in = reg1;
						write = 1;
					end
					incr:
					begin
						write = 0;
					end
				endcase
			end
			
			cycle6:
			begin
				case(opcode)
					load:
					begin
						//data_in = data_out;
						//if(first_reg == 5'd0)
						//begin
						reg1 = data_out;
						//end
						write = 0;
					end
					store:
					begin
						write = 0;
					end
					incr:
					begin
						write = 0;
					end
				endcase
			end
			cycle7:
			begin 
				PC = PC + 15'd1;
			end
		endcase
		cycle = cycle + 2'd1;
	
	end
endmodule
