/*
 * hart/csr.modest
 */

pragma public_module

//
// CSR's
// see: https://five-embeddev.com/riscv-isa-manual/latest/priv-csrs.html
//

const mstatusRegno: Nat16 = 0x300     // Machine status register
const misaRegno: Nat16 = 0x301        // ISA and extensions
const medelegRegno: Nat16 = 0x302     // Machine exception delegation register
const midelegRegno: Nat16 = 0x303     // Machine interrupt delegation register
const mieRegno: Nat16 = 0x304         // Machine interrupt-enable register
const mtvecRegno: Nat16 = 0x305       // Machine trap-handler base address
const mcounterenRegno: Nat16 = 0x306  // Machine counter enable

const mscratchRegno: Nat16 = 0x340
const mepcRegno: Nat16 = 0x341
const mcauseRegno: Nat16 = 0x342
const mtvalRegno: Nat16 = 0x343
const mipRegno: Nat16 = 0x344

const mcycleRegno: Nat16 = 0xB00
const minstretRegno: Nat16 = 0xB02
const mcyclehRegno: Nat16 = 0xB80
const minstrethRegno: Nat16 = 0xB82

const mvendoridRegno: Nat16 = 0xF11
const marchidRegno: Nat16 = 0xF12
const mimpidRegno: Nat16 = 0xF13
const mhartidRegno: Nat16 = 0xF14
const mconfigptrRegno: Nat16 = 0xF15



// MSTATUS fields
const mstatus_mie: Word32 = 1 << 3   // Machine interrupt enable
const mstatus_mpie: Word32 = 1 << 7  // Previous MIE (saved on trap entry)


// MISA fields
const misaA = Word32 1 << 0
const misaB = Word32 1 << 1
const misaC = Word32 1 << 2
const misaF = Word32 1 << 5
const misaI = Word32 1 << 8
const misaM = Word32 1 << 12
const misaS = Word32 1 << 18
const misaU = Word32 1 << 20
const misaX = Word32 1 << 23
const misaXlen32 = Word32 1 << 30
const misaXlen64 = Word32 2 << 30


