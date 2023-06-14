; Compile with: nasm -felf64 -o rsa.o rsa.asm
; Link with: ld -o rsa rsa.o
; Run with: ./rsa


_start:
	mov ax, 1 ;initial variable
	mov cx, 1 ;initial counter

	;addition
	add ax, 1 ;add one
	add cx, 1 ;update counter

	;multiplication
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
	
	;division
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

	
	;next cycle
	add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

	;result here should be ((1+2)*4)/2=6

	add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

	add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

	add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

	add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

	add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2

    add cx, 1 ; update counter
	mov ax, cx ; initial variable
    mov bx, 4  ; move our second number into bx
    mul bx ; multiply ax by bx, in this case, effectively ax x 4
    mov bx, 2 ; move our second number into bx
    div bx ; divide ax by bx, in this case, effectively ax / 2


	
