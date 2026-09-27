// vm_sys - VM memory map (see src/bus.m, src/mmio.m)

pragma public_module

const mmioStart = Word32 0xF00C0000
const mmioSize = Word32 0xFFFF

const consoleMMIOAdr = mmioStart | 0x10
const consolePrintChar8Adr = consoleMMIOAdr | 0x00
const consoleScanChar8Adr = consoleMMIOAdr | 0x01
const consolePrintInt32Adr = consoleMMIOAdr | 0x10
const consolePrintUInt32Adr = consoleMMIOAdr | 0x14
const consolePrintInt32HexAdr = consoleMMIOAdr | 0x18
const consolePrintUInt32HexAdr = consoleMMIOAdr | 0x1C


