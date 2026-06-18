`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2026 19:42:29
// Design Name: 
// Module Name: log_barrel_shift_8
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


module log_barrel_shift_8(
    input  [7:0] din,
    input  [2:0] shift_amt,
    input        right_left,      //right = 0, left = 1
    output [7:0] dout
);

  wire a0, a1, a2, a3, a4, a5, a6, a7;
  wire w0, w1, w2, w3, w4, w5, w6, w7;
  wire r0, r1, r2, r3, r4, r5, r6, r7;
  wire b0, b1, b2, b3, b4, b5, b6, b7;

    //To select input order based on left/right shift
    mux2x1 s1(.a(din[0]), .b(din[7]), .sel(right_left), .y(a0));
    mux2x1 s2(.a(din[1]), .b(din[6]), .sel(right_left), .y(a1));
    mux2x1 s3(.a(din[2]), .b(din[5]), .sel(right_left), .y(a2));
    mux2x1 s4(.a(din[3]), .b(din[4]), .sel(right_left), .y(a3));
    mux2x1 s5(.a(din[4]), .b(din[3]), .sel(right_left), .y(a4));
    mux2x1 s6(.a(din[5]), .b(din[2]), .sel(right_left), .y(a5));
    mux2x1 s7(.a(din[6]), .b(din[1]), .sel(right_left), .y(a6));
    mux2x1 s8(.a(din[7]), .b(din[0]), .sel(right_left), .y(a7));
    
    //First stage with 4 shift
    mux2x1 s9(.a(a0), .b(a4), .sel(shift_amt[2]), .y(w0));
    mux2x1 s10(.a(a1), .b(a5), .sel(shift_amt[2]), .y(w1));
    mux2x1 s11(.a(a2), .b(a6), .sel(shift_amt[2]), .y(w2));
    mux2x1 s12(.a(a3), .b(a7), .sel(shift_amt[2]), .y(w3));
    mux2x1 s13(.a(a4), .b(1'b0), .sel(shift_amt[2]), .y(w4));
    mux2x1 s14(.a(a5), .b(1'b0), .sel(shift_amt[2]), .y(w5));
    mux2x1 s15(.a(a6), .b(1'b0), .sel(shift_amt[2]), .y(w6));
    mux2x1 s16(.a(a7), .b(1'b0), .sel(shift_amt[2]), .y(w7));
    
    //Second stage with 2 shift
    mux2x1 s17(.a(w0), .b(w2), .sel(shift_amt[1]), .y(r0));
    mux2x1 s18(.a(w1), .b(w3), .sel(shift_amt[1]), .y(r1));
    mux2x1 s19(.a(w2), .b(w4), .sel(shift_amt[1]), .y(r2));
    mux2x1 s20(.a(w3), .b(w5), .sel(shift_amt[1]), .y(r3));
    mux2x1 s21(.a(w4), .b(w6), .sel(shift_amt[1]), .y(r4));
    mux2x1 s22(.a(w5), .b(w7), .sel(shift_amt[1]), .y(r5));
    mux2x1 s23(.a(w6), .b(1'b0), .sel(shift_amt[1]), .y(r6));
    mux2x1 s24(.a(w7), .b(1'b0), .sel(shift_amt[1]), .y(r7));
    
    //Third stage with 1 shift
    mux2x1 s25(.a(r0), .b(r1), .sel(shift_amt[0]), .y(b0));
    mux2x1 s26(.a(r1), .b(r2), .sel(shift_amt[0]), .y(b1));
    mux2x1 s27(.a(r2), .b(r3), .sel(shift_amt[0]), .y(b2));
    mux2x1 s28(.a(r3), .b(r4), .sel(shift_amt[0]), .y(b3));
    mux2x1 s29(.a(r4), .b(r5), .sel(shift_amt[0]), .y(b4));
    mux2x1 s30(.a(r5), .b(r6), .sel(shift_amt[0]), .y(b5));
    mux2x1 s31(.a(r6), .b(r7), .sel(shift_amt[0]), .y(b6));
    mux2x1 s32(.a(r7), .b(1'b0), .sel(shift_amt[0]), .y(b7));
    
    //To select the outputs order based on left/right shift
    mux2x1 s33(.a(b0), .b(b7), .sel(right_left), .y(dout[0]));
    mux2x1 s34(.a(b1), .b(b6), .sel(right_left), .y(dout[1]));
    mux2x1 s35(.a(b2), .b(b5), .sel(right_left), .y(dout[2]));
    mux2x1 s36(.a(b3), .b(b4), .sel(right_left), .y(dout[3]));
    mux2x1 s37(.a(b4), .b(b3), .sel(right_left), .y(dout[4]));
    mux2x1 s38(.a(b5), .b(b2), .sel(right_left), .y(dout[5]));
    mux2x1 s39(.a(b6), .b(b1), .sel(right_left), .y(dout[6]));
    mux2x1 s40(.a(b7), .b(b0), .sel(right_left), .y(dout[7]));

endmodule

module mux2x1(
    input wire a, 
    input wire b, 
    input wire sel,
    output wire y
);

wire nsel;
wire w1, w2;

not(nsel, sel);
and(w1, a, nsel);
and(w2, b, sel);
or(y, w1, w2);

endmodule