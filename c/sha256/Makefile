
COMPILER_PATH=/opt/homebrew/opt/llvm/bin

CC=$(COMPILER_PATH)/clang
MACHINE = --target=riscv32 -march=rv32i

SYS=../sys

# $(SYS)/include - минимальные stdio.h/stdlib.h/string.h для кода из Modest
CFLAGS = -O0 $(MACHINE) -isystem $(SYS)/include
LDFLAGS = -fuse-ld=lld --ld-path=/opt/homebrew/opt/lld/bin/ld.lld

# only-section=.isr  не поможет - эту секцию хрен продавишь, хз почему так
ONLYSECTION=--only-section=.text --only-section=.data

LDSCRIPT = $(SYS)/mem.ld

# Modest -> C (нужны MODEST_DIR и MODEST_LIB)
MODEST = $(MODEST_DIR)/modest
MODEST_OPTS = -mbackend=c11
GEN = gen

# compile C to BIN
all: modest
	$(CC) $(CFLAGS) $(SYS)/muldivmod.c -c -o muldivmod.o
	$(CC) $(CFLAGS) $(SYS)/vect.S -c -o vect.o
	$(CC) $(CFLAGS) $(SYS)/base.S -c -o base.o
	$(CC) $(CFLAGS) $(SYS)/startup.c -c -o startup.o
	$(CC) $(CFLAGS) $(SYS)/system.c -c -o system.o
	$(CC) $(CFLAGS) $(SYS)/console.c -c -o console.o
	$(CC) $(CFLAGS) $(SYS)/printf.c -c -o printf.o
	$(CC) $(CFLAGS) $(GEN)/sha256.c -c -o sha256.o
	$(CC) $(CFLAGS) $(GEN)/bits32.c -c -o bits32.o
	$(CC) $(CFLAGS) $(GEN)/main.c -c -o main.o


	# link OBJects to ELF
	$(CC) $(CFLAGS) $(LDFLAGS) -nostdlib -o main.elf -T $(LDSCRIPT) vect.o startup.o system.o console.o printf.o base.o muldivmod.o sha256.o bits32.o main.o

	rm *.o

	# extract sections from ELF to BIN file

	$(COMPILER_PATH)/llvm-objcopy -Iriscv32 main.elf $(ONLYSECTION) -Obinary ../../image.bin

	# make ELF dump
	$(COMPILER_PATH)/llvm-objdump --full-contents --section=.text --section=.data -d ./main.elf > ./dump.txt


# translate Modest to C
modest:
	$(MODEST) -o $(GEN)/sha256 $(MODEST_OPTS) $(MODEST_LIB)/misc/sha256.modest
	$(MODEST) -o $(GEN)/bits32 $(MODEST_OPTS) $(MODEST_DIR)/lib/lightfood/bits32.modest
	$(MODEST) -o $(GEN)/main $(MODEST_OPTS) main.modest


clean:
	rm -rf $(GEN) *.o main.elf dump.txt


# show ELF content
dump:
	objdump --full-contents main.elf


# show ELF sections
sect:
	objdump -h main.elf


# show ELF symbols
symb:
	objdump -t main.elf


info:
	objdump -x main.elf

.PHONY: all modest clean dump sect symb info
