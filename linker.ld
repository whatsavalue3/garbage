OUTPUT_FORMAT("binary")
ENTRY(main)

MEMORY
{
    MBR(rwx) : ORIGIN = 0x7c00, LENGTH = 512
}

SECTIONS
{
    .text : {
        . = ORIGIN(MBR);
		KEEP(*(.main))
        KEEP(*(.text*))
    } > MBR
}
