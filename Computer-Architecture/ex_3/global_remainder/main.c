#include <stdio.h>
#include <stdint.h>

int32_t remainder;

void division(int32_t *a, int32_t *b);

int main(){
	int32_t a=4, b=2;
	division(&a, &b);
	printf("Reminder: %d\n", remainder);
	return 0;
}

void division(int32_t *a, int32_t *b){
	remainder = *a % *b;
}
