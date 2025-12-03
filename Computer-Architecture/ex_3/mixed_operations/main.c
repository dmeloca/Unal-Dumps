#include <stdio.h>
#include <stdint.h>

int32_t mix(int32_t a, int32_t b, int32_t c, int32_t d);

int main(){
	int32_t a=1, b=2, c=3, d=4;
	printf("Result: %d\n", mix(a,b,c,d));
	return 0;
}

int32_t mix(int32_t a, int32_t b, int32_t c, int32_t d){
	int32_t x, y;
	x = a + b;
	y = c - d;
	return x * y;
}
