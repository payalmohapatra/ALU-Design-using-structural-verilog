#!/bin/sh

xrun -64bit -gui -access r alu_struct.v alu_struct_tb.v lib/and_gate.v lib/and_gate_32.v lib/mux.v lib/mux_32.v lib/nand_gate.v lib/nand_gate_32.v lib/nor_gate.v lib/nor_gate_32.v lib/or_gate.v lib/or_gate_32.v lib/xnor_gate.v lib/xnor_gate_32.v lib/xor_gate.v lib/xor_gate_32.v lib/not_gate.v lib/not_gate_32.v 
