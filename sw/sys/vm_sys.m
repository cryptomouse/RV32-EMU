// vm_sys - VM memory map (see src/bus.m, src/mmio.m)

pragma unsafe


public const ramStart = Word32 0x10000000
public const ramSize = Word32 0x00800000  // 8 MiB

public const mmioStart = Word32 0xF0000000
public const mmioSize = Word32 0x01000000

public const consoleMMIOAdr = mmioStart | 0x10
public const consolePrintChar8Adr = consoleMMIOAdr | 0x00
public const consoleScanChar8Adr = consoleMMIOAdr | 0x01
public const consolePrintInt32Adr = consoleMMIOAdr | 0x10
public const consolePrintUInt32Adr = consoleMMIOAdr | 0x14
public const consolePrintInt32HexAdr = consoleMMIOAdr | 0x18
public const consolePrintUInt32HexAdr = consoleMMIOAdr | 0x1C

// display controller (see src/display.m)
public const displayMMIOAdr = mmioStart | 0x1000
public const displayCR = displayMMIOAdr | 0x00            // bit 0 EN: open/close the window
public const displaySR = displayMMIOAdr | 0x04            // bit 0 ON, bit 1 ERR: ER != 0
public const displayER = displayMMIOAdr | 0x08            // error flags (sticky, write 1 to clear)
public const displayWidth = displayMMIOAdr | 0x0C
public const displayHeight = displayMMIOAdr | 0x10
public const displayFB = displayMMIOAdr | 0x14            // framebuffer address in RAM (ARGB8888)
public const displayFrameCounter = displayMMIOAdr | 0x18  // frames shown since EN
public const displayCMD = displayMMIOAdr | 0x1C           // commands (write-only, reads as 0)

public const displayCrEN = Word32 0x1
public const displayCmdREFRESH = Word32 0x1  // show the framebuffer
public const displaySrON = Word32 0x1
public const displaySrERR = Word32 0x2
public const displayErWidth = Word32 0x1
public const displayErHeight = Word32 0x2
public const displayErFB = Word32 0x4
public const displayErLINK = Word32 0x8     // link to the display lost
public const displayErGEOM = Word32 0x10    // EN set while WIDTH/HEIGHT are not configured
public const displayErOFF = Word32 0x20     // command written to CMD while the display is off
public const displayErFBMAP = Word32 0x40   // framebuffer is outside guest RAM


@inline
public func reg (adr: Word32) -> *@volatile Word32 {
	return unsafe(*@volatile Word32 adr)
}

