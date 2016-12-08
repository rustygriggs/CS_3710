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
	input [7:0]debug_sw,
	input debug_btn,
	output reg [15:0] data_in,
	output reg [14:0] memory_addr,
	output reg write,
	output [15:0]debug_out
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
	reg [14:0] addr;
	reg [15:0] data;
	reg [15:0] register1;
	reg [15:0] register2;
	
	reg [15:0] instruction;
	wire [15:0]reg_out;
	
	initial PC = 15'h2400;
	
	assign debug_out = debug_sw == 8'b10000000 ? instruction : 
							debug_sw == 8'b01000000 ? {1'd0, PC} : reg_out;
	
	Registers Reg_Module(clk, r1, r2, r_in, r_w, debug_sw[4:0], r1_out, r2_out, reg_out);
	
	ALU ALU_Module(ALU_inst, ALU_A, ALU_B, ALU_out);
	
	assign ALU_inst = opcode;
	assign ALU_A = register1;
	assign ALU_B =	register2;
	
	parameter nop = 6'd0, load = 6'd1, store = 6'd2, loadi = 6'd3, storeR = 6'd4, move = 6'd5;
	parameter _not = 6'd6, _and = 6'd7, _or = 6'd8, shiftr = 6'd9, shiftl = 6'd10, add = 6'd11;
   parameter sub = 6'd12, test = 6'd13, jmpEq = 6'd14, jmpNE = 6'd15, jmpLE = 6'd16, jmpGE = 6'd17;
	parameter jmpL = 6'd18, jmpG = 6'd19, jmpF = 6'd20, jmp = 6'd21, call = 6'd22, push = 6'd23;
   parameter pop = 6'd24, reset = 6'd25, loadR = 6'd26, cmpC = 6'd27;
	
	parameter fetch = 6'd0, inst = 6'd1, load2 = 6'd2, load3 = 6'd3, store2 = 6'd4, loadi2 = 6'd5;
	parameter storeR2 = 6'd6, ALU2 = 6'd7, jmp2 = 6'd8, push2 = 6'd9, pop2 = 6'd10, pop3 = 6'd11;
	parameter test2 = 6'd12, test3 = 6'd13, loadR2 = 6'd14, loadR3 = 6'd15, load4 = 6'd16, store3 = 6'd17;
	parameter load5 = 6'd18, loadR4 = 6'd19, loadR5 = 6'd20, jmp3 = 6'd21, ALU3 = 6'd22, ALU4 = 6'd24;
	parameter storeR3 = 6'd25, loadi3 = 6'd26, test4 = 6'd27, pop4 = 6'd28, push3 = 6'd29, fetch2 = 6'd30;
	parameter storeR4 = 6'd31, store4 = 6'd32;
	
	always@(*)
	begin
		memory_addr = PC;
		write = 1'd0;
		data_in = register1;
		r_in = data;
		r_w = 1'd0;
		r1 = inst_reg1;
		r2 = inst_reg2;
		
		if(state == load3)
		begin
			memory_addr = addr;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		if(state == load4)
		begin
			memory_addr = addr;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == load5)
		begin
			memory_addr = PC;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd1;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == loadi3)
		begin
			memory_addr = PC;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd1;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		if(state == loadR3)
		begin
			memory_addr = addr;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		if(state == loadR4)
		begin
			memory_addr = addr;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		if(state == loadR5)
		begin
			memory_addr = PC;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd1;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == store3)
		begin
			memory_addr = addr;
			write = 1'd1;
			data_in = register1;
			r_in = data;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == store4)
		begin
			memory_addr = addr;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == storeR3)
		begin
			memory_addr = addr;
			write = 1'd1;
			data_in = register1;
			r_in = data;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == storeR4)
		begin
			memory_addr = addr;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == ALU4)
		begin 
			memory_addr = PC;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd1;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == test4)
		begin 
			memory_addr = PC;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd1;
			r1 = 5'd28;
			r2 = inst_reg2;
		end
		else if(state == jmp2)
		begin 
			memory_addr = PC;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd0;
			r1 = 5'd28;
			r2 = inst_reg2;
		end
		else if(state == pop2)
		begin 
			memory_addr = SP;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == pop4)
		begin 
			memory_addr = PC;
			write = 1'd0;
			data_in = register1;
			r_in = data;
			r_w = 1'd1;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
		else if(state == push3)
		begin 
			memory_addr = SP;
			write = 1'd1;
			data_in = register1;
			r_in = data;
			r_w = 1'd0;
			r1 = inst_reg1;
			r2 = inst_reg2;
		end
	end
	
	//reg core_state = 0;
	
	//always@(posedge clk)
	//begin
	//	core_state <= ~core_state;
	//end
	
	always@(posedge clk)
	begin
		//if(core_state == 2'd3)
		//begin
			case(state)
				fetch:
				begin
					if(debug_btn || debug_sw[5])
					begin
						PC <= PC + 1'd1;
						state <= inst;
					end
					else
					begin
						state <= fetch;
					end
				end
				inst:
				begin
					opcode = data_out[5:0];
					inst_reg1 = data_out[10:6];
					inst_reg2 = data_out[15:11];
					instruction = data_out[15:0];
					case(opcode)
						nop:
						begin
							state <= fetch;
						end
						reset:
						begin
							PC <= 15'h2400;
							state <= fetch;
						end
						load:
						begin
							state <= load2;
						end
						loadi:
						begin
							state <= loadi2;
						end
						store:
						begin 
							state <= store2;
						end
						storeR:
						begin
							state <= storeR2;
						end
						loadR:
						begin
							state <= loadR2;
						end
						move, _not, _and, _or, shiftr, shiftl, add, sub:
						begin
							state <= ALU2;
						end
						test:
						begin
							state <= test2;
						end
						jmpEq, jmpNE, jmpLE, jmpGE, jmpL, jmpG, jmp, call:
						begin
							if(opcode == call)
								PCP <= PC + 1'd1;	
							state <= jmp2;
						end
						jmpF:
						begin
							PC <= PCP;
							state <= fetch;
						end			
						push:
						begin
							state <= push2;
						end
						pop:
						begin
							SP <= SP - 15'd1;
							state <= pop2;
						end
					endcase
				end
				jmp2:
				begin
					register1 <= r1_out;
					state <= jmp3;
				end
				jmp3:
				begin
					case(opcode)
						jmpEq:
						begin
							if(register1 == 0)
								PC <= data_out[14:0];
							else
								PC <= PC + 1'd1;
						end
						jmpNE:
						begin
							if(register1 != 0)
								PC <= data_out[14:0];
							else
								PC <= PC + 1'd1;
						end
						jmpGE:
						begin
							if(register1 >= 0)
								PC <= data_out[14:0];
							else
								PC <= PC + 1'd1;
						end
						jmpLE:
						begin
							if(register1[15] == 1 || register1 == 0)
								PC <= data_out[14:0];
							else
								PC <= PC + 1'd1;
						end
						jmpL:
						begin
							if(register1[15] == 1)
								PC <= data_out[14:0];
							else
								PC <= PC + 1'd1;
						end
						jmpG:
						begin
							if(register1 > 0)
								PC <= data_out[14:0];
							else
								PC <= PC + 1'd1;
						end
						default:
							PC <= data_out[14:0];
					endcase
					state	<= fetch;
				end
				ALU2:
				begin
					register1 <= r1_out;
					register2 <= r2_out;
					state <= ALU3;
				end
				ALU3:
				begin
					data <= ALU_out;
					state <= ALU4;
				end
				ALU4:
				begin
					state <= fetch;
				end
				test2:
				begin
					register1 <= r1_out;
					register2 <= r2_out;
					state <= test3;
				end
				test3:
				begin
					data <= ALU_out;
					state <= test4;
				end
				test4:
				begin
					state <= fetch;
				end
				load2:
				begin
					PC <= PC + 15'd1;
					addr <= data_out[14:0];
					state <= load3;
				end
				load3:
				begin
					state <= load4;
				end
				load4:
				begin
					data <= data_out;
					state <= load5;
				end
				load5:
				begin
					state <= fetch;
				end
				loadi2:
				begin
					PC <= PC + 15'd1;
					data <= data_out;
					state <= loadi3;
				end
				loadi3:
				begin
					state <= fetch;
				end
				loadR2:
				begin
					addr <= r2_out[14:0];
					state <= loadR3;
				end
				loadR3:
				begin
					state <= loadR4;
				end
				loadR4:
				begin
					data <= data_out;
					state <= loadR5;
				end
				loadR5:
				begin
					state <= fetch;
				end
				store2:
				begin
					PC <= PC + 15'd1;
					addr <= data_out[14:0];
					register1 <= r1_out;
					state <= store3;
				end
				store3:
				begin
					state <= store4;
				end
				store4:
				begin
					state <= fetch;
				end
				storeR2:
				begin
					register1 <= r1_out;
					addr <= r2_out[14:0];
					state <= storeR3;
				end
				storeR3:
				begin
					state <= storeR4;
				end
				storeR4:
				begin
					state <= fetch;
				end
				pop2:
				begin
					state <= pop3;
				end
				pop3:
				begin
					data <= data_out;
					state <= pop4;
				end
				pop4:
				begin
					state <= fetch;
				end
				push2:
				begin
					register1 <= r1_out;
					state <= push3;
				end
				push3:
				begin
					SP <= SP + 15'd1;
					state <= fetch;
				end
			endcase
		//end
	end
endmodule
