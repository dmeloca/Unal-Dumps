#include <stdio.h>
#include <stdint.h>

int32_t sum(int32_t a,int32_t b,int32_t c,int32_t d);


int main(){
	int32_t a=1, b=2, c=3, d=4;
	printf("Result: %d\n", sum(a,b,c,d));
	return 0;
}

int32_t sum(int32_t a,int32_t b,int32_t c,int32_t d){
	int32_t arr[4];
	arr[0] = a;
	arr[1] = b;
	arr[2] = c;
	arr[3] = d;
	
	int32_t s, i;
	for (i = 0; i<4; i++){
		s += arr[i];
	}
	return s;
}
