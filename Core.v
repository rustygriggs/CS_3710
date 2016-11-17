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
	
	parameter N = 6; // number of clock cycles. May want more if instructions take longer
	reg [N-1:0] ps = fetch;
	reg [N-1:0] ns = fetch; 
	reg [14:0] PC = 15'h2400;
	reg [14:0] SP = 15'h3000;
	reg [14:0] PCP;
	reg [5:0]opcode;
	reg [4:0] register1;
	reg [4:0] register2;
	//reg [14:0] addr;
	
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
	
	assign memory_addr = (ns == load2 || ns == store2) ? data_out[14:0] : (ns == push2 || ns == pop2) ? SP : PC;
	assign write = (ns == store2 || ns == push2) ? 1'd1 : 1'd0;
	assign data_in = r1_out;

	assign r_in = (ns == ALU2) ? ALU_out : data_out;
	assign r_w = (ns == load3|| ns == pop3 || ns == ALU2) ?  1'd1 : 1'd0; 
	assign r1 = (ns == jmp2 || ns == ALU2) ? 5'd3 : register1;
	assign r2 = register2;
	
	assign ALU_inst = opcode;
	assign ALU_A = r1_out;
	assign ALU_B =	r2_out;	
	
	parameter nop = 6'd0, load = 6'd1, store = 6'd2, move = 6'd3, _not = 6'd4, _and = 6'd5, _or = 6'd6;
	parameter shiftr = 6'd7, shiftl = 6'd8, add = 6'd9, sub = 6'd10, test = 6'd11, jmpEq = 6'd12, jmpLE = 6'd13;
	parameter jmpGE = 6'd14, jmpL = 6'd15, jmpG = 6'd16, jmp = 6'd17, reset = 6'd18, push = 6'd19, pop = 6'd20, call = 6'd21;
	
	parameter fetch = 6'd0, inst = 6'd1, load2 = 6'd2, store2 = 6'd3, load3 = 6'd4, ALU2 = 6'd5, jmp2 = 6'd6, pop2 = 6'd7, pop3 = 6'd8, push2 = 6'd9;
	parameter cmp = 5'd10;
	
	always@(posedge clk)
	begin
		ps = ns;
		case(ps)
			fetch:
			begin
				PC <= PC + 15'd1;
				ns <= inst;
			end
			inst:
			begin
				opcode <= data_out[5:0];
				register1 <= data_out[10:6];
				register2 <= data_out[15:11];
				case(data_out[5:0])
					nop:
						ns <= fetch;
					reset:
					begin
						PC <= 15'h2400;
						ns <= inst;
					end
					load:
						ns <= load2;
					store:
						ns <= store2;
					move, _not, _and, _or, shiftr, shiftl, add, sub, test:
						ns <= ALU2;
					jmpEq, jmpLE, jmpGE, jmpL, jmpG, jmp, call:
						begin
						if(data_out[5:0] == call)
							PCP <= PC;
						if(data_out[5:0] == jmp)
							PC <= PCP + 15'd1;
						ns <= jmp2;
						end
					push:
						ns <= push2;
					pop:
					begin
						SP <= SP - 15'd1;
						ns <= pop2;
					end
					default:
						ns <= fetch;
				endcase
			end
			jmp2:
			begin
				case(opcode)
					jmpEq:
					begin
						if(r1_out == 0)
							PC <= data_out[14:0];
					end
					jmpGE:
					begin
						if(r1_out >= 0)
							PC <= data_out[14:0];
					end
					jmpLE:
					begin
						if(r1_out <= 0)
							PC <= data_out[14:0];
					end
					jmpL:
					begin
						if(r1_out < 0)
							PC <= data_out[14:0];
					end
					jmpG:
					begin
						if(r1_out > 0)
							PC <= data_out[14:0];
					end
					default:
						PC <= data_out[14:0];
				endcase
				ns	<= fetch;
			end
			ALU2:
			begin
				PC <= PC + 15'd1;
				ns <= inst;
			end
			load2:
			begin
				ns <= load3;
			end
			store2:
			begin
				PC <= PC + 15'd1;
				ns <= fetch;
			end
			load3:
			begin
				PC <= PC + 15'd1;
				ns <= inst;
			end
			pop2:
				ns <= pop3;
			pop3:
				ns <= inst;
			push2:
			begin
				SP <= SP + 15'd1;
				ns <= fetch;
			end
			default:
				ns <= fetch;
		endcase
	end
endmodule
