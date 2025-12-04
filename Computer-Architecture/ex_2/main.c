#include <stdio.h>
#include <stdlib.h>  // for malloc() and free()
#include <stdint.h> 
#define NOP asm("nop") 

//int32_t m=150; //prueba 1
int32_t m=50;  //prueba 2

int main() {
    int32_t size = 5;
    int32_t *arr=NULL;  // pointer to int, will point to heap memory
    int32_t i=1,j=3;
    int32_t a[5]={50,60,70,80,90};

    // Allocate memory on the heap for 5 integers
    arr = (int32_t *)malloc(size * sizeof(int32_t));

    // Initiate the array:
    arr[0]=55;
    arr[1]=45;
    arr[2]=35;
    arr[3]=25;
    arr[4]=15;

    // Processing

    a[4]=((arr[j-1]+a[i+j])/4)+m;
    NOP;
    printf("a[4] = %d\n",a[4]);

    arr[j]=((arr[i]+a[4])*32)-m;
    NOP;
    printf("arr[3] = %d\n",arr[3]);

    if(m<100)
    {
        arr[j+1]=a[4]*21;
        NOP;
    }
    else
    {
        arr[j+1]=arr[3]/5;
        NOP;
    }
    NOP;
    printf("arr[4] = %d\n",arr[4]);

    // Free the heap memory when done
    free(arr);


    return 0;
}
