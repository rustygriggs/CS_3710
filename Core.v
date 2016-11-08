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
	reg [N-1:0] ps = fetch;
	reg [N-1:0] ns = fetch; 
	reg [14:0] PC = 15'h2400;
	//reg [N-1:0] cycle = 2'b0;
	reg [5:0]opcode;
	reg [4:0] register1;
	reg [4:0] register2;
	
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
	
	assign memory_addr = (ns == load2 || ns == store2) ? data_out[14:0] : PC;
	assign write = ns == store2 ? 1'd1 : 1'd0;
	assign data_in = r1_out;

	assign r_in = (ns == add2 || ns == sub2) ? ALU_out : data_out;
	assign r_w = (ns == load3 || ns == add2 || ns == sub2) ?  1'd1 : 1'd0; 
	assign r1 = register1;
	assign r2 = register2;
	
	assign ALU_inst = opcode;
	assign ALU_A = r1_out;
	assign ALU_B =	r2_out;	
	
	parameter reset = 6'd0, load = 6'd1, store = 6'd2, add = 6'd5, sub = 6'd6;
	parameter fetch = 6'd0, inst = 6'd1, load2 = 6'd2, store2 = 6'd3, load3 = 6'd4, add2 = 6'd5, sub2 = 6'd6;
		
	
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
					reset:
					begin
						PC <= 15'h2400;
						ns <= inst;
					end
					load:
					begin
						ns <= load2;
					end
					store:
						ns <= store2;
					add:
					begin
						ns <= add2;
					end
					sub:
					begin
						ns <= sub2;
					end
					default:
						ns <= fetch;
				endcase
			end
			add2:
			begin
				PC <= PC + 15'd1;
				ns <= inst;
			end
			sub2:
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
			default:
				ns <= fetch;
		endcase
	end
endmodule
