#include <stdio.h>
#include <stdint.h>

void prod_div(int32_t a, int32_t b, int32_t *prod, int32_t *div);


int main(){
	int32_t a=4, b=2;
	int32_t prod, div;
	
	prod_div(a, b, &prod, &div);
	printf("Prod: %d, Div: %d\n", prod, div);
	return 0;
}

void prod_div(int32_t a, int32_t b, int32_t *prod, int32_t *div){
	*prod = a * b;
	*div = a / b;
}
