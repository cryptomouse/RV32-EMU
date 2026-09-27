// Minimal freestanding stdio.h for the RV32 VM (see ../printf.c)
#ifndef _VM_STDIO_H
#define _VM_STDIO_H

int printf(const char *str, ...);
void putchar(char c);

#endif /* _VM_STDIO_H */
