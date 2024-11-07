#include "base.h"

ATTR((section(".main"), naked)) void main()
{	
	while(1)
	{
		__asm__(
		"MOV $0xE, %%AH\n"
		"MOV $'K', %%AL\n"
		"MOV $2, %%BL\n"
		"MOV $0, %%BH\n"
		"INT $0x10\n"
		:
		:
		);
	}
}
