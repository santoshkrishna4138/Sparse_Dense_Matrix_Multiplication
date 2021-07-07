#HLS Implementation
This repository contains HLS implementation for the row_wise and column_wise matrix multiplication. 
The Required_files repository contains all the files required to generate a matrix with any sparsity range required. The repository also has the column/row pointer values and the sparse matrix value. The O/P files are also stored in this directory
#When executing this code
  1) please use Vitis_HLS.
  2) Use the matgen function and generate the matrix for a given sparsity (%)
  3) Please change the path in_accordance to the local machine
  4) VAL/Pointer values are for 560x560. These have to be manually generated from the sparse matrix. The code is given in the test bench for the same.
  5) Create a new vitis_hls project add the kernel and header file in the source directory
  6) Choose the project flow as vivado since we are not executing these files on the alveo board .xo flow is currently not required
  7) Add the testbench in the testbench directory
  8) Perform the Csimulation, C Synthesis , C/RTL Cosimulation and export the IP and perform the place and route
  9) The Latency value can be noted down in two ways
              i) The values can be extracted from the C/RTL Cosimulation report
              ii) The value can be caluclated from the waveform. The timing value has to be noted when ap_start=1 and ap_done=1. Taking the difference and dividing the clock would 
                  yield the latency
                  
  10) The timing values can be measured after the place and route

