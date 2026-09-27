# c/sys - VM runtime in Modest, translated to C (needs MODEST_DIR)
#
# vect.S, base.S & mem.ld stay as is

MODEST = $(MODEST_DIR)/modest
MODEST_OPTS = --config=rv32.toml -mbackend=c11
GEN = gen

MODULES = vm_sys console system printf muldivmod startup


# translate Modest to C
all:
	mkdir -p $(GEN)
	$(foreach m,$(MODULES),$(MODEST) -o $(GEN)/$(m) $(MODEST_OPTS) $(m).m &&) true


clean:
	rm -rf $(GEN)


.PHONY: all clean
