#include "graphics.h"

void Graphics_SetMode(char mode)
{
	__asm__ (
		"MOV 0, %%AH\n\t"
		"MOV %0, %%AL\n\t"
		"INT $0x10\n\t"
		:
		: "r" (mode)
	);
}

void Graphics_SetPos(int x, int y)
{
}

void Graphics_GetPos(int* x, int* y);

char Graphics_GetChar();

void Graphics_SetChar(char chr);
