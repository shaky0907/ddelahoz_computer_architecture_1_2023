section .text
global _start

section .data
    keybuff db 50,0                 ; buffer para leer las llaves


    pdata db 'Hola',0
    imagef db '5.txt',0     ; txt con la imagen encryptada
    llaves db 'llaves.txt',0    ;txt con las llaves
    decfile db 'decrypt.txt',0   ; txt donde se guarda la imagen decrypted

    ; constante
    dos db 2
    espacio dd 10



section .bss
    fd_in  resb 1   ; descriptor de archivos
    fd resd 1       ; descriptor de archivo
    data resb 8 ;buffer para el archivo encryptado
    d resb 4  ; buffer para d
    n resb 4  ; buffer para n

    n1 resb 3 ; almacenar n1
    n2 resb 3 ; almacenar n2


section .text
_start:
    jmp init


;init ===================================================================================================================
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
    mov rbx, rax   ; descriptor de archivo en rbx

    ; Leer llaves.txt
    mov rax, 3          ; sys_read
    mov rcx, keybuff      ; buffer para llaves
    mov rdx, 50         ; max cantidad para leer
    int 0x80

    ; Cerrar el archivo
    mov rax, 6
    mov rbx, rax
    int 0x80


    mov r8, 0           ; contador para las llaves
    mov rdi, 0          ; contador para el buffer
    mov rsi, 0          ; inicio del archivo


;lectura de los keys ==========================================================================================
readkey:

    cmp r8,3 ; revisar si ya conto los 2 parametros de la llave
    je stopRkey ;terminar el loop

    cmp byte [keybuff + rdi],' ' ; comprarar con el caracter espacio
    je skipEsp ;saltar el espacio

    movzx rcx, byte [keybuff + rdi] ; almacenar el caracter

    ;tranformar a decimal
    sub rcx,48
    imul rax, 10
    add rax,rcx

    add rdi,1 ; incrementar el contador de buffer

    jmp readkey


skipEsp:
    add r8,1 ; signifca que leyo un parametro de la llave

    cmp r8,2 ; revisar cuantos numeros ha leido cant = 1
    je storeD ;guardar el valor de D para uso futuro

    cmp r8,3 ; revisar cuantos numeros ha leido cant = 2
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

    ;inicializar datos para busqueda de otro archivo
    mov rdi, 0
    mov rsi, 0
    mov r8, 0



;read image file ========================================================================================================================
read_img:

    ;abrir el archivo de la imagen
    mov rax, 5
    mov rbx, imagef
    mov rcx, 0             ;READ_ONLY
    mov rdx, 0777          ;Permisos
    int  0x80

    mov  [fd_in], rax  ;puntero del archivo
    mov rax, rsi        ; posicion inicial
    mov rbx, [fd_in]
    mov rcx, rax        ; posición de desplazamiento
    mov rdx, 0          ; inicio del archivo = 0
    mov rax, 19         ; syscall establecer puntero
    int 0x80            ; llama al sistema

    ;se lee del archivo
    mov rax, 3
    mov rbx, [fd_in] ; definir desde donde se lee
    mov rcx, data ; result de la lectura
    mov rdx, 8 ; cantidad a leer
    int 0x80

    ;cerrar el archivo
    mov rax, 6
    mov rbx, [fd_in]
    int  0x80

    ; imprimir lo que leyo del archivo
    mov rax, 4
    mov rbx, 1
    mov rcx, data
    mov rdx, 8
    int 0x80

    jmp done



busqueda:

    cmp byte [data+rdi], 0 ; verifica si el buffer está vacío
    je end_busqueda

    cmp byte [data+rdi], ' ' ; compara el byte actual con un espacio en blanco
    je skipEsp2

    movzx rcx, byte [data+rdi]
    sub rcx,48
    imul rax,10
    add rax,rcx
    add rdi,1               ; incrementa la posición actual en el buffer

    cmp rdi, 9           ; verifica si se ha llegado al final del buffer
    je end_busqueda
    jmp busqueda

skipEsp2:
    add rdi,1
    cmp r8,0
    ;add edi,1
    cmp r8,0
    je parte1

    cmp r8,1
    je parte2


parte1:
    add r8,1
    jmp busqueda

parte2:
    add rsi,rdi

    xor rdi, rdi  ;reseteo del contador de bits para saber cuando se encuentra un espacio en blanco

    mov r8,0  ;Resetear el contador de numeros



    jmp read_img


end_busqueda:

    jmp done
















;modular exponentiation======================================================================================================

initModExp:
    mov r9, 539     ;base
    mov r10, 1531  ;exponente
    mov r11, 2747   ;modulo
    mov r12, 1      ;Respuesta final
    mov r13, 1      ;Registro temporal

    mov rbp, rdx    ;Calculo modulo inicial
    mov rax, r9
    mov rcx, r11
    xor rdx,rdx     ;Limpia los valores en rdx
    div rcx         ;Division para obtener el modulo
    mov r13,rdx     ;Guarda el modulo de la primera iteracion

Modexp:
    mov r14,r10     ;muevo el exponente a un registro tempral
    and r14, 1      ;Aislo el primer bit que dira si el numero es par o impar
    cmp r14, 1      ;Revision de imparidad
    jne even        ;Si no es par debe saltarse los siguientes pasos

    mov rax,r13
    mul r12         ;Registro en la respuesta el valor del modulo actual ya que debe aportar al ser impar
    xor rdx, rdx    ;Limpio el valor de rdx
    div rcx         ;Calculo sobre la respuesta el modulo para mantener el valor dentro de 64 bits y por propiedades de modulacion
    mov r12, rdx    ;Respuesta al regustro 12


even:
    shr r10,1       ;Divido el exponente a la mitad
    xor rdx,rdx     ;limpio rdx
    mov rax,r13
    mul rax
    div rcx         ;Guardo el siguiente valor del modulo
    mov r13,rdx
    cmp r10,0       ;Reviso si el exponente es 0 despues de su division
    jne Modexp      ;Repito en caso de que no sea

FinalExp:
    xor rdx,rdx       ;limpio el regusto rdx
    mov rax,r12       ;Preparar para encontrar el modulo final a la respuesta
    div rcx
    mov r12,rdx       ;Guardo el valor del modulo final en el r12





;end functions ========================================================================================================

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

