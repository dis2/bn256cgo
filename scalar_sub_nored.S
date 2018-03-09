#include "cc.h"
# File:   dclxvi-20130329/scalar_sub_nored.s
# Author: Ruben Niederhagen, Peter Schwabe
# Public Domain


# qhasm: int64 rp

# qhasm: int64 xp

# qhasm: int64 yp

# qhasm: input rp

# qhasm: input xp

# qhasm: input yp

# qhasm: int64 r0

# qhasm: int64 r1

# qhasm: int64 r2

# qhasm: int64 r3

# qhasm: int64 t0

# qhasm: int64 t1

# qhasm: int64 t2

# qhasm: int64 t3

# qhasm:   int64 caller1

# qhasm:   int64 caller2

# qhasm:   int64 caller3

# qhasm:   int64 caller4

# qhasm:   int64 caller5

# qhasm:   int64 caller6

# qhasm:   int64 caller7

# qhasm:   caller caller1

# qhasm:   caller caller2

# qhasm:   caller caller3

# qhasm:   caller caller4

# qhasm:   caller caller5

# qhasm:   caller caller6

# qhasm:   caller caller7

# qhasm:   stack64 caller4_stack

# qhasm:   stack64 caller5_stack

# qhasm:   stack64 caller6_stack

# qhasm:   stack64 caller7_stack

# qhasm: enter scalar_sub_nored
.text
.p2align 5
.globl _scalar_sub_nored
.globl scalar_sub_nored
_scalar_sub_nored:
scalar_sub_nored:
WINPUSH

# qhasm: r0 = *(uint64 *)(xp +  0)
# asm 1: movq   0(<xp=int64#2),>r0=int64#4
# asm 2: movq   0(<xp=RSI),>r0=RCX
movq   0(RSI),RCX

# qhasm: r1 = *(uint64 *)(xp +  8)
# asm 1: movq   8(<xp=int64#2),>r1=int64#5
# asm 2: movq   8(<xp=RSI),>r1=R8
movq   8(RSI),R8

# qhasm: r2 = *(uint64 *)(xp + 16)
# asm 1: movq   16(<xp=int64#2),>r2=int64#6
# asm 2: movq   16(<xp=RSI),>r2=R9
movq   16(RSI),R9

# qhasm: r3 = *(uint64 *)(xp + 24)
# asm 1: movq   24(<xp=int64#2),>r3=int64#2
# asm 2: movq   24(<xp=RSI),>r3=RSI
movq   24(RSI),RSI

# qhasm: carry? r0 -= *(uint64 *)(yp +  0)
# asm 1: subq 0(<yp=int64#3),<r0=int64#4
# asm 2: subq 0(<yp=RDX),<r0=RCX
subq 0(RDX),RCX

# qhasm: carry? r1 -= *(uint64 *)(yp +  8) - carry
# asm 1: sbbq 8(<yp=int64#3),<r1=int64#5
# asm 2: sbbq 8(<yp=RDX),<r1=R8
sbbq 8(RDX),R8

# qhasm: carry? r2 -= *(uint64 *)(yp + 16) - carry
# asm 1: sbbq 16(<yp=int64#3),<r2=int64#6
# asm 2: sbbq 16(<yp=RDX),<r2=R9
sbbq 16(RDX),R9

# qhasm: r3 -= *(uint64 *)(yp + 24) - carry
# asm 1: sbbq 24(<yp=int64#3),<r3=int64#2
# asm 2: sbbq 24(<yp=RDX),<r3=RSI
sbbq 24(RDX),RSI

# qhasm: *(uint64 *)(rp +  0) = r0
# asm 1: movq   <r0=int64#4,0(<rp=int64#1)
# asm 2: movq   <r0=RCX,0(<rp=RDI)
movq   RCX,0(RDI)

# qhasm: *(uint64 *)(rp +  8) = r1
# asm 1: movq   <r1=int64#5,8(<rp=int64#1)
# asm 2: movq   <r1=R8,8(<rp=RDI)
movq   R8,8(RDI)

# qhasm: *(uint64 *)(rp + 16) = r2
# asm 1: movq   <r2=int64#6,16(<rp=int64#1)
# asm 2: movq   <r2=R9,16(<rp=RDI)
movq   R9,16(RDI)

# qhasm: *(uint64 *)(rp + 24) = r3
# asm 1: movq   <r3=int64#2,24(<rp=int64#1)
# asm 2: movq   <r3=RSI,24(<rp=RDI)
movq   RSI,24(RDI)

# qhasm: leave
WINPOP
mov RDI,%rax
mov RSI,RDX
ret
