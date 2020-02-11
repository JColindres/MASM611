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

;======================================================================================================


.model small

.stack

.data

bufferentrada db 50 dup('$')
handlerEntrada dw ?
bufferInfo db 15000 dup('$'), '$'

laberinto db 15000 dup ('$'), '$'

sep db 0ah, 0dh, '==============================================', '$'
universidad db 0ah, 0dh, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', '$'
facultad db 0ah, 0dh, 'FACULTAD DE INGENIERIA','$'
escuela db 0ah, 0dh, 'CIENCIAS Y SISTEMAS','$'
curso db 0ah, 0dh, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1','$'
seccion db 0ah, 0dh, 'SECCION B','$'
nombre1 db 0ah, 0dh, 'NOMBRE: JOSE PABLO COLINDRES ORELLANA','$'
carnet1 db 0ah, 0dh, 'CARNET: 201602713','$'
nombre2 db 0ah, 0dh, 'NOMBRE: CARLOS MANUEL GARCIA ESCALANTE','$'
carnet2 db 0ah, 0dh, 'CARNET: 201612276','$'
saltoLinea db 0ah, 0dh, ' ','$'
tareaPrac3 db 0ah, 0dh, 'Examen Final - Parte Practica','$'
mePrin db 0ah, 0dh, 'Menu Principal','$'
opcion1 db 0ah, 0dh, '01) Cargar Texto','$'
opcion2 db 0ah, 0dh, '02) Resolver','$'
opcion3 db 0ah, 0dh, '03) Salir','$'
pedirRuta db 0ah, 0dh, 'Ingrese una ruta:','$'

err1 db 0ah, 0dh, 'Error al abrir el archivo!!','$'
err2 db 0ah, 0dh, 'Error al cerrar el archivo!!','$'
err3 db 0ah, 0dh, 'Error al leer el archivo!!','$'
err4 db 0ah, 0dh, 'Error al crear el archivo!!','$'


.code
	.startup
		menuPrincipal:
			print sep
			print universidad
			print facultad
			print escuela
			print curso
			print seccion
			print nombre1
			print carnet1
			print nombre2
			print carnet2
			print saltoLinea
			print tareaPrac3
			print saltoLinea
			print mePrin
			print opcion1
			print opcion2
			print opcion3
			print saltoLinea
			getchar
			cmp al, 31h
			je Cargar
			cmp al, 32h
			je Resolver
			cmp al, 33h
			je Salir
			jmp menuPrincipal
		Cargar:
			print saltoLinea
			print pedirRuta
			Limpiar bufferentrada, SIZEOF bufferentrada, 24h
			ObtenerRuta bufferentrada
			print bufferentrada
			Abrir bufferentrada,handlerEntrada
			Limpiar bufferInfo, SIZEOF bufferInfo, 24h
			Leer handlerEntrada, bufferInfo,SIZEOF bufferInfo
			print saltoLinea
			print sep
			print saltoLinea
			print bufferInfo

			Cerrar handlerEntrada
			algopaso:
			print sep
			print saltoLinea
			getchar
			jmp menuPrincipal
		Resolver:
			call ponercomas
			print saltoLinea
			print sep
			print saltoLinea
			print laberinto
			call esPalabra
			print sep
			print saltoLinea
			getchar
			jmp menuPrincipal
		Salir:
			mov ah, 4ch
			mov al, al
			int 21h
	.exit
	
	ponercomas proc near
		xor si,si
		xor di,di
		print saltoLinea
		print bufferInfo
		SIGUIENTE:
			cmp bufferInfo[si],0dh
			je CAMBIO
			cmp bufferInfo[si],'*'
			je METER
			cmp bufferInfo[si],' '
			je METER
			cmp bufferInfo[si],'E'
			je METER
			cmp bufferInfo[si],'S'
			je METER
			inc si
			cmp bufferInfo[si],'$'
			je FIIIN
			jmp SIGUIENTE
			CAMBIO:
				mov al, ','
				mov laberinto[di],al
				inc di
				jmp SEGIR
			METER:
				mov al,bufferInfo[si]
				mov laberinto[di],al
				inc di
			SEGIR:
				inc si
				jmp SIGUIENTE
		FIIIN:
		ret
	ponercomas endp
	
	esPalabra proc near
		xor si,si
		mov al, bufferInfo[si]
		cmp bufferInfo[si],64
		ja CAP
		cmp bufferInfo[si+1],0ah
		je nel
		jmp ya
		CAP:
			cmp bufferInfo[si],91
			jb entra
			cmp bufferInfo[si],96
			ja MIN
			jmp nel
			MIN:
				cmp bufferInfo[si],123
				jb entra
				jmp nel
			entra:
				inc si
				cmp bufferInfo[si],64
				ja CAP2
				cmp bufferInfo[si],47
				ja NUM
				cmp bufferInfo[si],'_'
				je entra2
				jmp nel
				CAP2:
					cmp bufferInfo[si],91
					jb entra2
					cmp bufferInfo[si],96
					ja MIN2
					jmp nel
					MIN2:
						cmp bufferInfo[si],123
						jb entra2
						jmp nel
				NUM:
					cmp bufferInfo[si],58
					jb entra2
					jmp nel
				entra2:
					cmp bufferInfo[si+1],0ah
					je ya
					jmp entra
		ya:
			print seccion
		nel:
		ret
	esPalabra endp
end



















