`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:20 11/15/2016 
// Design Name: 
// Module Name:    Keyboard_V2 
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
module Keyboard_V2(
	input extclk, reset,
	input key_clk,
	input key_data,
	output [3:0] en,
   output a, b, c, d, e, f, g, dp,
	output reg [7:0] data_reg
    );

	// Clock management
	wire intclk;
	wire clk;
	IBUFG ibufg_clk (.I(extclk), .O(intclk));
	BUFG	bufg_clk (.I(intclk), .O(clk));

	//7-seg display
	
	// Digit change count
	reg [15:0] dig_count;
	initial dig_count = 0;
	
	// Digit changer
	always@(posedge clk)
	begin
		if(reset)
			dig_count <= 0;
		else
			dig_count <= dig_count + 1'b1;
	end
	
	// Temporary variables to hold 7-seg data	
	reg [7:0] temp;
	reg [3:0] dig_temp;
	reg [3:0] en_temp;
	
	initial temp = 0;
	initial dig_temp = 0;
	initial en_temp = 0;
	
	// Digit selector
	always@(posedge clk)
	begin
		case(dig_count[15:14])
		2'b00: begin
			dig_temp = data_reg[3:0];
			en_temp = 4'b1110;
		end
		2'b01: begin
			dig_temp = data_reg[7:4];
			en_temp = 4'b1101;
		end
		2'b10: begin
			dig_temp = 4'h0;
			en_temp = 4'b1011;
		end
		2'b11: begin
			dig_temp = 4'h0;
			en_temp = 4'b0111;
		end
		
		endcase
	end
	
	assign en = en_temp;
	
	// Digit producer
	always@(*)
	begin
		case(dig_temp)
			4'h0 : temp = 8'b00000011;
			4'h1 : temp = 8'b10011111;
			4'h2 : temp = 8'b00100101;
			4'h3 : temp = 8'b00001101;
			4'h4 : temp = 8'b10011001;
			4'h5 : temp = 8'b01001001;
			4'h6 : temp = 8'b01000001;
			4'h7 : temp = 8'b00011111;
			4'h8 : temp = 8'b00000001;
			4'h9 : temp = 8'b00001001;
			4'hA : temp = 8'b00010001;
			4'hB : temp = 8'b11000001;
			4'hC : temp = 8'b01100011;
			4'hD : temp = 8'b10000101;
			4'hE : temp = 8'b01100001;
			4'hF : temp = 8'b01110001;
			default : temp = 8'b11111101;
		endcase
	end
	
	assign {a,b,c,d,e,f,g,dp} = temp;

	//Keyboard Stuff
	//Output data
	//reg [7:0] data_reg;
	
	reg [3:0] data_count;
	reg [7:0] data_current;
	reg [7:0] data_prev;
	reg flag;
	
	initial data_reg = 8'hf0;
	initial data_count = 4'h1;
	initial data_current = 8'hf0;
	initial data_prev = 8'hf0;
	initial flag = 1'b0;
	
	always@(negedge key_clk) begin
		case(data_count)
			1:;
			2: data_current[0] <= key_data;
			3: data_current[1] <= key_data;
			4: data_current[2] <= key_data;
			5: data_current[3] <= key_data;
			6: data_current[4] <= key_data;
			7: data_current[5] <= key_data;
			8: data_current[6] <= key_data;
			9: data_current[7] <= key_data;
			10: flag <= 1'b1;
			11: flag <= 1'b0;
		endcase
		
		if (data_count <= 4'd10)
			data_count <= data_count + 4'b0001;
		else if (data_count == 4'd11)
			data_count <= 4'd1;
	
		//data_reg <= data_current;
	
	end
	
	always@(posedge flag) begin
		if(data_current == 8'hf0)
			data_reg <= data_prev;
		else
			data_prev <= data_current;
	end
	
endmodule
