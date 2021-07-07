#include<ap_int.h>
#include<hls_stream.h>

#define dim 560
#define non_null 16


#define idx (dim*dim)/2


void kernel_colmat(int B[dim][dim], ap_int<64> output [dim][dim]);
