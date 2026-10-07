
COMPILER_PATH=/opt/homebrew/opt/llvm/bin
#COMPILER_PATH=/usr/bin

CC=$(COMPILER_PATH)/clang
#CC=$(COMPILER_PATH)/clang-14
MACHINE = --target=riscv32 -march=rv32im

# Кароче, -nostdlib -fno-builtin -fno-builtin-memset не помогают
# гребаный компайлер все равно норовит вызывать memset и невозможно отделаться!

# $(SYS)/include - минимальные stdio.h/stdlib.h/string.h для кода из Modest
CFLAGS = -O0 $(MACHINE) -isystem $(SYS)/include -I$(SYS)/gen
LDFLAGS = -fuse-ld=lld --ld-path=/opt/homebrew/opt/lld/bin/ld.lld

# only-section=.isr  не поможет - эту секцию хрен продавишь, хз почему так
ONLYSECTION=--only-section=.text --only-section=.data

SYS=../sys

LDSCRIPT = $(SYS)/mem.ld

# Modest -> C (нужен MODEST_DIR)
MODEST = $(MODEST_DIR)/modest
MODEST_OPTS = --config=$(SYS)/rv32.toml -mbackend=c11
GEN = gen

# compile C to BIN
all: modest
	$(CC) $(CFLAGS) $(SYS)/vect.S -c -o vect.o
	$(CC) $(CFLAGS) $(SYS)/base.S -c -o base.o
	$(CC) $(CFLAGS) $(SYS)/gen/startup.c -c -o startup.o
	$(CC) $(CFLAGS) $(SYS)/gen/system.c -c -o system.o
	$(CC) $(CFLAGS) $(SYS)/gen/console.c -c -o console.o
	$(CC) $(CFLAGS) $(SYS)/gen/printf.c -c -o printf.o
	$(CC) $(CFLAGS) $(SYS)/gen/display.c -c -o display.o
	$(CC) $(CFLAGS) $(GEN)/main.c -c -o main.o


	# link OBJects to ELF
	$(CC) $(CFLAGS) $(LDFLAGS) -nostdlib -o main.elf -T $(LDSCRIPT) vect.o startup.o system.o console.o printf.o base.o display.o main.o

	rm *.o

	# extract sections from ELF to BIN file

	$(COMPILER_PATH)/llvm-objcopy -Iriscv32 main.elf $(ONLYSECTION) -Obinary image.bin
	#llvm-objcopy-14 -Iriscv32 main.elf $(ONLYSECTION) -Obinary image.bin

	# make ELF dump
	$(COMPILER_PATH)/llvm-objdump --full-contents --section=.text --section=.data -d ./main.elf > ./dump.txt
	#llvm-objdump-14 --full-contents --section=.text --section=.data -d ./main.elf > ./dump.txt



# translate Modest to C
modest:
	$(MAKE) -C $(SYS)
	mkdir -p $(GEN)
	$(MODEST) -o $(GEN)/main $(MODEST_OPTS) main.m


clean:
	rm -rf $(GEN) *.o main.elf image.bin dump.txt


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
