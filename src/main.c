void main() {
	__asm__(
		"MOV %AH, 0xA\n"
		"MOV %AL, 'K'\n"
		"MOV %CH, 1\n"
		"MOV %BL, 2\n"
		"INT $0x10\n"
		"halt:\n"
		"JMP halt\n"
	);
}
