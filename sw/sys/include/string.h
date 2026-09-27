// Minimal freestanding string.h for the RV32 VM (see ../base.S, ../string.c)
#ifndef _VM_STRING_H
#define _VM_STRING_H

#include <stddef.h>

void *memcpy(void *dst, const void *src, size_t len);
void *memset(void *mem, int x, size_t len);
int memcmp(const void *a, const void *b, size_t len);

#endif /* _VM_STRING_H */
