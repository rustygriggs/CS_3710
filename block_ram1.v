`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:00:07 10/19/2016 
// Design Name: 
// Module Name:    block_ram1 
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
module block_ram1(
  clka,
  wea,
  addra,
  dina,
  douta,
  clkb,
  web,
  addrb,
  dinb,
  doutb
);

input clka;
input [0 : 0] wea;
input [9 : 0] addra;
input [15 : 0] dina;
output [15 : 0] douta;
input clkb;
input [0 : 0] web;
input [9 : 0] addrb;
input [15 : 0] dinb;
output [15 : 0] doutb;

endmodule
