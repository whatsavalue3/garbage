DISKIMG := bin/disk.img
MEMORY := 1G
ARGS := -hda $(DISKIMG) -enable-kvm -cpu host -m $(MEMORY) 

sourceList = $(subst src/,,$(wildcard src/*.c))
includeList = $(subst src/,,$(wildcard src/*.h))

all: ensurebin compile createimage run

ensurebin:
	mkdir -p bin

define compileSource
  $1: src/$1
	gcc -c src/$1 -o bin/$1.o -nostdlib -nostartfiles
endef

$(foreach file, $(sourceList), $(eval $(call compileSource,$(file))))
out: $(includeList) $(sourceList)
	gcc -T linker.ld $(foreach file, $(sourceList), bin/$(file).o) -o bin/compiled.bin -nostdlib -nostartfiles

compile: ensurebin out

createimage:
	nasm bootsect.s -o bin/bootsect
	dd if=/dev/zero of=$(DISKIMG) bs=1024 count=2048
	dd if=mbr of=$(DISKIMG) conv=notrunc
	#dd if=bin/bootsect of=$(DISKIMG) conv=notrunc
	dd if=bin/compiled.bin of=$(DISKIMG) conv=notrunc

run:
	qemu-system-amd64 $(ARGS) || qemu-system-x86_64 $(ARGS)

clean:
	rm -r bin/*
