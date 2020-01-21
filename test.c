#include <stdio.h>
#include "callf.h"

int func(int x, int y) {
	return x - y;
}

int main() {
	int in[2] = { 2, 32 }, out[1];
	callfRaw(func, in, 8, out, 0);
	printf("%d\n", out[0]);
}