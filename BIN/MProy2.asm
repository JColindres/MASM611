print macro cadena 
LOCAL ETIQUETA 
ETIQUETA: 
	MOV ah,09h 
	MOV dx,@data 
	MOV ds,dx 
	MOV dx, offset cadena 
	int 21h
endm

print3 macro cadena
	MOV ah,09h 
	mov ax, 0A000h
	mov ds,ax
	MOV dx, offset cadena 
	int 21h
endm

print2 macro jan 
LOCAL whilee,linebreak,next_char,finish
xor di,di
mov  di, offset jan
whilee:
	call gotoxy
	mov  al, [ di ]  ;CHAR TO DISPLAY.
  	cmp  al, 13    ;IF CHAR == 13
  	je   linebreak ;THEN JUMP TO LINEBREAK.
  	cmp  al, 24h   ;IF CHAR == 0
  	je   finish  ;THEN JUMP TO FINISH.
  	call char_display  ;DISPLAY CHAR IN AL WITH "COLOR".
  	inc  x  ;NEXT CHARACTER GOES TO THE RIGHT.
  	jmp  next_char   
jmp  next_char
linebreak:
	inc  y  ;MOVE TO NEXT LINE.    
  	mov  x, 0  ;X GOES TO THE LEFT.  
next_char:
  inc  di  ;NEXT CHAR IN "JAN".
  jmp  whilee
finish:

endm

print3 macro jan 
LOCAL whilee,linebreak,next_char,finish
xor di,di
mov  di, offset jan
whilee:
	call gotoxy
	mov  al, [ di ]  ;CHAR TO DISPLAY.
  	cmp  al, 13    ;IF CHAR == 13
  	je   linebreak ;THEN JUMP TO LINEBREAK.
  	cmp  al, 24h   ;IF CHAR == 0
  	je   finish  ;THEN JUMP TO FINISH.
  	add al,48
  	call char_display  ;DISPLAY CHAR IN AL WITH "COLOR".
  	inc  x  ;NEXT CHARACTER GOES TO THE RIGHT.
  	jmp  finish   
jmp  finish
linebreak:
	inc  y  ;MOVE TO NEXT LINE.    
  	mov  x, 0  ;X GOES TO THE LEFT.  
next_char:
  inc  di  ;NEXT CHAR IN "JAN".
  jmp  whilee
finish:

endm


getRuta macro buffer
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
	mov buffer[si],00h
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

getChar macro
mov ah,0dh
int 21h
mov ah,01h
int 21h
endm

getCharEsp macro
LOCAL siguee,fin
mov ah,01h
int 16h
jz Fin 
siguee:
mov ah,00h
int 16h

Fin:
endm

getChar2 macro
mov bh,0dh
int 21h
mov bh,01h
int 21h
endm

;=========================== FICHEROS ===================
abrirF macro ruta,handle
mov ah,3dh
mov al,010b
lea dx,ruta
int 21h
mov handle,ax
jc ErrorAbrir
endm

leerF macro numbytes,buffer,handle
mov ah,3fh
mov bx,handle
mov cx,numbytes
;print numbytes
lea dx,buffer
int 21h
jc ErrorLeer
endm

crearF macro ruta, handle
mov ah,3ch
mov cx,00h
lea dx, ruta
int 21h
jc ErrorCrear
mov handle,ax
endm

escribirF macro handle, numBytes, buffer
mov ah,40h
mov bx,handle
mov cx,numBytes
lea dx,buffer
int 21h
jc ErrorEscribir
endm

cerrarr macro handle
mov ah,3eh
mov bx,handle
int 21h
endm
;====================================Modos================
ModoVideo macro
mov ah,00h
mov al,13h
int 10h
;mov ax, 0A000h
;mov ds,ax
endm


ModoTexto macro
mov ah,00h
mov al,03h
int 10h
endm
;=========================================================
EliminarEspacios macro
	LOCAL ETQ1,ETQ2,ETQ3
	xor si,si
	xor di,di
	jmp ETQ1
	ETQ2:
		inc si
	ETQ1:
		mov al,bufferLectura[si]
		cmp al, 24h
		je ETQ3
		cmp al,8
		je ETQ2
		cmp al,9
		je ETQ2
		cmp al,10
		je ETQ2
		cmp al,32
		je ETQ2
		cmp al,13
		je ETQ2
		mov bufferLecturaNuevo[di],al
		inc di
	jmp ETQ2
		
	ETQ3:
		
endm
Analizar macro
	LOCAL ETQ1,ETQ2,ETQ3,ETQ4,ETQ5,ETQ6,ETQ7,ETQ8,ETQ9,ETQ10
	xor di,di
	xor cx,cx
	jmp ETQ1

	ETQ18:
		inc di
		inc si
	ETQ17:
		mov al,bufferLecturaNuevo[si]
		cmp al,60
		je ETQ4
		mov LimSupZ[di],al
	jmp ETQ18
	ETQ16:
		inc di
		inc si
	ETQ15:
		mov al,bufferLecturaNuevo[si]
		cmp al,60
		je ETQ4
		mov LimInfZ[di],al
	jmp ETQ16
	ETQ14:
		inc di
		inc si
	ETQ13:
		mov al,bufferLecturaNuevo[si]
		cmp al,60
		je ETQ4
		mov LimSupY[di],al
	jmp ETQ14
	ETQ12:
		inc di
		inc si
	ETQ11:
		mov al,bufferLecturaNuevo[si]
		cmp al,60
		je ETQ4
		mov LimInfY[di],al
	jmp ETQ12
	ETQ10:
		inc di
		inc si
	ETQ9:
		mov al,bufferLecturaNuevo[si]
		cmp al,60
		je ETQ4
		mov LimSupX[di],al
	jmp ETQ10
	ETQ8:
		inc di
		inc si
	ETQ7:
		mov al,bufferLecturaNuevo[si]
		cmp al,60
		je ETQ4
		mov LimInfX[di],al
	jmp ETQ8
	ETQ6:
		inc di
		inc si
	ETQ5:
		mov al,bufferLecturaNuevo[si]
		cmp al,60
		je ETQ4

		mov Ecuacion[di],al
	jmp ETQ6
	ETQ4:
		inc cx
	ETQ2:
		inc si	
	ETQ1:
		mov al, bufferLecturaNuevo[si]
		cmp al,24h
		je ETQ3
		cmp al,62
		je  ETQ4
		cmp cl,2
		je ETQ5
		xor di,di
		cmp cl,6
		je ETQ7
		cmp cl,9
		je ETQ9
		cmp cl,14
		je ETQ11
		cmp cl,17
		je ETQ13
		cmp cl,22
		je ETQ15
		cmp cl,25
		je ETQ17
	jmp ETQ2

	ETQ3:
	

endm

LimpiarBuffer macro buffer
	LOCAL Fin,Ciclo,IncCiclo
	push si
	push ax
	xor si,si
	jmp Ciclo
	IncCiclo:
		inc si
	Ciclo:
		mov al, buffer[si]
		cmp al,24h
		je Fin
		mov al,24h
		mov buffer[si],al

	jmp IncCiclo
	Fin:
	pop ax
	pop si
endm

ConveInv macro buffer
	push si
	xor si,si
	jmp Leyendo
	xor ah,ah
	incLeyendo:
		inc si
		xor al,al
		mov al, buffer[si]
		cmp al, 30h
		jl FinConv
		cmp al, 39h
		jg FinConv
		sub al,48
		mov cx,ax
		pop ax
		xor ah,ah
		mov bl,10
		mul bl
		add ax,cx
		push ax 
	jmp incLeyendo
	Leyendo:
		xor al,al
		mov al, buffer[si]
		cmp al, 30h
		jl FinConv
		cmp al, 39h
		jg FinConv 
		sub al,48
		push ax
	jmp incLeyendo

	FinConv:
		xor ax,ax
		pop ax
		mov ah,02
		mov dx,ax
		int 21h
		;xor ah,ah
		pop si
		;ret
endm

LIMITE macro buffer
LOCAL enviar, seguir
	enviar:
	
		;enviamos caracter por caracer
		mov ah,01h ;peticion para caracter de transmisión
		mov al,[buffer+si];caracter a enviar
		cmp al,'$'  ;Se repite el envio de datos hasta que se teclee un Enter.
		je seguir

		mov dx,00 ;puerto COM1
		int 14H ;llama al BIOS

		inc si   ;Incrementamos nuestro contador
		jmp enviar
			
	seguir:
			
		mov ah,01h
		mov al,';'
		mov dx,00
		int 14h
		xor si,si
endm