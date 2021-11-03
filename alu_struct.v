`timescale 1ns/10ps

//================================================

// ALU Design description
// ALU  Functional Specification :
//
//	inputs: 2 x 32-bit operands A, B, 4-bit control signal
//
//	outputs: 32-bit result S, 1-bit carry_out, 1 bit overflow , 1-bit zero
//
//	Operations :
//
//	arithmetic: add, sub
//
//	logical: and, xor, or, sll, srl
//
//	conditional: slt, sltu
//

// Create   Date: 27.10.2021

// Written by: Payal Mohapatra
//================================================



// Top module
module alu_struct (a, b, control, carry_out, overflow, zero, result);
   input [31:0]a,b;
   input [3:0]control; 
   output [31:0]result;
   output overflow, zero, carry_out;
   wire [31:0] and_output, xor_output, or_output, sll_output, srl_output,
               add_output,sub_output,
	       slt_output,sltu_output;
   wire add_carry_out_tmp, add_overflow_tmp, sub_carry_out_tmp, sub_overflow_tmp;
   wire zero_tmp;
   // Arithmetical operation
   ripple_carry_adder_subtractor add_oprtn(.S(add_output), .C(add_carry_out_tmp), .V(add_overflow_tmp), .A(a), .B(b), .Op(0));
   ripple_carry_adder_subtractor sub_oprtn(.S(sub_output), .C(sub_carry_out_tmp), .V(sub_overflow_tmp), .A(a), .B(b), .Op(1));
   
   // Logical operation 
   and_gate_32 and_oprtn(.x(a),.y(b),.z(and_output));
   xor_gate_32 xor_oprtn(.x(a),.y(b),.z(xor_output));
   or_gate_32 or_oprtn(.x(a),.y(b),.z(or_output));
   shift_right shft_right_inst (a, b, srl_output);
   shift_left shft_left_inst (a, b, sll_output);
   
   // Conditional operation
   slt slt_inst(a, b, slt_output);
   sltu sltu_inst(a, b, sltu_output);

   // Following the below mapping
   // Operation --  Sel
   // Add           0
   // Sub           1
   // And           2
   // Xor           3
   // Or            4
   // SLL           5
   // SRL           6
   // SLT           7
   // SLTU          8
   mux9to1 alu_mux_cntrl_inst({28'b0,(control)},
                             add_output, 
                             sub_output, 
                             and_output, 
                             xor_output, 
                             or_output, 
                             sll_output, 
                             srl_output, 
                             slt_output, 
                             sltu_output, 
			     result
		             );
   // Generate Z			     
   //xor_gate_32 zero_inst(0,result,zero_tmp);			    
   zero_detect zero_detect_inst(result,zero); 
   //assign zero = zero_tmp;

   // Generate Carry_out
   mux cout_gen_inst (control[0],add_carry_out_tmp, sub_carry_out_tmp, carry_out);
   
   // Generate Carry_out
   mux overflow_gen_inst (control[0],add_overflow_tmp, sub_overflow_tmp, overflow);

endmodule
module zero_detect(a,z);
   input [31:0] a;
   output z;
   wire tmp_1,
        tmp_2,
        tmp_3,
        tmp_4,
        tmp_5,
        tmp_6,
        tmp_7,
        tmp_8,
        tmp_9,
        tmp_10,
        tmp_11,
        tmp_12,
        tmp_13,
        tmp_14,
        tmp_15,
        tmp_16,
        tmp_17,
        tmp_18,
        tmp_19,
        tmp_20,
        tmp_21,
        tmp_22,
        tmp_23,
        tmp_24,
        tmp_25,
        tmp_26,
        tmp_27,
        tmp_28,
        tmp_29,
        tmp_30; 
   or_gate or_gate_inst1(a[31], a[30], tmp_1);
   or_gate or_gate_inst2(tmp_1, a[29], tmp_2);
   or_gate or_gate_inst3(tmp_2, a[28], tmp_3);
   or_gate or_gate_inst4(tmp_3, a[27], tmp_4);
   or_gate or_gate_inst5(tmp_4, a[26], tmp_5);
   or_gate or_gate_inst6(tmp_5, a[25], tmp_6);
   or_gate or_gate_inst7(tmp_6, a[24], tmp_7);
   or_gate or_gate_inst8(tmp_7, a[23], tmp_8);
   or_gate or_gate_inst9(tmp_8, a[22], tmp_9);
   or_gate or_gate_inst10(tmp_9, a[21], tmp_10);
   or_gate or_gate_inst11(tmp_10, a[20], tmp_11);
   or_gate or_gate_inst12(tmp_11, a[19], tmp_12);
   or_gate or_gate_inst13(tmp_12, a[18], tmp_13);
   or_gate or_gate_inst14(tmp_13, a[17], tmp_14);
   or_gate or_gate_inst15(tmp_14, a[16], tmp_15);
   or_gate or_gate_inst16(tmp_15, a[15], tmp_16);
   or_gate or_gate_inst17(tmp_16, a[14], tmp_17);
   or_gate or_gate_inst18(tmp_17, a[13], tmp_18);
   or_gate or_gate_inst19(tmp_18, a[12], tmp_19);
   or_gate or_gate_inst20(tmp_19, a[11], tmp_20);
   or_gate or_gate_inst21(tmp_20, a[10], tmp_21);
   or_gate or_gate_inst22(tmp_21, a[9], tmp_22);
   or_gate or_gate_inst23(tmp_22, a[8], tmp_23);
   or_gate or_gate_inst24(tmp_23, a[7], tmp_24);
   or_gate or_gate_inst25(tmp_24, a[6], tmp_25);
   or_gate or_gate_inst26(tmp_25, a[5], tmp_26);
   or_gate or_gate_inst27(tmp_26, a[4], tmp_27);
   or_gate or_gate_inst28(tmp_27, a[3], tmp_28);
   or_gate or_gate_inst29(tmp_28, a[2], tmp_29);
   or_gate or_gate_inst30(tmp_29, a[1], tmp_30);
   nor_gate or_gate_inst31(tmp_30, a[0], z);
endmodule
//////////////////// Modules for individual operations /////////////////
// Arithmetic
// ADD
// 1-bit full adder
module full_adder(S, Cout, A, B, Cin);

   output S;
   output Cout;
   input  A;
   input  B;
   input  Cin;
   wire   w1;
   wire   w2;
   wire   w3;
   wire   w4;
   wire   temp;

   xor_gate logic_inst1(A, B, w1);
   xor_gate logic_inst2(Cin, w1, S);
   and_gate logic_inst3(A, B, w2);   
   and_gate logic_inst4(A, Cin, w3);
   and_gate logic_inst5(B, Cin, w4);   
   
   or_gate logic_inst6(w2, w3, temp);
   or_gate logic_inst7(temp, w4, Cout);

endmodule // full_adder

module ripple_carry_adder_subtractor(S, C, V, A, B, Op);

   output [31:0] S;   // The 32-bit sum/difference.
   output 	C;   // The 1-bit carry/borrow status.
   output 	V;   // The 1-bit overflow status.
   input [31:0] 	A;   // The 32-bit augend/minuend.
   input [31:0] 	B;   // The 32-bit addend/subtrahend.
   input 	Op;  // The operation: 0 => Add, 1=>Subtract.

   wire 	C0; 
   wire 	C1; 
   wire 	C2; 
   wire         C3; 
   wire         C4; 
   wire         C5; 
   wire         C6; 
   wire         C7; 
   wire         C8; 
   wire         C9; 
   wire         C10;
   wire         C11;
   wire         C12;
   wire         C13;
   wire         C14;
   wire         C15;
   wire         C16;
   wire         C17;
   wire         C18;
   wire         C19;
   wire         C20;
   wire         C21;
   wire         C22;
   wire         C23;
   wire         C24;
   wire         C25;
   wire         C26;
   wire         C27;
   wire         C28;
   wire         C29;
   wire         C30;
   wire 	C31; // The carry out bit of fa2, used to generate final carry/borrrow.

   // xored result of B with op to get B or (not)B
   wire        B0;
   wire        B1;
   wire        B2;
   wire        B3;
   wire        B4;
   wire        B5;
   wire        B6;
   wire        B7;
   wire        B8;
   wire        B9;
   wire        B10;
   wire        B11;
   wire        B12;
   wire        B13;
   wire        B14;
   wire        B15;
   wire        B16;
   wire        B17;
   wire        B18;
   wire        B19;
   wire        B20;
   wire        B21;
   wire        B22;
   wire        B23;
   wire        B24;
   wire        B25;
   wire        B26;
   wire        B27;
   wire        B28;
   wire        B29;
   wire        B30;
   wire        B31; // The carry out bit of fa2, used to generate final carry/borrrow.

   // Looking at the truth table for xor we see that
   // Property of XOR -- A (xor) 0 = A
   // Property of XOR -- A (xor) 1 = not(A)
   // So, if Op==1 means we are subtracting, then
   // adding A and B xor Op alog with setting the first
   // carry bit to Op, will give us a result of
   // A+B when Op==0, and A+not(B)+1 when Op==1.
   // Note that not(B)+1 is the 2's complement of B, so
   // this gives us subtraction.
   xor_gate xor_inst1 (B[0], Op, B0);
   xor_gate xor_inst2 (B[1], Op, B1);
   xor_gate xor_inst3 (B[2], Op, B2);
   xor_gate xor_inst4 (B[3], Op, B3);
   xor_gate xor_inst5 (B[4], Op, B4);
   xor_gate xor_inst6 (B[5], Op, B5);
   xor_gate xor_inst7 (B[6], Op, B6);
   xor_gate xor_inst8 (B[7], Op, B7);
   xor_gate xor_inst9 (B[8], Op, B8);
   xor_gate xor_inst10 (B[9], Op, B9);
   xor_gate xor_inst11 (B[10], Op, B10);
   xor_gate xor_inst12 (B[11], Op, B11);
   xor_gate xor_inst13 (B[12], Op, B12);
   xor_gate xor_inst14 (B[13], Op, B13);
   xor_gate xor_inst15 (B[14], Op, B14);
   xor_gate xor_inst16 (B[15], Op, B15);
   xor_gate xor_inst17 (B[16], Op, B16);
   xor_gate xor_inst18 (B[17], Op, B17);
   xor_gate xor_inst19 (B[18], Op, B18);
   xor_gate xor_inst20 (B[19], Op, B19);
   xor_gate xor_inst21 (B[20], Op, B20);
   xor_gate xor_inst22 (B[21], Op, B21);
   xor_gate xor_inst23 (B[22], Op, B22);
   xor_gate xor_inst24 (B[23], Op, B23);
   xor_gate xor_inst25 (B[24], Op, B24);
   xor_gate xor_inst26 (B[25], Op, B25);
   xor_gate xor_inst27 (B[26], Op, B26);
   xor_gate xor_inst28 (B[27], Op, B27);
   xor_gate xor_inst29 (B[28], Op, B28);
   xor_gate xor_inst30 (B[29], Op, B29);
   xor_gate xor_inst31 (B[30], Op, B30);
   xor_gate xor_inst32 (B[31], Op, B31);
   
   //xor_gate xor_inst33 (C31, Op, C); //FIXME:: Do I need to invert carry for sub? // Carry = C31 for addition, Carry = not(C31) for subtraction.
   xor_gate xor_inst34 (C31, C30, V);  // If the two most significant carry output bits differ, then we have an overflow.

   full_adder fa0(S[0], C0, A[0], B0, Op);    // Least significant bit.
   full_adder fa1(S[1], C1, A[1], B1, C0);
   full_adder fa2(S[2], C2, A[2], B2, C1);
   full_adder fa3(S[3], C3, A[3], B3, C2);
   full_adder fa4(S[4], C4, A[4], B4, C3);
   full_adder fa5(S[5], C5, A[5], B5, C4);
   full_adder fa6(S[6], C6, A[6], B6, C5);
   full_adder fa7(S[7], C7, A[7], B7, C6);
   full_adder fa8(S[8], C8, A[8], B8, C7);
   full_adder fa9(S[9], C9, A[9], B9, C8);
   full_adder fa10(S[10], C10, A[10], B10, C9);
   full_adder fa11(S[11], C11, A[11], B11, C10);
   full_adder fa12(S[12], C12, A[12], B12, C11);
   full_adder fa13(S[13], C13, A[13], B13, C12);
   full_adder fa14(S[14], C14, A[14], B14, C13);
   full_adder fa15(S[15], C15, A[15], B15, C14);
   full_adder fa16(S[16], C16, A[16], B16, C15);
   full_adder fa17(S[17], C17, A[17], B17, C16);
   full_adder fa18(S[18], C18, A[18], B18, C17);
   full_adder fa19(S[19], C19, A[19], B19, C18);
   full_adder fa20(S[20], C20, A[20], B20, C19);
   full_adder fa21(S[21], C21, A[21], B21, C20);
   full_adder fa22(S[22], C22, A[22], B22, C21);
   full_adder fa23(S[23], C23, A[23], B23, C22);
   full_adder fa24(S[24], C24, A[24], B24, C23);
   full_adder fa25(S[25], C25, A[25], B25, C24);
   full_adder fa26(S[26], C26, A[26], B26, C25);
   full_adder fa27(S[27], C27, A[27], B27, C26);
   full_adder fa28(S[28], C28, A[28], B28, C27);
   full_adder fa29(S[29], C29, A[29], B29, C28);
   full_adder fa30(S[30], C30, A[30], B30, C29);    
   full_adder fa31(S[31], C31, A[31], B31, C30);    // Most significant bit
   assign C = C31;
endmodule

// 9:1 Mux from a 2:1 Mux from Lib and 8:1 Mux
module mux9to1(sel,a0,a1,a2,a3,a4,a5,a6,a7,a8,out);
 
         input [31:0] a0,a1,a2,a3,a4,a5,a6,a7,a8;
 
         input [31:0] sel;//we need only 3 bits here
 
         output [31:0] out;
 
         wire [31:0] mux_1, mux_2;
 
         mux8to1 m1  ({29'b0,sel[2:0]},a0,a1,a2,a3,a4,a5,a6,a7,mux_1),
                 m2  ({29'b0,sel[2:0]},a8,0,0,0,0,0,0,0,mux_2);
         mux_32  m3 ({31'b0,sel[3]},mux_1,mux_2,out);
 
 endmodule


module mux4to1(sel,a0,a1,a2,a3,out); // Follow the convention being followed in the library

	input [31:0] a0,a1,a2,a3;
	input [31:0] sel; // Although we need only 2 bits here
	output [31:0]out;


	wire [31:0]mux_1,mux_2;

	mux_32  m1 ({31'b0,sel[0]}, a0, a1, mux_1),
                m2 ({31'b0,sel[0]}, a2, a3, mux_2),
	        m3 ({31'b0,sel[1]}, mux_1, mux_2,out);

endmodule



module mux8to1(sel,a0,a1,a2,a3,a4,a5,a6,a7,out);

	input [31:0] a0,a1,a2,a3,a4,a5,a6,a7;

	input [31:0] sel;//we need only 3 bits here

	output [31:0] out;

	wire [31:0] mux_1, mux_2;

	mux4to1 m1  ({30'b0,sel[1:0]},a0,a1,a2,a3,mux_1),
	        m2  ({30'b0,sel[1:0]},a4,a5,a6,a7,mux_2);
	mux_32   m3 ({31'b0,sel[2]},mux_1,mux_2,out);

endmodule

module mux32to1(sel,a0,a1,a2,a3,a4,a5,a6,a7,
	           a8,a9,a10,a11,a12,a13,a14,a15,
		   a16,a17,a18,a19,a20,a21,a22,a23,
		   a24,a25,a26,a27,a28,a29,a30,a31,out);
       input [31:0] a0,a1,a2,a3,a4,a5,a6,a7,
                    a8,a9,a10,a11,a12,a13,a14,a15,
                    a16,a17,a18,a19,a20,a21,a22,a23,
                    a24,a25,a26,a27,a28,a29,a30,a31;
       input [31:0] sel;
       output [31:0] out;
       wire [31:0] mux_1, mux_2, mux_3, mux_4;

       mux8to1 m1 ({29'b0,sel[2:0]},a0,a1,a2,a3,a4,a5,a6,a7,mux_1),
               m2 ({29'b0,sel[2:0]},a8,a9,a10,a11,a12,a13,a14,a15,mux_2),
	       m3 ({29'b0,sel[2:0]},a16,a17,a18,a19,a20,a21,a22,a23,mux_3),
	       m4 ({29'b0,sel[2:0]},a24,a25,a26,a27,a28,a29,a30,a31,mux_4);
       mux4to1 mm1 ({30'b0,sel[4:3]},mux_1, mux_2, mux_3, mux_4, out);
endmodule	   
// Logical
// SRL
module shift_right(value, shift_value, out);
       input [31:0]value, shift_value;// Giving shift values > 5bits is of no use
       output [31:0]out;

       mux32to1 slr_mux_inst(shift_value,
               value,
	       {1'b0,value[31:1]},	
	       {2'b0,value[31:2]},	
	       {3'b0,value[31:3]},	
	       {4'b0,value[31:4]},	
	       {5'b0,value[31:5]},	
	       {6'b0,value[31:6]},	
	       {7'b0,value[31:7]},	
	       {8'b0,value[31:8]},	
	       {9'b0,value[31:9]},	
	       {10'b0,value[31:10]},	
	       {11'b0,value[31:11]},	
	       {12'b0,value[31:12]},	
	       {13'b0,value[31:13]},	
	       {14'b0,value[31:14]},	
	       {15'b0,value[31:15]},	
	       {16'b0,value[31:16]},	
	       {17'b0,value[31:17]},	
	       {18'b0,value[31:18]},	
	       {19'b0,value[31:19]},	
	       {20'b0,value[31:20]},	
	       {21'b0,value[31:21]},	
	       {22'b0,value[31:22]},	
	       {23'b0,value[31:23]},	
	       {24'b0,value[31:24]},	
	       {25'b0,value[31:25]},	
	       {26'b0,value[31:26]},	
	       {27'b0,value[31:27]},	
	       {28'b0,value[31:28]},	
	       {29'b0,value[31:29]},	
	       {30'b0,value[31:30]},	
	       {31'b0,value[31]},
               out	       
               );
endmodule
// SLL
module shift_left(value, shift_value, out);

       input [31:0]value, shift_value;// Giving shift values > 5bits is of no use
       output [31:0]out;

       mux32to1 sll_mux_inst(shift_value,

               value,
               {value[30:0],1'b0},
               {value[29:0],2'b0},
               {value[28:0],3'b0},
               {value[27:0],4'b0},
               {value[26:0],5'b0},
               {value[25:0],6'b0},
               {value[24:0],7'b0},
               {value[23:0],8'b0},
               {value[22:0],9'b0},
               {value[21:0],10'b0},
               {value[20:0],11'b0},
               {value[19:0],12'b0},
               {value[18:0],13'b0},
               {value[17:0],14'b0},
               {value[16:0],15'b0},
               {value[15:0],16'b0},
               {value[14:0],17'b0},
               {value[13:0],18'b0},
               {value[12:0],19'b0},
               {value[11:0],20'b0},
               {value[10:0],21'b0},
               {value[9:0],22'b0},
               {value[8:0],23'b0},
               {value[7:0],24'b0},
               {value[6:0],25'b0},
               {value[5:0],26'b0},
               {value[4:0],27'b0},
               {value[3:0],28'b0},
               {value[2:0],29'b0},
               {value[1:0],30'b0},
               {value[0],31'b0},
               out
               );

endmodule




// Conditional
// SLT
module slt(a, b, less);
       input [31:0]a, b;
       output [31:0]less;
       wire [31:0] sub_output;
       wire sub_carry_out_tmp, sub_overflow_tmp, less_tmp;
       ripple_carry_adder_subtractor sub_oprtn(.S(sub_output), .C(sub_carry_out_tmp), .V(sub_overflow_tmp), .A(a), .B(b), .    Op(1));
       xor_gate xor_slt_inst(sub_overflow_tmp,sub_output[31],less_tmp);
       assign less = {31'b0,less_tmp};
endmodule
// SLTU
module sltu(a, b, less);
        input [31:0]a, b;
        output [31:0]less;
        wire [31:0] sub_output;
        wire sub_carry_out_tmp, sub_overflow_tmp, less_tmp;
        ripple_carry_adder_subtractor sub_oprtn(.S(sub_output), .C(sub_carry_out_tmp), .V(sub_overflow_tmp), .A(a), .B(b    ), .    Op(1));
        not_gate not_sltu_inst(sub_carry_out_tmp,less_tmp);
        assign less = {31'b0,less_tmp};
 endmodule
