include macros.asm

.model small

.stack

.data

bufferentrada db 50 dup('$')
handlerEntrada dw ?
bufferInfo db 500 dup('$')

datos db 50 dup('$'),'$'
aux db 0
contI db 0
contJ db 0

sep db 0ah, 0dh, '==============================================', '$'
universidad db 0ah, 0dh, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', '$'
facultad db 0ah, 0dh, 'FACULTAD DE INGENIERIA','$'
escuela db 0ah, 0dh, 'CIENCIAS Y SISTEMAS','$'
curso db 0ah, 0dh, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1','$'
nombre db 0ah, 0dh, 'NOMBRE: JOSE PABLO COLINDRES ORELLANA','$'
carnet db 0ah, 0dh, 'CARNET: 201602713','$'
seccion db 0ah, 0dh, 'SECCION A','$'
saltoLinea db 0ah, 0dh, ' ','$'
opcion1 db 0ah, 0dh, '1) Cargar Archivo','$'
opcion2 db 0ah, 0dh, '2) Ordenar','$'
opcion3 db 0ah, 0dh, '3) Generar Reporte','$'
opcion4 db 0ah, 0dh, '4) Salir','$'

menu2 db 0ah, 0dh, 'Tipos de Ordenamiento','$'
opcion21 db 0ah, 0dh, '1) Ordenamiento BubbleSort','$'

descen db 0ah, 0dh, '1) Descendente','$'
ascen db 0ah, 0dh, '2) Ascendente','$'

pedirRuta db 0ah, 0dh, 'Ingrese una ruta:','$'

err1 db 0ah, 0dh, 'Error al abrir el archivo!!','$'
err2 db 0ah, 0dh, 'Error al cerrar el archivo!!','$'
err3 db 0ah, 0dh, 'Error al leer el archivo!!','$'
err4 db 0ah, 0dh, 'Error al crear el archivo!!','$'


.code
main proc
    menuPrincipal:
        print universidad
        print facultad
        print escuela
        print curso
        print nombre
        print carnet
        print seccion
        print saltoLinea
        print opcion1
        print opcion2
        print opcion3
        print opcion4
        print saltoLinea
        getchar
        cmp al, 31h
        je Cargar
        cmp al, 32h
        je Ordenar
        cmp al, 33h
        je Generar
        cmp al, 34h
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
		Limpiar datos, SIZEOF datos, 24h
		
		xor si, si
		xor di, di
		
		mov cx, 500
		contar:
			cmp bufferInfo[si], '>'
			je buscarNum
			jmp seguir
			buscarNum:
				inc si
				cmp bufferInfo[si], '1'
				je esNum
				cmp bufferInfo[si], '2'
				je esNum
				cmp bufferInfo[si], '3'
				je esNum
				cmp bufferInfo[si], '4'
				je esNum
				cmp bufferInfo[si], '5'
				je esNum
				cmp bufferInfo[si], '6'
				je esNum
				cmp bufferInfo[si], '7'
				je esNum
				cmp bufferInfo[si], '8'
				je esNum
				cmp bufferInfo[si], '9'
				je esNum
				jmp seguir
			esNum:
				cmp bufferInfo[si+2], '/'
				je esNum1
				cmp bufferInfo[si+2], '<'
				je esNum2
				jmp seguir
			esNum1:
				mov al, bufferInfo[si]
				sub al, 48
				mov datos[di], al
				inc di
				jmp seguir
			esNum2:
				mov al, bufferInfo[si]
				sub al, 48
				mov bl, 10
				mul bl
				add al, bufferInfo[si+1]
				sub al, 48
				mov datos[di], al
				inc di
			seguir:
				inc si
		loop contar

        Cerrar handlerEntrada
		algopaso:
        print sep
		print saltoLinea
		
		print datos
		
		getchar
        jmp menuPrincipal
    Ordenar:
        print saltoLinea
        print sep
		print saltoLinea
		print descen
		print ascen
		print saltoLinea
		xor si, si
		xor cx, cx
		xor di, di
        getchar
		cmp al, 31h
		je DESCEND
		cmp al, 32h
		je ASCEND
		jmp menuPrincipal
	DESCEND:
		mov contI, 0
		ciclo11:
			cmp contI, 24
			je terminarI1
			
			xor si, si
			mov contJ, 0
			ciclo21: 
				cmp contJ, 24
				je terminarJ1
				
				mov al, datos[si+1]
				mov bl, datos[si]
				cmp al, '$'
				je noentra1
				cmp bl, '$'
				je noentra1
				cmp al, bl
				ja entra1
				jmp noentra1
				entra1:
					mov aux, al
					mov datos[si+1], bl
					mov cl, aux
					mov datos[si], cl
					print saltoLinea
					print datos
				noentra1:
				
				inc si
				inc contJ
			jmp ciclo21
			terminarJ1:
			inc contI
		jmp ciclo11
		terminarI1:
		getchar
		jmp menuPrincipal
		
	ASCEND:	
		mov contI, 0
		ciclo1:
			cmp contI, 24
			je terminarI
			
			xor si, si
			mov contJ, 0
			ciclo2: 
				cmp contJ, 24
				je terminarJ
				
				mov al, datos[si]
				mov bl, datos[si+1]
				cmp al, '$'
				je noentra
				cmp bl, '$'
				je noentra
				cmp al, bl
				ja entra
				jmp noentra
				entra:
					mov aux, al
					mov datos[si], bl
					mov cl, aux
					mov datos[si+1], cl
					print saltoLinea
					print datos
				noentra:
				
				inc si
				inc contJ
			jmp ciclo2
			terminarJ:
			inc contI
		jmp ciclo1
		terminarI:
		getchar
		jmp menuPrincipal
    Generar:
        print saltoLinea
        print pedirRuta
		Limpiar bufferentrada, SIZEOF bufferentrada, 24h
		ObtenerRuta bufferentrada
		CrearArchivo bufferentrada, handlerEntrada
        getchar
        jmp menuPrincipal
    Salir:
        mov ah, 4ch
        mov al, al
        int 21h
main endp
end main