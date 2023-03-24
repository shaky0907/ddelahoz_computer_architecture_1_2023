section .text
global _start

section .data
    pdata db ' '
    imagef db '5.txt',0     ; txt con la imagen encryptada
    llaves db 'llaves.txt',0    ;txt con las llaves
    decfile db 'decrypt.txt',0   ; txt donde se guarda la imagen decrypted

    dos db 2                    ; constante

    keybuff db 50,0                 ; buffer para leer las llaves
    binN db '0000' ,0               ; Buffer para almacenar valor decodificado
    deciN db 00000 , 0              ; Buffer para almacenar el numero decimal codificado
    n1 db '0000000000000000', 0     ; Buffer para almacenar valor binario
    n2 db '00000000', 0             ; Buffer para almacenar valor binario


section .bss
    fd_in  resb 1   ; descriptor de archivos
    fd resd 1       ; descriptor de archivo
    data resb 8 ;buffer para el archivo encryptado
    d resb 4  ; buffer para d
    n resb 4  ; buffer para n

section .text
_start:

    call init

    call print


init:

    ;create o hacer reset al archivo decrypt
    mov  rax, 8           ; sys_call create
    mov  rbx, decfile        ; archivo de escritura
    mov  rcx, 0777        ; Darle permisos
    int  0x80
    mov rax, 6 ;cerrarlo
    mov rbx, rax

    ; Abrir el archivo para saber la llave privada
    mov eax, 5      ; sys_open
    mov ebx, llaves     ; archivo
    mov ecx, 0    ; modo de lectura
    int 0x80
    mov ebx, eax   ; descriptor de archivo en ebx

    ; Leer el contenido del archivo
    mov eax, 3          ; Llamada al sistema 'read'
    mov ecx, keybuff      ; Búfer para almacenar los datos leídos
    mov edx, 50         ; Número máximo de bytes que se pueden leer
    int 0x80            ; Llamada al sistema

    ; Cerrar el archivo
    mov eax, 6          ; Llamada al sistema 'close'
    mov ebx, eax        ; Descriptor de archivo
    int 0x80            ; Llamada al sistema

    ret




print:
    mov rax, 4    ; sys_write system call
    mov rbx, 1    ; stdout file descriptor
    mov rcx, keybuff ; bytes to write
    mov rdx, 10    ; number of bytes to write
    int 0x80      ; perform system call
    ret


done:
    mov rax, 1      ; System call number for exit
    mov rbx, 0       ; Exit status
    int 0x80






