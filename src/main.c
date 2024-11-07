#include "base.h"

void RAWCODE main() {
	__asm__(
		"MOV 0xA, %%AH\n"
		"MOV 'K', %%AL\n"
		"MOV 1, %%CX\n"
		"MOV 2, %%BL\n"
		"INT $0x10\n"
		"halt:\n"
		"JMP halt\n"
		:
		:
	);
}
