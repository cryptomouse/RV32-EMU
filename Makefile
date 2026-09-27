
INDIR=./src
OUTDIR=./out

.PHONY: all C LLVM CM clean

# output dir prefix
CMPREFIX=$(OUTDIR)/cm/
CPREFIX=$(OUTDIR)/c/
LLVMPREFIX = $(OUTDIR)/llvm/

CM_OPTS = -funsafe

C_OPTIONS = -I$(CPREFIX) -I$(CPREFIX)/hart

# lightfood/bits32 из стандартной библиотеки Modest (нужен MODEST_DIR)
BITS32 = $(MODEST_DIR)/lib/lightfood/bits32.modest



all: LLVM


LLVM:
	modest -o $(LLVMPREFIX)/main $(CM_OPTS) -mbackend=llvm $(INDIR)/main.m
	modest -o $(LLVMPREFIX)/hart/hart $(CM_OPTS) -mbackend=llvm $(INDIR)/hart/hart.m
	modest -o $(LLVMPREFIX)/hart/decode $(CM_OPTS) -mbackend=llvm $(INDIR)/hart/decode.m
	modest -o $(LLVMPREFIX)/bus $(CM_OPTS) -mbackend=llvm $(INDIR)/bus.m
	modest -o $(LLVMPREFIX)/mmio $(CM_OPTS) -mbackend=llvm $(INDIR)/mmio.m
	modest -o $(LLVMPREFIX)/bits32 $(CM_OPTS) -mbackend=llvm $(BITS32)
	clang \
		$(LLVMPREFIX)/main.ll \
		$(LLVMPREFIX)/hart/hart.ll \
		$(LLVMPREFIX)/hart/decode.ll \
		$(LLVMPREFIX)/bus.ll \
		$(LLVMPREFIX)/mmio.ll \
		$(LLVMPREFIX)/bits32.ll


CM:
	modest -o $(CMPREFIX)/main $(CM_OPTS) -mbackend=modest $(INDIR)/main.m
	modest -o $(CMPREFIX)/hart/hart $(CM_OPTS) -mbackend=modest $(INDIR)/hart/hart.m
	modest -o $(CMPREFIX)/hart/decode $(CM_OPTS) -mbackend=modest $(INDIR)/hart/decode.m
	modest -o $(CMPREFIX)/hart/csr $(CM_OPTS) -mbackend=modest $(INDIR)/hart/csr.m
	modest -o $(CMPREFIX)/bus $(CM_OPTS) -mbackend=modest $(INDIR)/bus.m
	modest -o $(CMPREFIX)/mmio $(CM_OPTS) -mbackend=modest $(INDIR)/mmio.m
	modest -o $(CMPREFIX)/bits32 $(CM_OPTS) -mbackend=modest $(BITS32)


C:
	modest -o $(CPREFIX)/main $(CM_OPTS) -mbackend=c11 $(INDIR)/main.m
	modest -o $(CPREFIX)/hart/hart $(CM_OPTS) -mbackend=c11 $(CM_OPTS) $(INDIR)/hart/hart.m
	modest -o $(CPREFIX)/hart/csr $(CM_OPTS) $(COPTIONS) -mbackend=c11 $(INDIR)/hart/csr.m
	modest -o $(CPREFIX)/hart/decode $(CM_OPTS) -mbackend=c11 $(CM_OPTS) $(INDIR)/hart/decode.m
	modest -o $(CPREFIX)/bus $(CM_OPTS) $(CM_OPTS) -mbackend=c11 $(INDIR)/bus.m
	modest -o $(CPREFIX)/mmio $(CM_OPTS) $(CM_OPTS) -mbackend=c11 $(INDIR)/mmio.m
	modest -o $(CPREFIX)/bits32 $(CM_OPTS) -mbackend=c11 $(BITS32)
	CC $(C_OPTIONS) \
		$(CPREFIX)/main.c \
		$(CPREFIX)/hart/hart.c \
		$(CPREFIX)/hart/decode.c \
		$(CPREFIX)/bus.c \
		$(CPREFIX)/mmio.c \
		$(CPREFIX)/bits32.c


clean:
	rm *.o

