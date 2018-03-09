// AMD64 is the dark ages for calling conventions.

#ifndef __MINGW64__
// Everyone else
#define RDI %rdi
#define RSI %rsi
#define RDX %rdx
#define RCX %rcx
#define R8 %r8
#define R9 %r9
#else
// Microsoft
#define RDI %rcx
#define RSI %rdx
#define RDX %r8
#define RCX %r9
#define R8 %rax // Make sure rax isn't used
#define R9 %rdi
#define WINPUSH push %rdi
#define WINPOP pop %rdi
#endif

