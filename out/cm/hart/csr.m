import "builtin"

//
// CSR's
// see: https://five-embeddev.com/riscv-isa-manual/latest/priv-csrs.html
//

public const mstatusRegno: Nat16 = 0x300// Machine status register
public const misaRegno: Nat16 = 0x301// ISA and extensions
public const medelegRegno: Nat16 = 0x302// Machine exception delegation register
public const midelegRegno: Nat16 = 0x303// Machine interrupt delegation register
public const mieRegno: Nat16 = 0x304// Machine interrupt-enable register
public const mtvecRegno: Nat16 = 0x305// Machine trap-handler base address
public const mcounterenRegno: Nat16 = 0x306// Machine counter enable

public const mscratchRegno: Nat16 = 0x340
public const mepcRegno: Nat16 = 0x341
public const mcauseRegno: Nat16 = 0x342
public const mtvalRegno: Nat16 = 0x343
public const mipRegno: Nat16 = 0x344

public const mcycleRegno: Nat16 = 0xB00
public const minstretRegno: Nat16 = 0xB02
public const mcyclehRegno: Nat16 = 0xB80
public const minstrethRegno: Nat16 = 0xB82

public const mvendoridRegno: Nat16 = 0xF11
public const marchidRegno: Nat16 = 0xF12
public const mimpidRegno: Nat16 = 0xF13
public const mhartidRegno: Nat16 = 0xF14
public const mconfigptrRegno: Nat16 = 0xF15



// MISA fields
public const misa_a: Word32 = Word32 1 << 0
public const misa_b: Word32 = Word32 1 << 1
public const misa_c: Word32 = Word32 1 << 2
public const misa_f: Word32 = Word32 1 << 5
public const misa_i: Word32 = Word32 1 << 8
public const misa_m: Word32 = Word32 1 << 12
public const misa_s: Word32 = Word32 1 << 18
public const misa_u: Word32 = Word32 1 << 20
public const misa_x: Word32 = Word32 1 << 23
public const misa_xlen_32: Word32 = Word32 1 << 30
public const misa_xlen_64: Word32 = Word32 2 << 30

