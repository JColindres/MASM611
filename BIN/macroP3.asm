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

getTexto macro buffer
LOCAL INICIO,FIN
	xor si,si
INICIO:
	getChar
	cmp al,0dh
	je FIN
	mov buffer[si],al
	inc si
	jmp INICIO
FIN:
	mov buffer[si],'$'
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

Abrir2 macro rutaentrada, entrada
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
	jmp algopaso2
fin:

endm

cerrar2 macro entrada
    LOCAL erroralcerrar, fin
    mov ah, 3eh
    mov bx, entrada
    int 21h
    jc erroralcerrar
    jmp fin

erroralcerrar:
    print err2
	jmp algopaso2
fin:

endm

Leer2 macro entrada, info, nobytes
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
	jmp algopaso2
fin:

endm

Abrir3 macro rutaentrada, entrada
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
	jmp algopaso3
fin:

endm

cerrar3 macro entrada
    LOCAL erroralcerrar, fin
    mov ah, 3eh
    mov bx, entrada
    int 21h
    jc erroralcerrar
    jmp fin

erroralcerrar:
    print err2
	jmp algopaso3
fin:

endm

Leer3 macro entrada, info, nobytes
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
	jmp algopaso3
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

Editar macro archivo, informacion, handle
LOCAL err2, fin
	mov ah, 3ch
	mov cx, 0
	mov dx, offset archivo
	int 21h
	jc err2
	mov handle, ax
	mov ah, 42h
	mov bx, handle
	mov al, 0
	mov cx, 0
	mov dx, 2
	int 21h
	mov ah,40h
	mov bx,handle
	mov cx,8000
	lea dx,informacion
	int 21h
	jc err2
	mov ah, 3eh
	mov bx, handle
	int 21h
	jmp fin
err2:
	print err4
fin:
	nop
endm

CONTARCARACTERES macro buffer, contador
LOCAL BUSCARCICLO, finBuscar, seguirBuscar, acabar
	xor si,si 	
	mov cx, 2500
	BUSCARCICLO:
		cmp buffer[si],36
		je finBuscar
		jmp seguirBuscar
		finBuscar:
			mov cx,0
			jmp acabar
		seguirBuscar:
			inc si
			inc contador
		acabar:		
	LOOP BUSCARCICLO
endm

LimpiarBufferLectura macro
 	xor si,si
 	jmp jj2
 	jj:
 	 inc si
 	jj2:
 		mov al,bufferInfo[si]
 		cmp al,24h
		je salir1
		mov bufferInfo[si],24h
	jmp jj 
	salir1:

 endm


 ActualizarBufferLectura macro
 	xor si,si
 	jmp ABL2
 	ABL:
 		inc si
 	ABL2:
 		mov al,bufferInfoAuxiliar[si]
 		cmp al,24h
		je salir2
		mov bufferInfo[si],al
	jmp ABL
	salir2:

 endm

 LimpiarBufferLecturaNuevo macro
 	xor si,si
 	jmp jj4
 	jj3:
 	 inc si
 	jj4:
 		mov al,bufferInfoAuxiliar[si]
 		cmp al,24h
		je salir3
		mov bufferInfoAuxiliar[si],24h
	jmp jj3 
	salir3:

 endm

 ActualizarBufferEscritura macro
 	xor si,si
 	jmp jj6
 	jj5:
 	 inc si
 	jj6:
 		mov al,bufferInfo[si]
 		cmp al,24h
		je salir4
		mov bufferInfoFinal[si],al
	jmp jj5 
	salir4:
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