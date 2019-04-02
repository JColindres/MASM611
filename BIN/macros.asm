print macro buffer
    mov ax,@data
    mov ds, ax
    mov ah,09h
    mov dx,offset buffer
    int 21h
endm

printNeto macro buffer
LOCAL jeje
	xor si,si
	jeje:
    mov ax,@data
    mov ds, ax
    mov ah,09h
	mov al, buffer[si]
    mov dx,offset buffer
    int 21h
endm

getChar macro
    mov ah,01h
    int 21h
endm


obtenerTexto macro buffer
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
        mov al,24h
        mov buffer[si],al
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
    LOCAL eerrorabrir, efin

    mov ah, 3dh
    mov al, 02h
    lea dx, rutaentrada
    int 21h
    jc eerrorabrir
    mov entrada, ax
    jmp efin

eerrorabrir:
    print err1
	jmp algopaso
efin:

endm

cerrar macro entrada
    LOCAL eerrorabrir, efin
    mov ah, 3eh
    mov bx, entrada
    int 21h
    jc eerrorabrir
    jmp efin

eerrorabrir:
    print err2
	jmp algopaso
efin:

endm

Leer macro entrada, info, nobytes

LOCAL eerrorabrir, efin
mov ah, 3fh
mov bx, entrada
mov cx, nobytes
lea dx, info
int 21h
jc eerrorabrir
jmp efin

eerrorabrir:
    print err3
	jmp algopaso
efin:

endm

Limpiar macro buffer, numbytes, caracter
LOCAL Repetir
xor si, si
xor cx, cx
mov cx, numbytes
Repetir:
mov buffer[si], caracter
inc si
loop Repetir
endm 

CrearArchivo macro buffer, handler
LOCAL errorcrear, efin
    mov ah, 3ch
    mov cx, 00h
    lea dx, buffer
    int 21h
    jc errorcrear
    mov handler,ax
    jmp efin
errorcrear:
    print err4
efin:
endm


Escribiraa macro handler, buffer, numbytes
LOCAL errorcrear, efin
mov ah, 40h
mov bx, handler
mov cx, 127
lea dx, buffer
int 21h
jc errorcrear
jmp efin
errorcrear:
    print errorcerrar
efin:
endm

Escribirbb macro handler, buffer, numbytes
LOCAL errorcrear, efin
mov ah, 40h
mov bx, handler
mov cx, 2951
lea dx, buffer
int 21h
jc errorcrear
jmp efin
errorcrear:
    print errorcerrar
efin:
endm

Limpirtablerooo macro
LOCAL borrar, salir
xor si,si
borrar:
    cmp si,64
    je salir
    mov tablero[si], 0
    inc si
    jmp borrar
salir:

endm

Escribirtablero macro
LOCAL encabezado,cuerpo, pintarverde, pintada1, fin, pintarsepia, abretr, cierretr, pintadaaux, fin2,fin3, finhora, finhora1, finhora2, finhoraa, finhoraa1, finhoraa2, pintada, pintarnegro
    xor si,si
    xor di,di
    encabezado:
    mov al, encabezadohtml[si]
    mov htmltablero[di],al 
    inc si
    inc di
    cmp si,28
    je cuerpo
    jmp encabezado
    cuerpo:
    xor si,si

    pintada:
    xor bx,bx

    cmp si, 8
    je cierretr
    cmp si, 16
    je cierretr
    cmp si, 24
    je cierretr
    cmp si, 32
    je cierretr
    cmp si, 40
    je cierretr
    cmp si, 48
    je cierretr
    cmp si, 56
    je cierretr
    cmp si, 64
    je cierretr

    pintadaaux:

    xor bx,bx
    cmp si, 0
    je abretr
    cmp si, 8
    je abretr
    cmp si, 16
    je abretr
    cmp si, 24
    je abretr
    cmp si, 32
    je abretr
    cmp si, 40
    je abretr
    cmp si, 48
    je abretr
    cmp si, 56
    je abretr

    cmp si, 64
    je fin
    mov al, tablero[si]
    xor bx,bx
    cmp al, 0
    je pintarnegro
    cmp al, 1
    je pintarverde
    cmp al, 2
    je pintarsepia

    pintarverde:
    mov al, colorverde[bx]
    mov htmltablero[di],al
    inc di
    inc bx
    cmp bx, 42
    je pintada1
    jmp pintarverde

    pintarsepia:
    mov al, colorsepia[bx]
    mov htmltablero[di],al
    inc di
    inc bx
    cmp bx, 42
    je pintada1
    jmp pintarsepia

    pintarnegro:
    mov al, colornegro[bx]
    mov htmltablero[di],al
    inc di
    inc bx
    cmp bx, 42
    je pintada1
    jmp pintarnegro

    pintada1:
    inc si
    jmp pintada

    abretr:
        mov al, abretr1[0]
        mov htmltablero[di],al
        inc di
        mov al, abretr1[1]
        mov htmltablero[di],al
        inc di
        mov al, abretr1[2]
        mov htmltablero[di],al
        inc di
        mov al, abretr1[3]
        mov htmltablero[di],al
        inc di

        mov al, tablero[si]
        xor bx,bx
        cmp al, 0
        je pintarnegro
        cmp al, 1
        je pintarverde
        cmp al, 2
        je pintarsepia

        inc si
        jmp pintada

    cierretr:
        mov al, cierretr1[0]
        mov htmltablero[di],al
        inc di
        mov al, cierretr1[1]
        mov htmltablero[di],al
        inc di
        mov al, cierretr1[2]
        mov htmltablero[di],al
        inc di
        mov al, cierretr1[3]
        mov htmltablero[di],al
        inc di
        mov al, cierretr1[4]
        mov htmltablero[di],al
        inc di

        jmp pintadaaux
    fin:
    xor si,si

    finhora:
    mov al, hora[si]
    mov htmltablero[di],al 
    inc si
    inc di
    cmp si,48
    je finhoraa
    jmp finhora

    finhoraa:
    xor si,si

    finhora1:
    mov al, hora2[si]
    mov htmltablero[di],al 
    inc si
    inc di
    cmp si,47
    je finhoraa1
    jmp finhora1

    finhoraa1:
    xor si,si
    
    finhora2:
    mov al, hora3[si]
    mov htmltablero[di],al 
    inc si
    inc di
    cmp si,46
    je finhoraa2
    jmp finhora2

    finhoraa2:
    xor si,si

    fin2:
    mov al, piehtml[si]
    mov htmltablero[di],al 
    inc si
    inc di
    cmp si,22
    je fin3
    jmp fin2
    fin3:
endm
