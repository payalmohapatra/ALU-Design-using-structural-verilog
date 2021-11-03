`timescale 1ns/10ps
module alu_struct_tb;

   reg [31:0]a;

   reg [31:0]b;

   reg [3:0]control;

   wire overflow, zero, carry_out;
   wire [31:0]result;



alu_struct alu_struct_inst (a, b, control, carry_out, overflow, zero, result);



initial begin
   // Verifying Add operation
   a=32'hFFFFFFFF;
   b=32'hFFFFFFFF;
   control = 4'd0;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   a=32'h00000001;
   b=32'h00000001;
   control = 4'd0;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   a=32'hEFFFFFFF;
   b=32'hEFFFFFFF;
   control = 4'd0;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   a=32'h10000001;
   b=32'h10000001;
   control = 4'd0;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20
   
   a=32'hFFFFFFFF;
   b=32'h00000001;
   control = 4'd0;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   a=32'h80000000;
   b=32'h80000000;
   control = 4'd0;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   // Verifying Sub operation
   a=32'hFFFFFFFF;
   b=32'hFFFFFFFF;
   control = 4'd1;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   a=32'h00000001;
   b=32'h00000001;
   control = 4'd1;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   a=32'hEFFFFFFF;
   b=32'hEFFFFFFF;
   control = 4'd1;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   a=32'h10000001;
   b=32'h10000001;
   control = 4'd1;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   a=32'hFFFFFFFF;
   b=32'h00000001;
   control = 4'd1;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   a=32'h80000000;
   b=32'h70000000;
   control = 4'd1;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20
   
   // AND
   a=32'hFFFFFFFF;
   b=32'hFFFFFFFF;
   control = 4'd2;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   a=0;
   b=32'hFFFFFFFF;
   control = 4'd2;
   $display("Control Signal is %b",control);
   $display("Input A is %b",a);
   $display("Input B is %b",b);
   $display("Output is %b",result);
   #20

   // XOR

   a=32'hFFFFFFFF;

   b=32'hFFFFFFFF;

   control = 4'd3;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20



   a=0;

   b=32'hFFFFFFFF;

   control = 4'd3;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20

// OR

   a=32'hFFFFFFFF;

   b=32'hFFFFFFFF;

   control = 4'd4;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20



   a=0;

   b=32'hFFFFFFFF;

   control = 4'd4;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20

// SLL

   a=32'hFFFFFFFF;

   b=0;

   control = 4'd5;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20



   a=32'hFFFFFFFF;
   b = 5;

   control = 4'd5;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20

   a=32'hFFFFFFFF;
   b = 30;

   control = 4'd5;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20

// SRL

   a=32'hFFFFFFFF;

   b=0;

   control = 4'd6;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20 



   a=32'hFFFFFFFF;
   b = 5;

   control = 4'd6;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20 

   a=32'hFFFFFFFF;
   b = 30; 

   control = 4'd6;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20 
   
   // SLT
   a=32'hFFFFFFFF;
   b = 0;

   control = 4'd7;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20
   // SLTU
   a=32'h0FFFFF0;
   b = 32'h0FFFFFFF;

   control = 4'd8;

   $display("Control Signal is %b",control);

   $display("Input A is %b",a);

   $display("Input B is %b",b);

   $display("Output is %b",result);

   #20






   $finish;

end

endmodule


