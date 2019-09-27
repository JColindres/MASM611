include macroP3.asm

.model small

.stack

.data

bufferentrada db 50 dup('$')
handlerEntrada dw ?
bufferInfo db 10000 dup('$')

contadorLetras dw 0

sep db 0ah, 0dh, '==============================================', '$'
universidad db 0ah, 0dh, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', '$'
facultad db 0ah, 0dh, 'FACULTAD DE INGENIERIA','$'
escuela db 0ah, 0dh, 'CIENCIAS Y SISTEMAS','$'
curso db 0ah, 0dh, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1','$'
seccion db 0ah, 0dh, 'SECCION B','$'
nombre db 0ah, 0dh, 'NOMBRE: JOSE PABLO COLINDRES ORELLANA','$'
carnet db 0ah, 0dh, 'CARNET: 201602713','$'
saltoLinea db 0ah, 0dh, ' ','$'
tareaPrac3 db 0ah, 0dh, 'Tarea Practica 3','$'
mePrin db 0ah, 0dh, 'Menu Principal','$'
opcion1 db 0ah, 0dh, '01) Cargar Texto','$'
opcion2 db 0ah, 0dh, '02) A Mayuscula','$'
opcion3 db 0ah, 0dh, '03) A Minuscula','$'
opcion4 db 0ah, 0dh, '04) A Capital','$'
opcion5 db 0ah, 0dh, '05) Buscar y Reemplazar','$'
opcion6 db 0ah, 0dh, '06) Invertir Palabras','$'
opcion7 db 0ah, 0dh, '07) Reporte Diptongos','$'
opcion8 db 0ah, 0dh, '08) Reporte Hiatos','$'
opcion9 db 0ah, 0dh, '09) Reporte Triptongos','$'
opcion10 db 0ah, 0dh, '10) Reporte Final','$'
opcion11 db 0ah, 0dh, '11) Salir','$'

pedirRuta db 0ah, 0dh, 'Ingrese una ruta:','$'

err1 db 0ah, 0dh, 'Error al abrir el archivo!!','$'
err2 db 0ah, 0dh, 'Error al cerrar el archivo!!','$'
err3 db 0ah, 0dh, 'Error al leer el archivo!!','$'
err4 db 0ah, 0dh, 'Error al crear el archivo!!','$'


.code
	.startup
		menuPrincipal:
			print universidad
			print facultad
			print escuela
			print curso
			print seccion
			print nombre
			print carnet
			print saltoLinea
			print tareaPrac3
			print saltoLinea
			print mePrin
			print opcion1
			print opcion2
			print opcion3
			print opcion4
			print opcion5
			print opcion6
			print opcion7
			print opcion8
			print opcion9
			print opcion10
			print opcion11
			print saltoLinea
			getchar
			cmp al, 30h
			je UNIDAD
			cmp al, 31h
			je DECENA
			UNIDAD:
				getchar
				cmp al, 31h
				je Cargar
				cmp al, 32h
				je AMAYUS
				cmp al, 33h
				je AMINUS
				cmp al, 34h
				je ACAPITAL
				cmp al, 35h
				je BUSYREM
				cmp al, 36h
				je INVPAL
				cmp al, 37h
				je REPDIP
				cmp al, 38h
				je REPHIAT
				cmp al, 39h
				je REPTRIP
			DECENA:
				getchar
				cmp al, 30h
				je REPFINAL
				cmp al, 31h
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
		AMAYUS:
			print saltoLinea
			
			xor si,si
			
			mov cx,10000
			contarMA:
				cmp bufferInfo[si], 96
				ja mayor96	
				jmp nelMayus
				mayor96:
					cmp bufferInfo[si], 123
					jb sientraMayus
					jmp nelMayus
					sientraMayus:
						mov al, bufferInfo[si]
						sub al, 32
						mov bufferInfo[si], al
						jmp nelMayus
				nelMayus:
				call mayusP
				inc si	
			loop contarMA
			print saltoLinea
			print sep
			print saltoLinea
			print bufferInfo
			print sep
			getchar
			jmp menuPrincipal
		AMINUS:
			print saltoLinea
			
			xor si,si
			
			mov cx,10000
			contarMI:
				cmp bufferInfo[si], 64
				ja mayor64
				jmp nelMinus
				mayor64:
					cmp bufferInfo[si], 91
					jb sientraMinus
					jmp nelMinus
					sientraMinus:
						mov al, bufferInfo[si]
						add al, 32
						mov bufferInfo[si], al
						jmp nelMinus
				nelMinus:
				call minusP	
				inc si			
			loop contarMI
			print saltoLinea
			print sep
			print saltoLinea
			print bufferInfo
			print sep
			getchar
			jmp menuPrincipal
		ACAPITAL:
			print saltoLinea
			
			xor si, si
			mov contadorLetras, 0
			
			mov cx,10000
			contarCAP:
				call capP1
			loop contarCAP
			print saltoLinea
			print sep
			print saltoLinea
			print bufferInfo
			print sep
			getchar
			jmp menuPrincipal
		BUSYREM:
		INVPAL:
		REPDIP:
		REPHIAT:
		REPTRIP:
		REPFINAL:
		Salir:
			mov ah, 4ch
			mov al, al
			int 21h
	.exit
	
	mayusP proc near
		cmp bufferInfo[si], 00E1h
		je a1Mayus
		cmp bufferInfo[si], 00E9h
		je e1Mayus
		cmp bufferInfo[si], 00EDh
		je i1Mayus
		cmp bufferInfo[si], 00F3h
		je o1Mayus
		cmp bufferInfo[si], 00FAh
		je u1Mayus
		cmp bufferInfo[si], 00E4h
		je a2Mayus
		cmp bufferInfo[si], 00EBh
		je e2Mayus
		cmp bufferInfo[si], 00EFh
		je i2Mayus
		cmp bufferInfo[si], 00F6h
		je o2Mayus
		cmp bufferInfo[si], 00FCh
		je u2Mayus
		jmp nelMayus2
		a1Mayus:
			print carnet
			mov bufferInfo[si], 00C1h
			jmp nelMayus2
		e1Mayus:
			mov bufferInfo[si], 00C9h
			jmp nelMayus2
		i1Mayus:
			mov bufferInfo[si], 00CDh
			jmp nelMayus2
		o1Mayus:
			mov bufferInfo[si], 00D3h
			jmp nelMayus2
		u1Mayus:
			mov bufferInfo[si], 00DAh
			jmp nelMayus2
		a2Mayus:
			mov bufferInfo[si], 00C4h
			jmp nelMayus2
		e2Mayus:
			mov bufferInfo[si], 00CBh
			jmp nelMayus2
		i2Mayus:
			mov bufferInfo[si], 00CFh
			jmp nelMayus2
		o2Mayus:
			mov bufferInfo[si], 00D6h
			jmp nelMayus2
		u2Mayus:
			mov bufferInfo[si], 00DCh
			jmp nelMayus2
		nelMayus2:	
		ret
	mayusP endp
	
	minusP proc near
		cmp bufferInfo[si], 00C1h
		je a1Minus
		cmp bufferInfo[si], 00C9h
		je e1Minus
		cmp bufferInfo[si], 00CDh
		je i1Minus
		cmp bufferInfo[si], 00D3h
		je o1Minus
		cmp bufferInfo[si], 00DAh
		je u1Minus
		cmp bufferInfo[si], 00C4h
		je a2Minus
		cmp bufferInfo[si], 00CBh
		je e2Minus
		cmp bufferInfo[si], 00CFh
		je i2Minus
		cmp bufferInfo[si], 00D6h
		je o2Minus
		cmp bufferInfo[si], 00DCh
		je u2Minus
		jmp nelMinus2
		a1Minus:
			mov bufferInfo[si], 00E1h 
			jmp nelMinus2
		e1Minus:
			mov bufferInfo[si], 00E9h
			jmp nelMinus2
		i1Minus:
			mov bufferInfo[si], 00EDh
			jmp nelMinus2
		o1Minus:
			mov bufferInfo[si], 00F3h
			jmp nelMinus2
		u1Minus:
			mov bufferInfo[si], 00FAh
			jmp nelMinus2
		a2Minus:
			mov bufferInfo[si], 00E4h
			jmp nelMinus2
		e2Minus:
			mov bufferInfo[si], 00EBh
			jmp nelMinus2
		i2Minus:
			mov bufferInfo[si], 00EFh
			jmp nelMinus2
		o2Minus:
			mov bufferInfo[si], 00F6h
			jmp nelMinus2
		u2Minus:
			mov bufferInfo[si], 00FCh
			jmp nelMinus2
		nelMinus2:
		ret
	minusP endp
	
	capP1 proc far
		mov al,bufferInfo[si]
    	cmp bufferInfo[si], 64
    	ja CAP1 
    	cmp bufferInfo[si+1], 36
    	je YEET  
    	jmp nainCAP
    	CAP1: 
      		cmp bufferInfo[si], 91
        	jb CAPFinal
       		cmp bufferInfo[si], 96
   			ja CAP2
        	jmp nainCAP
       	CAP2: 
        	cmp bufferInfo[si], 123
        	jb CAPFinal
        	jmp nainCAP
        CAPFinal: 
        	dec si 
        	cmp bufferInfo[si], 9
        	je segCAP 
        	cmp bufferInfo[si], 10
        	je segCAP 
        	cmp bufferInfo[si], 11
        	je segCAP 
        	cmp bufferInfo[si], 12
        	je segCAP 
        	cmp bufferInfo[si], 13
        	je segCAP 
        	cmp bufferInfo[si], 32
        	je segCAP
        	cmp bufferInfo[si], 34
        	je segCAP
        	cmp bufferInfo[si], 39
        	je segCAP
        	cmp bufferInfo[si], 40
        	je segCAP
        	cmp bufferInfo[si], 91
        	je segCAP
        	cmp bufferInfo[si], 123
        	je segCAP
        	jmp nainCAPP
        	segCAP:
        		inc si
        		push si
        		push contadorLetras
        		inc si
        		CICLO:
        		    mov al,bufferInfo[si]
        			cmp bufferInfo[si], 9
        			je ESPALABRA
        			cmp bufferInfo[si], 10
        			je ESPALABRA
        			cmp bufferInfo[si], 11
        			je ESPALABRA
        			cmp bufferInfo[si], 12
        			je ESPALABRA
        			cmp bufferInfo[si], 13
        			je ESPALABRA
        			cmp bufferInfo[si], 32
        			je ESPALABRA  
        			cmp bufferInfo[si], 36
        			je ESPALABRA 
        			cmp bufferInfo[si], 64
        			ja CAP12
        			jmp nainCAP2
        			CAP12:
        				cmp bufferInfo[si], 91
        				jb MINIMIZAR
        				cmp bufferInfo[si], 96
        				ja CAP22
        				jmp nainCAP2
        			MINIMIZAR:
        				mov al, bufferInfo[si]
        				add al, 32
        				mov bufferInfo[si], al
        				jmp CAPFinal2
        			CAP22:
        				cmp bufferInfo[si], 123
        				jb CAPFinal2
        				jmp nainCAP2
        			CAPFinal2:
        				inc si
        				inc contadorLetras
        				jmp CICLO
        			ESPALABRA:   
        				pop si
        				mov al, bufferInfo[si]
        				sub al, 32
        				mov bufferInfo[si], al
        				mov si, contadorLetras
						print bufferInfo
						getchar
        				jmp nainCAP
        			nainCAP2:
        			pop si 
        			pop contadorLetras
        			jmp nainCAP 
       	YEET:
       	    mov cx,1   
       	nainCAPP:
       		inc si
       	nainCAP:
       		inc si
       		inc contadorLetras
		ret
	capP1 endp

end 
	
	