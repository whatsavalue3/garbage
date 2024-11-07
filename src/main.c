#include "base.h"

ATTR((section(".main"), naked)) void main() {
	__asm__(
		"MOV $0xA, %%AH\n"
		"MOV $'K', %%AL\n"
		"MOV $1, %%CX\n"
		"MOV $2, %%BL\n"
		"INT $0x10\n"
		:
		:
	);
	
	while(1)
	{
		
	}
}
