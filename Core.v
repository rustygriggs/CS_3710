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
	//output resume
    );
	
	parameter N = 6; // number of clock cycles. May want more if instructions take longer
	reg [N-1:0] state = fetch;
	reg [14:0] PC = 15'h2400;
	reg [14:0] SP = 15'h3000;
	reg [14:0] PCP;
	reg [5:0]opcode;
	reg [4:0] inst_reg1;
	reg [4:0] inst_reg2;
	
	reg [4:0]r1;
	reg [4:0]r2;
	reg [15:0]r_in; 
	reg r_w;
	wire [15:0]r1_out;
	wire [15:0]r2_out;
	
	wire [5:0]ALU_inst;
	wire [15:0] ALU_A;
	wire [15:0] ALU_B;
	wire [15:0] ALU_out;
	
	initial PC = 15'h2400;
	
	Registers Reg_Module(clk, r1, r2, r_in, r_w, r1_out, r2_out);
	//ALU ALU_Module(ALU_inst, ALU_A, ALU_B, ALU_out);
	
	//assign memory_addr = (state == fetch || state == load2 || state == store2) ? PC :
	//									(state == load3 || state == store3) ? data_out[14:0] : 
	//																state == storeR2 ? r2_out[14:0] : 15'd0; // (ns == push2 || ns == pop2) ? SP
						
	//assign write = state == store3 || state == storeR2 ? 1'd1 : 1'd0; //|| ns == push2)
	//assign data_in = state == store3 || state == storeR2 ? r1_out : 16'd0;

	//assign r_in = data_out;//(r_w == 1 ? data_out: r_in);/*state == ALU2 ? ALU_out : */
	//assign r_w = state == load4 /*|| state == ALU2 */?  1'd1 : 1'd0; //ns == pop3 || 
	//assign r1 = (ns == jmp2 || ns == ALU2) ? 5'd10 : register1;
	//assign r1 = inst_reg1;
	//assign r2 = inst_reg2;
	
	//assign ALU_inst = opcode;
	//assign ALU_A = r1_out;
	//assign ALU_B =	r2_out;
	
	parameter /*nop = 6'd0,*/ load = 6'd1, store = 6'd2, storeR = 6'd21;//, move = 6'd3, _not = 6'd4, _and = 6'd5, _or = 6'd6;
	//parameter shiftr = 6'd7, shiftl = 6'd8, add = 6'd9, sub = 6'd10, test = 6'd11, jmpEq = 6'd12, jmpLE = 6'd13;
	//parameter jmpGE = 6'd14, jmpL = 6'd15, jmpG = 6'd16, jmp = 6'd17, call = 6'd18, storeR = 6'd21, jmpF = 6'd22, reset = 6'd20, jmpNE = 6'd19; //push = 6'd19, pop = 6'd20,  jmpNE = 6'd22;
	
	parameter fetch = 6'd0, inst = 6'd14, load2 = 6'd15, store2 = 6'd3, load3 = 6'd4, ALU2 = 6'd5, jmp2 = 6'd6;//, pop2 = 6'd7, pop3 = 6'd8, push2 = 6'd9;
	parameter load4 = 6'd10, store3 = 6'd11, storeR2 = 6'd12, storeR3 = 6'd13;
	//parameter cmp = 5'd10;
	
	always@(*)
	begin
		memory_addr = PC;
		write = 1'd0;
		data_in = r1_out;
		r_in = data_out;
		r_w = 1'd0;
		r1 = inst_reg1;
		r2 = inst_reg2;
		
		if(state == load2)
		begin
			memory_addr = data_out[14:0];
			write = 1'd0;
			data_in = r1_out;
			r_in = data_out;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == store2)
		begin
			memory_addr = data_out[14:0]; 
			write = 1'd1;
			data_in = r1_out;
			r_in = data_out;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		
		else if(state == storeR2)
		begin
			memory_addr = r2_out[14:0];
			write = 1'd1;
			data_in = r1_out;
			r_in = data_out;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == load3)
		begin
			memory_addr = PC;
			write = 1'd0;
			data_in = r1_out;
			r_in = data_out;
			r_w = 1'd1;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
	end
	
	always@(posedge clk)
	begin
		
		case(state)
			fetch:
			begin
				PC <= PC + 1'd1;
				state <= inst;
			end
			inst:
			begin
				opcode <= data_out[5:0];
				inst_reg1 <= data_out[10:6];
				inst_reg2 <= data_out[15:11];
				case(data_out[5:0])
					//nop:
					//	state <= fetch;
					//reset:
					//begin
					//	PC <= 15'h2400;
					//	state <= fetch;
					//end
					load:
					begin
						PC <= PC + 15'd1;
						state <= load2;
					end
					store:
					begin 
						PC <= PC + 15'd1;
						state <= store2;
					end
					storeR:
						state <= storeR2;
					//move, _not, _and, _or, shiftr, shiftl, add, sub, test:
					//	state <= ALU2;
					//jmpEq, jmpLE, jmpGE, jmpL, jmpG, jmp, call, jmpNE:
					//	begin
					//	begin
					//	if(data_out[5:0] == call)
					//		PCP <= PC;
					//	ns <= jmp2;
					//	end
					//jmpF:
					//begin
					//	if(data_out[5:0] == jmpF)
					//		PC <= PCP + 15'd1;
					//end			
					//push:
					//	ns <= push2;
					//pop:
					//begin
					//	SP <= SP - 15'd1;
					//	ns <= pop2;
					//end
				endcase
			end
			//jmp2:
			//begin
			//	case(opcode)
			//		jmpEq:
//					begin
//						if(r1_out == 0)
//							PC <= data_out[14:0];
//					end
//					jmpNE:
//					begin
//						if(r1_out != 0)
//							PC <= data_out[14:0];
//					end
//					jmpGE:
//					begin
//						if(r1_out >= 0)
//							PC <= data_out[14:0];
//					end
//					jmpLE:
//					begin
//						if(r1_out <= 0)
//							PC <= data_out[14:0];
//					end
//					jmpL:
//					begin
//						if(r1_out < 0)
//							PC <= data_out[14:0];
//					end
//					jmpG:
//					begin
//						if(r1_out > 0)
//							PC <= data_out[14:0];
//					end
//					default:
//						PC <= data_out[14:0];
//				endcase
//				ns	<= fetch;
//			end
			//ALU2:
			//begin;
			//	PC <= PC + 15'd1;
			//	state <= fetch;
			//end
			storeR2:
			begin
				state <= storeR3;
			end
			storeR3:
			begin
				state <= fetch;
			end
			load2:
			begin
				state <= load3;
			end
			store2:
			begin
				state <= fetch;
			end
			load3:
			begin
				state <= fetch;
			end
			//pop2:
			//	ns <= pop3;
			//pop3:
			//	ns <= inst;
			//push2:
			//begin
			//	SP <= SP + 15'd1;
			//	ns <= fetch;
			//end
		endcase
	end
endmodule
