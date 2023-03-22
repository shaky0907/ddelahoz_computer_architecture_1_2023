section .text
    global _start

_start:
    mov rax, 3
    mov rbx, 7

_presuma:
    add rax, rbx

_suma:
    mov rax, 60
    mov rdi, 0
    syscall