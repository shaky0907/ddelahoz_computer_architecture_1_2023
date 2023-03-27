section .text
global _start

section .data
    keybuff db 50,0                 ; buffer para leer las llaves
    decnum db '0000' ,0           ; Buffer para almacenar valor decodificado
    deciN db 00000 , 0          ; Buffer para almacenar el numero decimal codificado

    wdata db '0',0
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
    d resb 8  ; buffer para d
    n resb 8  ; buffer para n
    n1 resb 8 ; almacenar n1
    n2 resb 8 ; almacenar n2
    n3 resb 8 ; union de n1 con n2

    decena resb 1
    unidad resb 1
    centena resb 1

    contador resb 10000



section .text
_start:
    mov rsp,0x7fffffed1a10
    jmp init


;init ===================================================================================================================
; incializar los archivos que se van a usar
init:


    ;create decrypt.txt
    mov     ecx, 0777o          ;
    mov     ebx, decfile
    mov     eax, 8
    int     80h

    mov     ebx, ebx            ; not needed but used to demonstrate that SYS_CLOSE takes a file descriptor from EBX
    mov     eax, 6              ; invoke SYS_CLOSE (kernel opcode 6)
    int     80h                 ; call the kernel


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
    xor rax,rax ; reset rax
    add rdi,1   ; continuar al siguiente caracter
    mov r14, [d]
    jmp readkey

storeN:

    mov [n],rax  ;guardar n
    xor rax,rax ;reset rax
    add rdi,1   ;incrementar cantidad de numeros leidos
    mov r15,[n]

    jmp readkey

stopRkey:

    ;inicializar datos para busqueda de otro archivo

    mov rdi, 0
    mov rsi, 0
    mov r8, 0
    mov [contador], byte 0



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
    mov rax, 3 ; sys_read
    mov rbx, [fd_in] ; definir desde donde se lee
    mov rcx, data ; result de la lectura
    mov rdx, 8 ; cantidad a leer
    int 0x80

    ;cerrar el archivo
    mov rax, 6 ; sys close
    mov rbx, 0 ; status
    int  0x80

    ; imprimir lo que leyo del archivo
    mov rax, 4
    mov rbx, 1
    mov rcx, data
    mov rdx, 8
    int 0x80
    ; imprimir lo que leyo del archivo
    mov rax, 4
    mov rbx, 1
    mov rcx, espacio
    mov rdx, 1
    int 0x80

    xor rax,rax


busqueda:

    cmp byte [data + rdi], 0 ; verifica si el buffer está vacío
    je end_busqueda

    cmp byte [data + rdi], ' ' ; compara el byte actual con un espacio en blanco
    je skipEsp2

    movzx rcx, byte [data + rdi]

    ;remove ascii
    sub rcx,48
    imul rax,10
    add rax,rcx

    add rdi, 1               ; incrementa la posición actual en el buffer

    cmp rdi, 9           ; verifica si se ha llegado al final del buffer
    je end_busqueda
    jmp busqueda

skipEsp2:

    add rdi,1

    cmp r8,0
    je parte1

    cmp r8,1
    je parte2


parte1:
    add r8,1
    mov [n1],rax ; guardad n1
    xor rax,rax ; reset del rax
    jmp busqueda

parte2:
    add rsi,rdi ; update el puntero al buffer actual
    xor rdi, rdi ;reseteo del contador de bits para saber cuando se encuentra un espacio en blanco
    mov r8,0  ;Resetear el contador de numeros

    mov [n2],rax ; guardar n2

    mov r10,[n1] ;obtener n1
    mov r11,[n2] ;obtener n2
    shl r10,8 ; ajustar n1
    add r10,r11 ; uniros
    mov [n3], r10 ;guardar n3

    jmp  initModExp




end_busqueda:
    mov r14, [contador]
    mov r13,0

    jmp writefile


;modular exponentiation======================================================================================================

initModExp:
    mov r9, [n3]   ;base
    mov r10, [d]  ;exponente
    mov r11, [n]   ;modulo

    mov r12, 1      ;Respuesta final
    mov r13, 1      ;Registro temporal

    mov rbp, rdx    ;Calculo modulo inicial
    mov rax, r9
    mov rcx, r11
    xor rdx,rdx     ;Limpia los valores en rdx
    div rcx         ;Division para obtener el modulo
    mov r13,rdx     ;Guarda el modulo de la primera iteracion

modexp:
    mov r14,r10     ;mover exp a reg temporal
    and r14, 1      ;revision de par o impar
    cmp r14, 1
    jne par        ;si es par

    mov rax,r13
    mul r12         ;Registro en la respuesta el valor del modulo actual ya que debe aportar al ser impar
    xor rdx, rdx    ;Limpio el valor de rdx
    div rcx         ;Calculo sobre la respuesta el modulo para mantener el valor dentro de 64 bits y por propiedades de modulacion
    mov r12, rdx    ;Respuesta al regustro 12


par:
    shr r10,1       ;Divido el exponente a la mitad
    xor rdx,rdx     ;limpio rdx
    mov rax,r13
    mul rax
    div rcx         ;Guardo el siguiente valor del modulo
    mov r13,rdx
    cmp r10,0       ;Reviso si el exponente es 0 despues de su division
    jne modexp      ;Repito en caso de que no sea

EndExp:
    xor rdx,rdx       ;limpio el regusto rdx
    mov rax,r12       ;Preparar para encontrar el modulo final a la respuesta
    div rcx
    mov r12,rdx       ;Guardo el valor del modulo final en el r12

savedata:
    mov r10,[contador]
    mov [rsp + r10],r12
    add r10, 4

    mov [contador], r10
    jmp read_img

writefile:

    cmp r13,r14
    je done

    xor rdx,rdx ; reset rdx
    mov cx , [rsp + r13]
    ;centenas
    mov ax, cx; load resultado de mod exp
    mov r9,100 ; cargar divisor 10-10-1
    div r9 ; dividir

    mov r11,rax ; cargar resultado en r11
    add r11,48 ; ascii

    ;decenas
    mov rax,rdx ; residuo
    mov r9,10 ; cargar divisor 10-10-1
    xor rdx,rdx ; reset rdx
    div r9 ; dividir

    mov r10,rax
    add r10,48

    ;unidades
    mov r9,rdx ; cargar resultado en r11
    add r9,48 ; ascii

    mov r8,r11
    call write

    mov r8,r10
    call write

    mov r8,r9
    call write

    mov r8,32
    call write

    add r13,4
    jmp writefile


write:

    ;open file
    mov     ecx, 1
    mov     ebx, decfile
    mov     eax, 5
    int     0x80

    ;buscar lo ultimo del file
    mov     edx, 2
    mov     ecx, 0
    mov     ebx, eax
    mov     eax, 19
    int     0x80

    mov     rdx, 1            ; number of bytes to write - one for each letter of our contents string
    mov     [wdata], r8
    mov     ecx, wdata        ; we are going to write the d key
    mov     ebx, ebx            ; move the opened file descriptor into EBX (not required as EBX already has the FD)
    mov     eax, 4              ; invoke SYS_WRITE (kernel opcode 4)
    int     0x80                  ; call the kernel

    mov     ebx, ebx        ; not needed but used to demonstrate that SYS_CLOSE takes a file descriptor from EBX
    mov     eax, 6          ; invoke SYS_CLOSE (kernel opcode 6)
    int     0x80              ; call the kernel

    ret



;end function ========================================================================================================

done:
    mov rax, 1      ; System call number for exit
    mov rbx, 0       ; Exit status
    int 0x80

