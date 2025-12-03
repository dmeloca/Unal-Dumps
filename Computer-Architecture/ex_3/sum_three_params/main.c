#include <stdio.h>
#include <stdint.h>

int32_t sum(int32_t a, int32_t b, int32_t c);
int main(){
	int32_t a=1, b=2, c=3;	
	printf("Result: %d\n", sum(a,b,c));
	return 0;
}


int32_t sum(int32_t a, int32_t b, int32_t c){
	return a+b+c;
}
