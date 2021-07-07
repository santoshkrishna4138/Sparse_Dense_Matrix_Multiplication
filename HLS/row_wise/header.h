#define dim 560
#define non_null 16
#include<ap_int.h>
#include<hls_stream.h>

void kernelrow(int a1[(dim*dim)/2], int a2[(dim*dim)/2],int out1[(dim*dim)/2], int out2[(dim*dim)/2]);
void mmstream(hls::stream<int>&b1,hls::stream<int>&b2,hls::stream<ap_uint<64>>&out1,
	hls::stream<ap_uint<64>>&out2);
