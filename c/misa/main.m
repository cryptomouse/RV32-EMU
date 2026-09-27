// misa - print ISA info from CSRs

include "libc/stdio"


// see csr.S
@extern("C", "read_misa")
func readMisa () -> Word32
@extern("C", "read_mhartid")
func readMhartid () -> Nat32
@extern("C", "read_mcycle")
func readMcycle () -> Word64
@extern("C", "ecall")
func ecall () -> Unit
@extern("C", "ebreak")
func ebreak () -> Unit


func main () -> Int {
	printf("Hello World!\n")

	let misa = readMisa()
	printf("misa = 0x%x\n", misa)
	printMisa(misa)

	let mhartid = readMhartid()
	printf("mhartid = %d\n", mhartid)

	let mcycle = readMcycle()
	// TODO: не умеет печатать 64-битные (!)
	printf("mcycle = %d\n", Word32 mcycle)

	ecall()
	ebreak()

	return 0
}


func printMisa (misa: Word32) -> Unit {
	// xlen (bits 30-31)
	let xlenBits = misa >> 30
	var xlenStr = *Str8 "_unknown_"
	if xlenBits == 1 {
		xlenStr = "32"
	} else if xlenBits == 2 {
		xlenStr = "64"
	} else if xlenBits == 3 {
		xlenStr = "128"
	}

	printf("rv%s", xlenStr)

	// extension letters, in alphabetical order (bit 0 = 'a')
	let exts = *Str8 "abcdefghijklmnopqrstuvwxyz"
	var i: Nat32 = 0
	while i < 26 {
		if misa & (Word32 1 << i) != 0 {
			printf("%c", exts[i])
		}
		++i
	}

	printf("\n")
}


