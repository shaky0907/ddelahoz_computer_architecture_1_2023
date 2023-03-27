

section .bss
    n1 resb 8    ; Buffer para almacenar valor binario
    n2 resb 8         ; Buffer para almacenar valor binario


section	.text
   global _start         ;must be declared for using gcc

_start:                  ;tell linker entry point


    mov r8,2
    mov r9,27

    mov [n1],r8
    mov [n2],r9

    mov r10,[n1]
    mov r11,[n2]

    shl r10,8
    add r10,r11






