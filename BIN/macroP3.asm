print macro buffer
    mov ax,@data
    mov ds, ax
    mov ah,09h
    mov dx,offset buffer
    int 21h
endm

getChar macro
    mov ah,01h
    int 21h
endm

obtenerRuta macro buffer
    LOCAL ObtenerChar, FinOT
    xor si,si
    ObtenerChar:
        getChar
        cmp al,0dh
        je FinOT
        mov buffer[si],al
        inc si
        jmp ObtenerChar
    FinOT:
        mov al,00h
        mov buffer[si],al
endm

Abrir macro rutaentrada, entrada
    LOCAL erroralabrir, fin

    mov ah, 3dh
    mov al, 02h
    lea dx, rutaentrada
    int 21h
    jc erroralabrir
    mov entrada, ax
    jmp fin

erroralabrir:
    print err1
	jmp algopaso
fin:

endm

cerrar macro entrada
    LOCAL erroralcerrar, fin
    mov ah, 3eh
    mov bx, entrada
    int 21h
    jc erroralcerrar
    jmp fin

erroralcerrar:
    print err2
	jmp algopaso
fin:

endm

Leer macro entrada, info, nobytes
LOCAL erroralleer, fin
mov ah, 3fh
mov bx, entrada
mov cx, nobytes
lea dx, info
int 21h
jc erroralleer
jmp fin
erroralleer:
    print err3
	jmp algopaso
fin:

endm

Limpiar macro buffer, numbytes, caracter
LOCAL ciclo
xor si, si
xor cx, cx
mov cx, numbytes
ciclo:
mov buffer[si], caracter
inc si
loop ciclo
endm 

CrearArchivo macro buffer, handler
LOCAL erroralcrear, fin
    mov ah, 3ch
    mov cx, 00h
    lea dx, buffer
    int 21h
    jc erroralcrear
    mov handler,ax
    jmp fin
erroralcrear:
    print err4
fin:
endm

LimpiarPantalla macro
mov ah, 02h
mov dx, 0000h
int 10h
mov ax, 0600h
mov bh, 07h
mov cx, 0000h
mov dx, 194fh
int 10h
endm