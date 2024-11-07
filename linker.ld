OUTPUT_FORMAT("binary")
ENTRY(main)

MEMORY
{
    BOOT(rwx) : ORIGIN = 0x1000, LENGTH = 4096
}

SECTIONS
{
    .text : {
        . = ORIGIN(BOOT);
		KEEP(*(.main))
        KEEP(*(.text*))
    } > BOOT
}
