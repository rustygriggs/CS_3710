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
	output [15:0] data_in,
	output [14:0] memory_addr,
	output write
    );
	
	parameter N = 3; // number of clock cycles. May want more if instructions take longer
	reg [N-1:0] ps;
	reg [N-1:0] ns;
	reg [14:0] PC = 15'h2400;
	//reg [N-1:0] cycle = 2'b0;
	reg [5:0]opcode;
	reg [4:0]register1;
	reg [4:0]register2;
	
	wire [4:0]r1;
	wire [4:0]r2;
	wire [15:0]r_in; 
	wire r_w;
	wire [15:0]r1_out;
	wire [15:0]r2_out;
	
	wire [5:0]ALU_inst;
	wire [15:0] ALU_A;
	wire [15:0] ALU_B;
	wire [15:0] ALU_out;
	
	Registers Reg_Module(clk, r1, r2, r_in, r_w, r1_out, r2_out);
	ALU ALU_Module(ALU_inst, ALU_A, ALU_B, ALU_out);
	
	assign memory_addr = ps == load2 || ps == store2 ? data_out[14:0] :
									ps == inst ?
										opcode == load || opcode == store ? PC + 15'd1 : PC : PC;
										
	assign write = ps == store ? 1'd1 : 1'd0;
	assign data_in = r1_out;
	
	assign r_in = ps == add ? ALU_out : data_out;
	assign r_w = ps == load || ps == store || ps == load3 || ps == add ? 1'd1 : 1'd0;
	assign r1 = register1;
	assign r2 = register2;
	
	assign ALU_inst = opcode;
	assign ALU_A = r1_out;
	assign ALU_B =	r2_out;
	
	//assign r = cycle == cycle4 ? 
	//					opcode == add ? second_reg : first_reg :								
	//			  cycle == cycle5 ? second_reg : first_reg;
	//assign ALU_inst = 
	//assign ALU_A = cycle == cycle3 ?
	//						opcode == add ? r_out
	//assign ALU_B =
	
	//initial write = 1'b0;
	//initial ALU_inst = 4'd5;
	
	parameter reset = 6'd0, load = 6'd1, store = 6'd2, add = 6'd5, sub = 6'd6;
	//parameter cycle0 = 3'd0, cycle1 = 3'd1, cycle2 = 3'd2, cycle3 = 3'd3, cycle4 = 3'd4, cycle5 = 3'd5, cycle6 = 3'd6, cycle7 = 3'd7; 
	parameter fetch = 6'd0, inst = 6'd1, load2 = 6'd2, store2 = 6'd3, load3 = 6'd4;
	
	
	always@(posedge clk)
	begin
		case(ps)
			fetch:
				ns <= inst;
			inst:
			begin
				opcode = data_out[5:0];
				register1 = data_out[10:6];
				register2 = data_out[15:11];
				case(opcode)
					reset:
					begin
						PC <= 15'h2400;
						ns <= inst;
					end
					load:
						ns <= load2;
					store:
						ns <= store2;
					add:
						ns <= inst;
				endcase
			end
			load2:
				ns <= load3;
			store2:
				ns <= fetch;
			load3:
				ns <= inst;
		endcase
		PC <= PC + 15'd1;
		ps <= ns;
	end
//		case(cycle)
//		
//			cycle0:
//			begin
//				memory_addr = PC;
//				write = 0;
//			end
//			
//			cycle2:
//			begin
//				opcode = data_out[5:0];
//				first_reg = data_out[10:6];
//				second_reg = data_out[14:11];
//				
//				case(opcode)
//					reset:
//					begin
//						PC = 16'h2400;
//					end
//					load, store:
//					begin
//						PC = PC + 15'd1;				
//						memory_addr = PC;
//						write = 0;
//					end
//					add:
//					begin
//					end
//					sub:
//					begin
//						//ALU_inst = 4'd6;
//					end
//				endcase
//			end
//			cycle3:
//			begin
//				case(opcode)
//					add:
//					begin
//					end
//				endcase
//			end
//			cycle4:
//			begin
//				case(opcode)
//					load:
//					begin
//						memory_addr = data_out[14:0];
//						write = 0;
//					end
//					store:
//					begin
//						memory_addr = data_out[14:0];
//						//r = first_reg;
//						data_in = r_out;
//						//r_w = 0;
//						write = 1;
//					end
//					add:
//					begin
//					end
//				endcase
//			end
//			
//			cycle6:
//			begin
//				case(opcode)
//					load:
//					begin
//						//r = first_reg;
//						//r_in = data_out;
//						//r_w = 1;
//						write = 0;
//					end
//					store:
//					begin
//						write = 0;
//					end
//					add:
//					begin
//					end
//				endcase
//			end
//			cycle7:
//			begin 
//				PC = PC + 15'd1;
//			end
//		endcase
//		cycle = cycle + 2'd1;
endmodule
