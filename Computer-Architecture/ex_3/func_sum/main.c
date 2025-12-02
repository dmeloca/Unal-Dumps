#include <stdio.h>
#include <stdint.h>

int32_t sum(int32_t a, int32_t b);

int main(){
	int32_t a=1, b=2, c;
	c = sum(a, b);
	printf("result: %d\n", c);
	return 0;
}

int32_t sum(int32_t a, int32_t b){
	return a+b;
}
