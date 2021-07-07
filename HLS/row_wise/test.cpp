#include<iostream>
#include<fstream>
#include"header.h"
#include<hls_stream.h>
#include<ap_int.h>


using namespace std;

int b1[(dim*dim)/2];
int b2[(dim*dim)/2];

int out1[(dim*dim)/2];
int out2[(dim*dim)/2];

int B[dim][dim];
int A[dim][dim];
int Cdense[dim][dim];
int rowweight[dim];

int colptr[non_null*dim];
int val[non_null*dim];

int*bp1;
int*bp2;

hls::stream<int>sparsestreamb1 ("dense matr1");
hls::stream<int>sparsestreamb2 ("dense matr2");
hls::stream<ap_uint<64>>outstream1 ("Outputstream 1");
hls::stream<ap_uint<64>>outstream2 ("Outputstream 2");

void row_weight()
{

ifstream aaaa;
aaaa.open("D:/Work/PES/ASAP/symbols.txt");
int num;
int count=0;

for(int i=0;i<dim;i++)
	{

for(int j=0;j<dim;j++)

	{
		aaaa>>num;
		A[i][j]=num;
		if(A[i][j]!=0)
		{
			count++;
		}

	}
}


aaaa.close();
int count2=0;
for(int i=0;i<dim;i++)
{
	int rowcount=0;
	for (int j=0;j<dim;j++)
	{

			if(A[i][j]!=0)
			{

				val[count2]=A[i][j];
				colptr[count2]=j;
				count2++;
				rowcount++;

			}

	}
	rowweight[i]=rowcount;

}


	std::cout<<"done with sparse \n";


	ofstream value;
	value.open("D:/Work/PES/ASAP/val.txt");
	for (int i=0;i<(dim*non_null);i++)
	{

	value<<val[i]<<",";
	}

	value.close();

}





void cdense()
{

	for (int i=0;i<dim;i++)
	{
		for(int j=0;j<dim;j++)
		{
			for (int k=0;k<dim;k++)
			{

				Cdense[i][k]+=A[i][j]*B[j][k];

		    }

	 }
	}


}

void cdenseprint()
{
	ofstream dense;
	dense.open("D:/Work/PES/ASAP/CPUdense.txt");



	for (int i=0;i<dim;i++)
	{
		for(int k=0;k<dim;k++)
		{
			dense<<Cdense[i][k]<<"\n";

		}
	}

	dense.close();


}



void ctoprint()
{
	ofstream coua;
	coua.open("D:/Work/PES/ASAP/FPGa.txt");

	for (int i=0;i<(dim*dim)/2;i++)
	{

	coua<<out1[i]<<"\n"<<out2[i]<<"\n";
	}
	coua.close();

}



void cstream()
{

	int p,q,qx,k,pp;

	for(int i=0;i<dim;i++)
	{

		int rowintr=non_null;
			for (int kk=0;kk<non_null;kk++)
		{

			for (int k=0;k<(dim/2);k++)

			{
			sparsestreamb1.write(b1[(dim/2)*colptr[(kk+qx)]+k]);
		//	std::cout<<"C1"<<"["<<qx+kk<<"]"<<"="<<"val ["<<k+pp<<"]"<<"*"<<"b1["<<((dim/2)*csc[(kk+pp)]+k)<<"]"<<"\n";
			sparsestreamb2.write((b2[(dim/2)*colptr[(kk+qx)]+k]));
		//	std::cout<<"C2"<<"["<<kk+qx<<"]"<<"="<<"val ["<<k+pp<<"]"<<"*"<<"b2["<<((dim/2)*csc[(kk+pp)]+k)<<"]"<<"\n";
			}

		//	std::cout<<"\n";

		}
		pp+=(dim/2);
		qx+=non_null;
	}

	std::cout<<"\n Sparse "<<" done \n";







}





int main()
{


for (int i=0;i<dim;i++)
{
  for(int k=0;k<dim;k++)
	{
	B[i][k]=i+k;

	}
}


int count1=0;
int count2=0;

for (int i=0;i<dim;i++)
	{
	for(int k=0;k<dim;k++)
		{
		if (k%2==0)
			{
			b1[count2]=B[i][k];
			count2++;
			}
		else
			{
			 b2[count1]=B[i][k];
			count1++;
			}}
}

bp1=b1;
bp2=b2;

row_weight();


cdense();
cdenseprint();

cstream();
kernelrow(bp1,bp2,out1,out2);
mmstream(sparsestreamb1,sparsestreamb2,outstream1,outstream2);

ctoprint();
ofstream combinedc1andc2;
combinedc1andc2.open("D:/Work/PES/ASAP/cstreamfinalval.txt");

for (int i=0;i<(dim*dim)/2;i++)
{

combinedc1andc2<<outstream1.read()<<"\n"<<outstream2.read()<<"\n";
}




combinedc1andc2.close();



return 0;
}
