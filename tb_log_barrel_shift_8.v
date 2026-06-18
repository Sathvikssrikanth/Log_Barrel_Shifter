`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2026 19:43:58
// Design Name: 
// Module Name: tb_log_barrel_shift_8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_log_barrel_shift_8;

  reg  [7:0] din;
  reg  [2:0] shift_amt;
  reg        right_left;     // right = 0, left = 1
  wire [7:0] dout;

  // Instantiate DUT
  log_barrel_shift_8 dut (
    .din(din),
    .shift_amt(shift_amt),
    .right_left(right_left),
    .dout(dout)
  );

  initial begin

    right_left = 1'b0; //Performing right shift
    din = 8'b00000001; shift_amt = 3'd0; #10;
    din = 8'b10000000; shift_amt = 3'd1; #10;
    din = 8'b01000000; shift_amt = 3'd4; #10;
    din = 8'b10000000; shift_amt = 3'd6; #10;

    right_left = 1'b1; //Performing left shift
    din = 8'b00000100; shift_amt = 3'd0; #10;
    din = 8'b00000001; shift_amt = 3'd1; #10;
    din = 8'b00000010; shift_amt = 3'd5; #10;
    din = 8'b00000001; shift_amt = 3'd7; 

    $display("Testbench complete.");
    #10;
    $finish;
  end

  initial begin
    $dumpfile("log_barrel_shift_8.vcd");
    $dumpvars(1, tb_log_barrel_shift_8);
  end

endmodule