#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int iRange=0;
int iN=0;
int iTotalCombs=0;
int* pTheRange;
int* pTempRange;
char* str;

int find_factorial(int n)
{
	if ( n<1)
		return 1;
	else
	return find_factorial(n-1)*n;
}

void print_out_combinations(int *P, int K, int n_i) 
{
	if (K == 0)
	{
		int j;
		printf("-");
		for (j =iN;j>0;j--)
		{
			printf("%c", str[P[j] - 1]);
		}
		printf("\n");
	}
	else
	{
		int i;
		for (i = n_i; i < iRange; i++)
		{
			P[K] = pTheRange[i];
			print_out_combinations(P, K-1, i+1);
		}
	}
}

int main(int argc, char **argv)
{
	if (argc <= 1)
		return -1;
	int k = 1;
	int len = strlen(argv[1]);
	iRange = len;
	str = argv[1];
	pTheRange = malloc(sizeof(int)*iRange);
	while (k <= len)
	{
		iN = k;
		pTempRange = malloc(sizeof(int)*iN);
		int i;
		for (i = 0;i<iRange;i++)
		{
			pTheRange[i]=i+1;
		}
		iTotalCombs = (find_factorial(iRange)/(find_factorial(iRange-iN)*find_factorial(iN)));
		print_out_combinations(pTempRange, iN, 0);
		k++;
	}
	free(pTheRange);
	return 0;
}
