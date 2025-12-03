#include <stdio.h>
#include <stdint.h>

int32_t f(int32_t *x, int32_t *y, int32_t *z);
int32_t caller(int32_t a, int32_t b, int32_t c, int32_t d);

int main(){
	int32_t a=1, b=2, c=3, d=4;
	printf("Result: %d\n", caller(a, b, c, d));
	return 0;
}

int32_t caller(int32_t a, int32_t b, int32_t c, int32_t d){
	return f(&a, &b, &c) - d;
}

int32_t f(int32_t *x, int32_t *y, int32_t *z){
	return *x * *y + *z;
}
