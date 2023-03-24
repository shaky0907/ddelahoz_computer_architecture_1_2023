section .text
global _start

section .data
    pdata db 'Hola',0
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

    jmp init




; incializar los archivos que se van a usar
init:

    ;create o hacer reset al archivo decrypt
    mov  rax, 8           ; sys_call create
    mov  rbx, decfile        ; archivo de escritura
    mov  rcx, 0777        ; Darle permisos
    int  0x80
    mov rax, 6 ;cerrarlo
    mov rbx, rax

    ; Abrir el archivo para saber la llave privada
    mov rax, 5      ; sys_open
    mov rbx, llaves     ; archivo
    mov rcx, 0    ; modo de lectura
    int 0x80
    mov rbx, rax   ; descriptor de archivo en ebx

    ; Leer llaves.txt
    mov rax, 3          ; sys_read
    mov rcx, keybuff      ; buffer para llaves
    mov rdx, 50         ; max cantidad para leer
    int 0x80

    ; Cerrar el archivo
    mov rax, 6
    mov rbx, rax
    int 0x80

    ;call printkeys

    mov r9, 0           ; contador para las llaves
    mov rdi, 0          ; contador para el buffer
    mov rsi, 0          ; inicio



readkey:

    cmp r9,3 ; revisar si ya conto los 2 parametros de la llave
    je stopRkey ;terminar el loop

    cmp byte [keybuff + rdi],' ' ; comprarar con el caracter espacio
    je skipEsp ;saltar el espacio

    movzx rcx, byte [keybuff + rdi] ; almacenar el caracter

    sub rcx,48 ; tranformar a decimal
    imul rax, 10
    add rax,rcx

    add rdi,1 ; incrementar el contador de buffer

    jmp readkey




skipEsp:
    add r9,1 ; signifca que leyo un parametro de la llave

    cmp r9,2 ; revisar cuantos numeros ha leido cant = 1
    je storeD ;guardar el valor de D para uso futuro

    cmp r9,3 ; revisar cuantos numeros ha leido cant = 2
    je storeN ;ir a guardar el valor de N para uso futuro




storeD:
    mov [d],rax  ;guardar d

    mov r10,[d]
    xor rax,rax ; reset rax
    add rdi,1   ; continuar al siguiente caracter

    jmp readkey

storeN:

    mov [n],rax  ;guardar n
    mov r11,[n]
    xor rax,rax ;reset rax
    add rdi,1   ;incrementar cantidad de numeros leidos
    jmp readkey

stopRkey:

    mov rdi, 0
    mov rsi, 0
    mov r9, 0
    call printn
    jmp done

done:
    mov rax, 1      ; System call number for exit
    mov rbx, 0       ; Exit status
    int 0x80

printkeys:
    mov rax, 4    ; sys_write system call
    mov rbx, 1    ; stdout file descriptor
    mov rcx, keybuff ; bytes to write
    mov rdx, 10    ; number of bytes to write
    int 0x80      ; perform system call
    ret

printn:

    mov rax, 4    ; sys_write system call
    mov rbx, 1    ; stdout file descriptor
    mov rcx, n ; bytes to write
    mov rdx, 6    ; number of bytes to write
    int 0x80      ; perform system call
    ret

printd:

    mov rax, 4    ; sys_write system call
    mov rbx, 1    ; stdout file descriptor
    mov rcx, d    ; bytes to write
    mov rdx, 6    ; number of bytes to write
    int 0x80      ; perform system call
    ret

