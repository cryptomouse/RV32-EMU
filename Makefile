
INDIR=./src
OUTDIR=./out

.PHONY: all C LLVM CM clean

# output dir prefix
CMPREFIX=$(OUTDIR)/cm/
CPREFIX=$(OUTDIR)/c/
LLVMPREFIX = $(OUTDIR)/llvm/

CM_OPTS = -funsafe

SDL_FLAGS = -I/opt/homebrew/include -L/opt/homebrew/lib -lSDL2

C_OPTIONS = -O2 -I$(CPREFIX) -I$(CPREFIX)/hart -I$(CPREFIX)/dev

# lightfood/bits32 из стандартной библиотеки Modest (нужен MODEST_DIR)
BITS32 = $(MODEST_DIR)/lib/lightfood/bits32.modest



all: LLVM


LLVM:
	modest -o $(LLVMPREFIX)/main $(CM_OPTS) -mbackend=llvm $(INDIR)/main.modest
	modest -o $(LLVMPREFIX)/hart/hart $(CM_OPTS) -mbackend=llvm $(INDIR)/hart/hart.modest
	modest -o $(LLVMPREFIX)/hart/decode $(CM_OPTS) -mbackend=llvm $(INDIR)/hart/decode.modest
	modest -o $(LLVMPREFIX)/bus $(CM_OPTS) -mbackend=llvm $(INDIR)/bus.modest
	modest -o $(LLVMPREFIX)/mmio $(CM_OPTS) -mbackend=llvm $(INDIR)/mmio.modest
	# display uses SDL2 via @extern("C", ...) names which only the C backend supports
	modest -o $(LLVMPREFIX)/dev/display $(CM_OPTS) -mbackend=c11 $(INDIR)/dev/display.modest
	modest -o $(LLVMPREFIX)/bits32 $(CM_OPTS) -mbackend=llvm $(BITS32)
	clang -O2 \
		$(LLVMPREFIX)/main.ll \
		$(LLVMPREFIX)/hart/hart.ll \
		$(LLVMPREFIX)/hart/decode.ll \
		$(LLVMPREFIX)/bus.ll \
		$(LLVMPREFIX)/mmio.ll \
		$(LLVMPREFIX)/dev/display.c \
		$(LLVMPREFIX)/bits32.ll \
		$(SDL_FLAGS)


CM:
	modest -o $(CMPREFIX)/main $(CM_OPTS) -mbackend=modest $(INDIR)/main.modest
	modest -o $(CMPREFIX)/hart/hart $(CM_OPTS) -mbackend=modest $(INDIR)/hart/hart.modest
	modest -o $(CMPREFIX)/hart/decode $(CM_OPTS) -mbackend=modest $(INDIR)/hart/decode.modest
	modest -o $(CMPREFIX)/hart/csr $(CM_OPTS) -mbackend=modest $(INDIR)/hart/csr.modest
	modest -o $(CMPREFIX)/bus $(CM_OPTS) -mbackend=modest $(INDIR)/bus.modest
	modest -o $(CMPREFIX)/mmio $(CM_OPTS) -mbackend=modest $(INDIR)/mmio.modest
	modest -o $(CMPREFIX)/dev/display $(CM_OPTS) -mbackend=modest $(INDIR)/dev/display.modest
	modest -o $(CMPREFIX)/bits32 $(CM_OPTS) -mbackend=modest $(BITS32)


C:
	modest -o $(CPREFIX)/main $(CM_OPTS) -mbackend=c11 $(INDIR)/main.modest
	modest -o $(CPREFIX)/hart/hart $(CM_OPTS) -mbackend=c11 $(CM_OPTS) $(INDIR)/hart/hart.modest
	modest -o $(CPREFIX)/hart/csr $(CM_OPTS) $(COPTIONS) -mbackend=c11 $(INDIR)/hart/csr.modest
	modest -o $(CPREFIX)/hart/decode $(CM_OPTS) -mbackend=c11 $(CM_OPTS) $(INDIR)/hart/decode.modest
	modest -o $(CPREFIX)/bus $(CM_OPTS) $(CM_OPTS) -mbackend=c11 $(INDIR)/bus.modest
	modest -o $(CPREFIX)/mmio $(CM_OPTS) $(CM_OPTS) -mbackend=c11 $(INDIR)/mmio.modest
	modest -o $(CPREFIX)/dev/display $(CM_OPTS) -mbackend=c11 $(INDIR)/dev/display.modest
	modest -o $(CPREFIX)/bits32 $(CM_OPTS) -mbackend=c11 $(BITS32)
	CC $(C_OPTIONS) $(SDL_FLAGS) \
		$(CPREFIX)/main.c \
		$(CPREFIX)/hart/hart.c \
		$(CPREFIX)/hart/decode.c \
		$(CPREFIX)/bus.c \
		$(CPREFIX)/mmio.c \
		$(CPREFIX)/dev/display.c \
		$(CPREFIX)/bits32.c


clean:
	rm *.o

