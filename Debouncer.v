`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        School of Computing / University of Utah
// Engineer:       Peter A Jensen (Oblok), pajensen@cs.utah.edu
// 
// Create Date:    2016.23.07 14:30:17
// Last Changes:   2016.09.08 14:50:00
// Design Name: 
// Module Name:    Debouncer 
// Project Name:   P57C
// Target Devices: xc6slx16-3csg324, Nexys 3 Development Board
// Tool versions:  ISE 14.7
// Description:    Cleans up noisy signals, issues pulses or hold (steady state)
//
// Dependencies: 
//
// Revisions: 
// Revision 0.1  - File Created
// Revision 1.0  - Tested, working with25 Mhz clock
// Revision 1.1  - Revised for 100Mhz clock
//
// Additional Comments: 
//     This module can debounce any number of signals - simply set the parameter
// input to indicate the number of bits to be debounced, then send that many
// noisy signals as input.  The user may specify 'pulses', which is useful for
// buttons, or 'hold', which is useful for switches.  In pulse mode, a one-cycle
// pulse will be issued when a signal goes high.  In hold mode, the output will
// be held high as long as the input is high.  Both of these modes reject small
// bounces in the signal - these do not affect the output state.
//////////////////////////////////////////////////////////////////////////////////
module Debouncer
	#(
	parameter BITS_IN_INPUT = 1
	)(
	input                          clk,              // Assumed to be 100Mhz
	input      [BITS_IN_INPUT-1:0] BouncySignals,    // Signals that need to be cleaned up
	input      [BITS_IN_INPUT-1:0] PulseOrHold,      // 0 = output pulse for this bit, 1 = output hold for this bit
	output reg [BITS_IN_INPUT-1:0] DebouncedSignals  // Cleaned up version of the signal
   );
	
	integer i;
	
	// State variables for a counter for generating a pulse about every half millisecond
	// Counting clock cycles [0..50000) would be a half millisecond, but [0..65536) is close enough for debouncing
	
	reg [15:0] ClockCounter;  
	reg        ClockPulse;
	
	initial ClockCounter = 0;
	initial ClockPulse = 0;
	
	// Sequential logic for generating clock pulses about every half millisecond
	
	always@(posedge clk)
	begin
	   // Use the carry out from the clock counter to set the clock pulse.
	
      {ClockPulse, ClockCounter} <= {1'b0, ClockCounter} + 1'b1;
	end
	
	// State variables for debouncing - arrays of saturation counters and current state
	  
	reg  [2:0] BounceCounter [BITS_IN_INPUT-1:0];  // Saturation counters move from [0..7]
   reg        ActiveState   [BITS_IN_INPUT-1:0];  // This reflects our view of what the signal represents.
	
	initial
	begin
		for (i = 0; i < BITS_IN_INPUT; i = i + 1)
		begin
			BounceCounter[i]    = 3'b0;
			ActiveState[i]      = 1'b0;
			DebouncedSignals[i] = 1'b0;
		end
	end

	// Debounce behavioral logic
  
	always@(posedge clk) 
	begin
	   // Reset any pulsed outputs that have been active for one cycle.
		
		for (i = 0; i < BITS_IN_INPUT; i = i + 1)
			if (DebouncedSignals[i] && !PulseOrHold[i])
			  DebouncedSignals[i] <= 0;
			  
		// Only do the saturation checks about every 0.5 ms
		
		if (ClockPulse)
			for (i = 0; i < BITS_IN_INPUT; i = i + 1)
			begin
				// If button appears to be pressed, increment count if not saturated.
				
				if (BouncySignals[i] && BounceCounter[i] != 3'd7)
				begin
					// If we will have reached saturation, update the state (only if needed).
					
					if (BounceCounter[i] == 3'd6 && !ActiveState[i])
					begin
						ActiveState[i]      <= 1; // State visible internal to module
						DebouncedSignals[i] <= 1; // State visible external to module
					end
					
					// Move the counter towards saturation.
					
					BounceCounter[i] <= BounceCounter[i] + 1'b1;			  
				end 
				
				// If button appears to be released, decrement count if not desaturated.
				
				else if ((!BouncySignals[i]) && (BounceCounter[i] != 3'd0))
				begin
					// If we will have reached desaturation, update the state (always).
					
					if (BounceCounter[i] == 3'd1)
					begin
						ActiveState[i]      <= 0; // State visible internal to module
						DebouncedSignals[i] <= 0; // State visible external to module
					end
					
					// Move the counter towards desaturation.
					
					BounceCounter[i] <= BounceCounter[i] - 1'b1;
				end
			end
	end
	
endmodule
