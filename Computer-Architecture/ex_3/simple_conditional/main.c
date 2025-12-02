#include <stdio.h>
#include <stdint.h>

int32_t max(int32_t a, int32_t b);

int main(){
	// Case #1
	// int32_t a=1, b=2;
	// Case #2
	int32_t a=9, b=4;
	printf("Mayor %d\n", max(a, b));
	return 0;
}

int32_t max(int32_t a, int32_t b){
	int32_t m;
	if (a>b){
		m = a;
	} else {
		m = b;
	}
	return m;
}
