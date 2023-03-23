section .text
global _start

section .data
    pdata dw " "


section .text
_start:


    mov [pdata], word '24'
    call print
    mov [pdata], word 'HD'
    call print
    jmp done

print:

    mov rax, 4    ; sys_write system call
    mov rbx, 1    ; stdout file descriptor
    mov rcx, pdata ; bytes to write
    mov rdx, 2    ; number of bytes to write
    int 0x80      ; perform system call
    ret

modExp:
    ;Hacer cosas

    ret


done:
    mov rax, 1      ; System call number for exit
    mov rbx,0       ; Exit status
    int 0x80






