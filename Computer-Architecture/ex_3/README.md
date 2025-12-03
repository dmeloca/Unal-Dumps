# Exercises

For each exercise draw the stack, write the assembly code and comment the important steps.

## Conventions
Fucntion parameters: 

    - Linux: `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`
    - Windows: `rcx`, `rdx`, `r8`, `r9`

and in both the result is returned in `rax`

## Exercises
### Understanding registers

1. Three parameters via registers
```c
int32_t add(int32_t a, int32_t b, int32_t c) {
    return a + b + c;
}
```

2. Mixed operations
```c
int mix4(int a, int b, int c, int d) {
    int x = a + b;
    int y = c - d;
    return x * y;
}
```

### More complex arithmetic
3. Arithmetic and pointers
```c
void prod_div(int a, int b, int *p_prod, int *p_div) {
    int prod = a * b;
    int div  = a / b;

    *p_prod = prod;
    *p_div  = div;
}
```
4. Global reminder of a division
```c
int remainder;
void division(int32_t *a, int32_t *b){
	remainder = *a % *b;
}
```

### Call functions
3. Function that call other function
```c
int f(int x, int y, int z) {
    return x * y + z;
}

int caller(int a, int b, int c, int d) {
    int t = f(a, b, c);
    return t - d;
}
```

### Arrays
4. Local Arrays in stack
```c
int32_t sum_arr(int32_t *arr){
	int32_t i, sum;
	for(i = 0; i<4 ; i++){
		sum += arr[i];
	}
	return sum;
}
```






