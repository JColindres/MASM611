;--------------OBTENER CARACTER DE CONSOLA CON ECHO A PANTALLA----------------------
getChar macro
mov ah,0dh
int 21h
mov ah,01h
int 21h
endm

;--------------MACRO IMPRESION DE CADENA---------------------------
print macro cadena
push ax
push dx
mov ax,@data
mov ds,ax
mov ah,09
mov dx,offset cadena
int 21h
pop dx
pop ax
endm

.model small

.stack

.data
msg10 db  0ah, 0dh,'INGRESE TEXTO:', '$'   ; $-terminated message
msg11 db  0ah, 0dh,'TEXTO RECIBIDO:', '$'   ; $-terminated message

msg1 db  0ah, 0dh,'ELIJA UNA OPCCION', '$'   ; $-terminated message
msg2 db  0ah, 0dh,'1- ENVIAR TEXTO', '$'   ; $-terminated message
msg3 db  0ah, 0dh,'2- RECIBIR TEXTO', '$'   ; $-terminated message
msg4 db  0ah, 0dh,'3- SALIR', '$'   ; $-terminated message
vtext db 100 dup('$') 
;int 21h is going to want...

.code
.startup
menu:
    print msg1
	print msg2
	print msg3
	print msg4

	;limpiamos al
	mov al,0h

	;comparamos la opcion que se tecleo
	getChar

	cmp al,0dh
	je menu

	cmp al,31h
	je leer

	cmp al,32h
	je reci

	cmp al,33h
	je salir


leer:
	;Iniciamos nuestro conteo de si en la posicion 0.
	mov si,00h
	print msg10
	jmp leer1
leer1:
        mov ax,0000
        mov ah,01h
        int 21h
		;Guardamos el valor tecleado por el usuario en la posicion si del vector.
        mov [vtext+si],al
        inc si   ;Incrementamos nuestro contador
        cmp al,0dh  ;Se repite el ingreso de datos hasta que se teclee un Enter.
        jne leer1
		;preparamos puerto
		mov ah,00h ;inicializa puerto
		mov al,11100011b ;parámetros
		mov dx,00 ; puerto COM1 (el com 2 sería mov dx,01)
		int 14H ;llama al BIOS
		;Iniciamos nuestro conteo de si en la posicion 0.
		mov si,00h
		jmp enviar


enviar:

		;enviamos caracter por caracer
		mov ah,01h ;peticion para caracter de transmisión
        mov al,[vtext+si];caracter a enviar

		cmp al,0dh  ;Se repite el envio de datos hasta que se teclee un Enter.
        je menu

		mov dx,00 ;puerto COM1
		int 14H ;llama al BIOS

		inc si   ;Incrementamos nuestro contador
		jmp enviar
        

		;mov ah,01h ;peticion para caracter de transmisión
		;mov al, 'J' ;caracter de transmisión
		;mov dx,00 ;puerto COM1
		;int 14H ;llama al BIOS

reci:
		
		

		print msg11

		;preparamos puerto
		mov ah,00h ;inicializa puerto
		mov al,11100011b ;parámetros
		mov dx,00 ; puerto COM1 (el com 2 sería mov dx,01)
		int 14H ;llama al BIOS
			
		jmp reci1

reci1:
		mov al,0h ;reiniciamos al
		;leemos caracter por caracter
		mov ah,02h ;petición para recibir caracter
		mov dx,00 ;puerto COM1
		int 14H ;llama al BIOS

		cmp al,0h  ;Se repite la lectura hasta encontrar vacio
        je menu

		;mov dl,al ;movemos a dl el caracter recibido en al
		;mov ah,2  ;sub-funccion imprimir caracter
		;int 0x21 ;call dos services

		jmp reci1


salir:
	;mov ah, 0x4c     ; "terminate program" sub-function
	;int 0x21         ; call dos services
	mov ah, 4ch
	mov al, al
	int 21h
.exit
end




