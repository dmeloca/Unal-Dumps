#include <stdio.h>
#include <stdint.h>


int32_t sum_arr(int32_t *arr){
	int32_t i, sum;
	for(i = 0; i<4 ; i++){
		sum += arr[i];
	}
	return sum;
}

int main(){
	int32_t arr[4] = {1, 2, 3, 4};
	printf("Result: %d\n", sum_arr(arr));
	return 0;
}
