#include<iostream>
#include<fstream>
using namespace std;
#include"header.h"

int A[dim][dim];

int main()
{
ofstream aout;
aout.open("D:/Work/PES/ASAP/symbols.txt");

std::cout<<" Printing input matrix \n \n";

std::cout<<" Non_null = "<<non_null<<"\n \n";

std::cout<<"Matrix is "<<dim<<" x "<<dim<<"\n \n";

std::cout<<"NNZ="<<dim*non_null<<"\n \n";

std::cout<<"Sparsity = "<<((dim*dim-(dim*non_null)))/100<<"%"<<"\n\n";
	
int rowcount=0;	
for (int i=0;i<dim;i++)
{

rowcount=0;
	for(int j=0;j<dim;j++)
	{
		
		if(rowcount<non_null)
		{
			A[i][j]=(i+j)%2+1;
			rowcount++;
		
		}
		else
		{
			
			A[i][j]=0;
		}	
	
	}
	
}

for (int i=0;i<dim;i++)
{
	for(int j=0;j<dim;j++)
	{
		aout<<A[i][j]<<"\n";
	}
	
}

aout.close();
		
return 0;

}	
