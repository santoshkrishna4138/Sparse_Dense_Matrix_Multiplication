############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project ASAP
set_top mmstream
add_files kernelasap.cpp
add_files header.h
add_files -tb testbench.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1" -flow_target vivado
set_part {xa7a100t-csg324-1I}
create_clock -period 5 -name default
config_export -format ip_catalog -rtl verilog
source "./ASAP/solution1/directives.tcl"
csim_design
csynth_design
cosim_design -trace_level port
export_design -flow impl -rtl verilog -format ip_catalog -output D:/Work/PES/ASAP/ASAP/solution1/mmstream.zip
