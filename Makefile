DISKIMG = bin/disk.img
MEMORY = 1G
ARGS = -hda $(DISKIMG) -enable-kvm -cpu host -m $(MEMORY) 
GCCOPTIONS = -fno-pie -m32 --freestanding -fstrength-reduce -fomit-frame-pointer -finline-functions -fno-builtin -nostdlib -nostartfiles -nodefaultlibs


sourceList = $(subst src/,,$(wildcard src/*.c))
includeList = $(wildcard src/*.h)

all: ensurebin compile createimage run

ensurebin:
	mkdir -p bin

define compileSource
  $1: src/$1
	gcc -c src/$1 -o bin/$1.o $(GCCOPTIONS)
endef

$(foreach file, $(sourceList), $(eval $(call compileSource,$(file))))
out: $(includeList) $(sourceList)
	gcc -T linker.ld $(foreach file, $(sourceList), bin/$(file).o) -o bin/compiled.bin $(GCCOPTIONS)

compile: ensurebin out

createimage:
	nasm bootsect.s
	dd if=/dev/zero of=$(DISKIMG) bs=1024 count=2048
	dd if=mbr of=$(DISKIMG) conv=notrunc
	dd if=bootsect of=$(DISKIMG) conv=notrunc
	dd if=bin/compiled.bin of=$(DISKIMG) conv=notrunc bs=512 seek=1

run:
	qemu-system-amd64 $(ARGS) || qemu-system-x86_64 $(ARGS)

clean:
	rm -r bin/*
