nasm bootsect.S

dd if=/dev/zero of=disk.img bs=1024 count=1024

dd if=mbr of=disk.img conv=notrunc

dd if=bootsect of=disk.img conv=notrunc

