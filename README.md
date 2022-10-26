# ALU-Design-using-structural-verilog
CE-361 :: Computer Architecture Project 

This code is built as part of a course assignment. It is developed and tested using Xcelium. 
Source appropriate files based on the tool you are using 
for eg.
source /vol/cadence2018/XCELIUM1809/tools/xcelium/files/xmsimrc

Use the following script to run the test using given library
./run_alu.sh

Use simvision to view the checked in waveform,
simvision ALU_design/waves.shm/waves.trn &

ALU Functional Specification :
 Inputs: 2 x 32-bit operands A, B, 4-bit control signal
 Outputs: 32-bit result S, 1-bit carry_out, 1 bit overflow , 1-bit zero
 Operations :
o arithmetic: add, sub
o logical: and, xor, or, sll, srl
o conditional: slt, sltu
