#include <stdio.h>

const int N = 16; 
const int blocksize = 16; 

__global__
void hello(char *a, int *b) {
    printf("before: %c", a[threadIdx.x]);
    a[threadIdx.x] += b[threadIdx.x];
    printf("after: %c", a[threadIdx.x]);
}


int main()
{
    char a[N] = "Hello \0\0\0\0\0\0";
    int b[N] = {15, 10, 6, 0, -11, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

    char *ad;
    int *bd;
    const int csize = N*sizeof(char);
    const int isize = N*sizeof(int);

    printf("%s\n", a);

    cudaMalloc((void**)&ad, csize);
    cudaMalloc((void**)&bd, isize);
    cudaMemcpy( ad, a, csize, cudaMemcpyHostToDevice); 
    cudaMemcpy( bd, b, isize, cudaMemcpyHostToDevice); 

    dim3 dimBlock(blocksize, 1);
    dim3 dimGrid(1, 1);
    hello<<<dimGrid, dimBlock>>>(ad, bd);
    cudaError_t err = cudaGetLastError();
    if (err != cudaSuccess) 
        printf("Error: %s\n", cudaGetErrorString(err));
    cudaDeviceSynchronize();
    cudaMemcpy(a, ad, csize, cudaMemcpyDeviceToHost); 
    cudaFree(ad);
    cudaFree(bd);

    printf("%s\n", a);
    return 0;

}