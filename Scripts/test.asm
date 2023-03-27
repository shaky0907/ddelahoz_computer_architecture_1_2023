; Close
; Compile with: nasm -f elf close.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 close.o -o close
; Run with: ./close


 
SECTION .text
global  _start
 
_start:
    mov r8,0x7fffffed1a10

    ;mov rsp, 0x7fffffed1a10
    mov [r8], byte 10

    mov rax, 1      ; System call number for exit
    mov rbx, 0       ; Exit status
    int 0x80