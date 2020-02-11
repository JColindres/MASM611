;/////////////////CÓDIGO EN ENSAMBLADOR MASM ////////////////////////
;===============SECCION DE MACROS ===========================
include MProy2.asm
;================= DECLARACION TIPO DE EJECUTABLE ============
.model small 
.stack 100h 
.data 
;================ SECCION DE DATOS ========================
encabezado db 0ah,0dh,'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA',0ah,0dh,'FACULTAD DE INGENIERIA',0ah,0dh,'CIENCIAS Y SISTEMAS',0ah,0dh,'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1',0ah,0dh,'SECCION B',0ah,0dh,'NOMBRE: CARLOS MANUEL GARCIA ESCALANTE',0ah,0dh,'CARNET: 201612276',0ah,0dh,0ah,0dh,'TAREA PRACTICA 5',0ah,0dh,0ah,0dh,'$'
menuu      db 0ah,0dh,'MENU PRINCIPAL',0ah,0dh,'1)CARGAR ECUACION',0ah,0dh,'2)GRAFICA 2D',0ah,0dh,'3)GRAFICA 3D',0ah,0dh,'4)SALIR',0ah,0dh,0ah,0dh,'$'

msj1 db 0ah,0dh,'Analizando Archivo',   '$'

msmError1 db 0ah,0dh,'Error al abrir archivo',   '$'
msmError2 db 0ah,0dh,'Error al leer archivo',    '$'
msmError3 db 0ah,0dh,'Error al crear archivo',   '$'
msmError4 db 0ah,0dh,'Error al Escribir archivo','$'
msmError5 db 0ah,0dh,'Error al Cerrar archivo',  '$'

probar  db  0ah,0dh,'Probar',  '$'
probar2 db  0ah,0dh,'Probar2',  '$'
probar3 db  0ah,0dh,'Probar3',  '$'

rutaArchivo        db 'ecuacion.txt',00h


rutaReporte        db 'reporte.html',00h
rutaReporteD       db 'RDip.html',00h
rutaReporteH       db 'RHia.html',00h
rutaReporteT       db 'RTrip.html',00h

bufferLectura           db 7000 dup('$')
Operaciones 			db 1000 dup('$')
bufferLecturaNuevo      db 7000 dup('$')
bufferEscritura         db 7000 dup('$')
bufferReporte       	db 7000 dup('$')
Ecuacion 				db 100  dup('$')
LimSupX					db   4  dup('$')
LimInfX                 db   4  dup('$')
LimSupY					db   4  dup('$')
LimInfY                 db   4  dup('$')
LimSupZ					db   4  dup('$')
LimInfZ                 db   4  dup('$')
Numerou                 db   4  dup('$')
SigueE 					db   3  dup('$')
SigueB 					db   3  dup('$')

x     db 1     ;SCREEN COORDINATE (COL).
y     db 0     ;SCREEN COORDINATE (ROW).
handleFichero dw ?
handle2 dw ?
value1 REAL4 2.2
value2 REAL4 1.2
sqrt REAL4 ?
.code ;segmento de código
;================== SECCION DE CODIGO ===========================
main proc 
	print encabezado
	Menu:
		print menuu
		getChar
		
		cmp al, '1'
		je CARGAREC
		cmp al, '2'
		je GRAFICA2D
		cmp al, '3'
		je GRAFICA3D
		cmp al, '4'
		je SALIR
			
;///INCISO 1/////////////////////////////////////////////////////
	CARGAREC:
		abrirF rutaArchivo,handleFichero
		leerF SIZEOF bufferLectura,bufferLectura,handleFichero
		print msj1
		EliminarEspacios
		xor si,si
		Analizar
		print Ecuacion
		print LimInfX
		print LimSupX
		print LimInfY
		print LimSupY
		print LimInfZ
		print LimSupZ
		LimpiarBuffer bufferLectura

	jmp Menu
;///INCISO 2/////////////////////////////////////////////////////
	GRAFICA2D:
		;preparamos puerto
		mov ah,00h ;inicializa puerto
		mov al,11100011b ;parámetros
		mov dx,00 ; puerto COM1 (el com 2 sería mov dx,01)
		int 14H ;llama al BIOS
		;Iniciamos nuestro conteo de si en la posicion 0.
		xor si,si
		jmp enviar


		enviar:

			;enviamos caracter por caracer
			mov ah,01h ;peticion para caracter de transmisión
			mov al,[ecuacion+si];caracter a enviar

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
		
		LIMITE LimInfX
		LIMITE LimSupX
		LIMITE LimInfY
		LIMITE LimSupY
		LIMITE LimInfz
		LIMITE LimSupZ
		
		mov ah,01h ;peticion para caracter de transmisión
		mov al,'$';caracter a enviar
		mov dx,00 ;puerto COM1
		int 14H ;llama al BIOS
			
		;mov ax,-60
		;mov dx,40
		;add ax,dx
		;xor si,si
		;xor di,di
		;call E
		;pop ax
		;print probar
		;call conve
		;call positivo
		;call conve
	jmp Menu
;///INCISO 3/////////////////////////////////////////////////////
	GRAFICA3D:
		mov ax,5
		call Factorial
		mov ah,02
		;mov al,bl
		mov dx,ax
		int 21h
	jmp Menu

	ErrorAbrir:
	   	print msmError1
	   	getChar
	jmp Menu
	ErrorLeer:
	   	print msmError2
	   	getChar
	jmp Menu
	ErrorCrear:
	  	print msmError3
	   	getChar
	jmp Menu
	ErrorEscribir:
	   	print msmError4
	   	getChar
	jmp Menu
;///INCISO 3/////////////////////////////////////////////////////
		SALIR: 
		MOV ah,4ch 
		int 21h
main endp

char_display proc 
  mov  ah, 9
  mov  bh, 0
  mov  bl, 0ch  ;ANY COLOR.
  mov  cx, 1  ;HOW MANY TIMES TO DISPLAY CHAR.
  int  10h
  ret
char_display endp    

;-------------------------------------------------     
gotoxy proc 
  mov dl, x
  mov dh, y
  mov ah, 2 ;SERVICE TO SET CURSOR POSITION.
  mov bh, 0 ;PAGE.
  int 10h   ;BIOS SCREEN SERVICES.  
  ret
gotoxy endp

conve proc
	FinConv1:
		push si
		push ax
		xor si,si
		xor cx,cx
		cwd                       ; cbw sign-extends ax to dx.
        test Dx,Dx 
        js signo

	Conversion:
		
	Conv:
		mov bl,10
		div bl
		add ah,48
		push ax
		inc cx
		cmp al,00h
		je FinConv
		xor ah,ah
	jmp Conv

    Signo:
    	mov bufferLectura[si],45
    	inc si
    	neg ax
    jmp Conversion
	FinConv:
		POP ax
		mov bufferLectura[si],ah
		inc si
		loop FinConv

		print bufferLectura
		pop ax
		pop si
		ret
conve endp

conveInvy proc
	xor si,si
	jmp Leyendo
	xor ah,ah
	incLeyendo:
		inc si
		xor al,al
		mov al, Ecuacion[si]
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
		mov al, Ecuacion[si]
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
		xor ah,ah
		ret
conveInvy endp

positivo proc
	cwd                       ; cbw sign-extends ax to dx.
    test    Dx,Dx             ; check the sign of the addend.
    js      negative
	positive:                         ; the addend is positive.
        print probar3
        ;add     bx,ax             ; add.
        ;adc     dx,0              ; carry.
        ;jmp     next_number
        ret
	negative:                         ; the addend is negative.
        ;neg     ax                ; ax = |ax|.
        ;sub     bx,ax             ; subtract.
        ;sbb     dx,0              ; borrow.
        print probar2
        ret
positivo endp


E proc
	mov di,si
	jmp NumeroE

	AB:
		call B
		ret
	Resta:
	Suma:
		;print probar2
		call B
		print probar3
		ret
		call E
		pop ax
		;mov bx,ax
		pop bx
		add ax,bx
		push ax
		ret
	
	IncNumeroE:
		inc si
    NumeroE:

    	mov al,Ecuacion[si]
    	cmp al,43
    	je Suma
    	cmp al,45
    	je Resta
    	cmp al,24h
    	je AB
    	;cmp al,48
		;jl NoEsNumero
		;cmp al,57
		;jg	NoEsNumero
		;mov Numero[di],al
		;inc di

    jmp IncNumeroE
E endp

B proc
	push si
	mov si,di
	;mov cx,di
	jmp NumeroB

	AM:	
		pop si
		call M
		print probar2
		ret
	divi:
		pop si

	multi:
		pop si
		call M
		call B
		pop ax
		pop bx
		imul bx
		push ax
		ret
		
	IncNumeroB:
		inc si
    NumeroB:

    	mov al,Ecuacion[si]
    	cmp al,42
    	je multi
    	cmp al,47
    	je divi
    	cmp al,24h
    	je AM
    	;cmp al,48
		;jl NoEsNumero
		;cmp al,57
		;jg	NoEsNumero
		;mov Numero[di],al
		;inc di

    jmp IncNumeroB
B endp

M proc
	push si
	mov si,di
	jmp NumeroM
	NoEsNumeroM:
		pop si
		;print Numerou
		ConveInv Numerou
		;push ax
		;LimpiarBuffer Numerou
		ret
	IncNumeroM:
		inc si
    NumeroM:

    	mov al,Ecuacion[si]
    	cmp al,48
		jl NoEsNumeroM
		cmp al,57
		jg	NoEsNumeroM
		mov Numerou[di],al
		inc di

    jmp IncNumeroM
M endp


Factorial PROC
	push bp
	mov  bp,sp
	mov	 ax,[bp+4]    ; get n
	cmp  ax,0     ; n > 0?p
	ja   L1        ; yes: continue
	mov  ax,1          ; no: return 1
	jmp  L2
L1:
	
	dec  ax
	push ax            ; Factorial(n-1)
	call Factorial
ReturnFact:
	mov  bx,[bp+4];get n
	mul  bx              ; edx:eax=eax*ebx
	
	mov ah,02
	mov dx,ax
	int 21h
L2:
	pop  bp      ; return EAX60L2:popebp;returnEAX
	ret  2       ; clean up stack
Factorial ENDP
;================ FIN DE SECCION DE CODIGO ========================
end