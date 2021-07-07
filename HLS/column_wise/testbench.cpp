#include<iostream>
#include"header.h"
using namespace std;
#include<fstream>

int B[dim][dim];
int A[dim][dim];

int b1[(dim*dim)/2];
int b2[(dim*dim)/2];

int C[dim][dim];
int CF[dim][dim];
ap_int<64>Ca[dim][dim];

int out1[(dim*dim)/2];
int out2[(dim*dim)/2];


int val[dim*non_null];
int csr[dim*non_null];




void densebreak()
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
				b1[count2]=B[k][i];
				count2++;
				}
				else
				{
			    b2[count1]=B[k][i];
				count1++;

				}
		}




	}}






void sparse()
{
	ifstream aaaa;
	aaaa.open("D:/Work/PES/ASAP/columwise/symbols.txt");
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


	int pp=0;
	int colcount;
	for (int i=0;i<dim;i++)
	{
		colcount=0;
		for (int j=0;j<dim;j++)
		{

			if (A[j][i]!=0)
			{

				val[pp]=A[j][i];
				csr[pp]=j;
				pp++;
			}



		}


	}

}


void densemm()
{

for (int i=0;i<dim;i++)
{
	for(int j=0;j<dim;j++)
	{
		for (int k=0;k<dim;k++)
		{

			CF[i][k]+=A[i][j]*B[j][k];

	    }

 }
}}

void printfiles(ap_int<64>C[dim][dim])
{

ofstream sparseoutput;
sparseoutput.open("D:/Work/PES/ASAP/columwise/fpgaoutput.txt");


	for (int i=0;i<dim;i++)
	{
		for(int k=0;k<dim;k++)
		{
			sparseoutput<<C[k][i]<<"\n";

		}
	}


}

void prinche(int[dim][dim])
{

ofstream sparseoutput;
sparseoutput.open("D:/Work/PES/ASAP/columwise/denseoutputhls.txt");


	for (int i=0;i<dim;i++)
	{
		for(int k=0;k<dim;k++)
		{
			sparseoutput<<CF[k][i]<<"\n";

		}
	}


}


int main()
{

densebreak();

sparse();

densemm();
prinche(CF);

kernel_colmat(B,Ca);

printfiles(Ca);

	return 0;
}
