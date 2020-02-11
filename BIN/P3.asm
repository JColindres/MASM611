;MASM
include macroP3.asm

.model small

.stack

.data

bufferentrada db 50 dup('$')
handlerEntrada dw ?
bufferInfo db 10000 dup('$')

bufferInfo2 db 250 dup('$')

bufferInfo3 db 250 dup('$')

bufferInfoAuxiliar db 7000 dup('$')
bufferInfoFinal db 7000 dup('$')

archDIP db 'REPDIP.html ',0
archHIA db 'REPHIAT.html',0
archTRI db 'REPTRIP.html',0
archFIN db 'REPFINAL.txt',0
handCrear dw ?

nomnom db 100 dup(' '),'$'
text2_size = $ - offset nomnom

contadorLetras dw 0
aux1 dw 0
aux2 dw 0
otroaux1 dw 0
otroaux2 dw 0
otroaux22 dw 0
otroaux3 dw 0
contadorAUX dw 0
contadorAUX2 dw 0

listaPalabras db 8000 dup(' ')
listaDiptongos db 8000 dup(' ')
listaHiatos db 8000 dup('$'),'$'
listaTriptongos db 8000 dup(' ')

contadorPalab dw 0
contadorDip dw 0
contadorHia dw 0
contadorTri dw 0

contadorPalab2 dw 0
contadorPalab3 dw 0

horas DB ?, '$'
minutos DB ?, '$'
segundos DB ?, '$'
dia_mes DB ?, '$'
mes DB ?, '$'

dia_mes_conv DB ?, ?, '$'
mes_conv DB ?, ?, '$'
anio_conv DB '1', '9', '$'
horas_conv DB ?, ?, '$'
min_conv DB ?, ?, '$'
seg_conv DB ?, ?, '$'

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
			mov contadorPalab, 0
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
			call repifinal
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
			call seAPLICO
			call filtroMAYUS
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
			call seAPLICO
			call filtroMINUS
			getchar
			jmp menuPrincipal
		ACAPITAL:
			print saltoLinea
			
			xor si, si
			mov contadorLetras, 0
			
			mov cx,10000
			contarCAP:
				call capP
			loop contarCAP
			print saltoLinea
			print sep
			print saltoLinea
			print bufferInfo
			print sep
			call seAPLICO
			call filtroCAPI
			getchar
			jmp menuPrincipal
		BUSYREM:
			call reemplazar
			call seAPLICO
			call filtroBYR
			getchar
			jmp menuPrincipal
		INVPAL:
			print saltoLinea
			
			xor si, si
			mov contadorLetras, 0
			
			mov cx,10000
			contarINV:
				call invP
			loop contarINV
			print saltoLinea
			print sep
			print saltoLinea
			print bufferInfo
			print sep
			call seAPLICO
			call filtroINV
			getchar
			jmp menuPrincipal
		REPDIP:
			call encabezadoDIP
			call encabezadoTRIP
			print saltoLinea
			
			xor si, si
			mov contadorLetras, 0
			
			mov cx,10000
			contarINVVV:
				call verificarP
			loop contarINVVV
			print saltoLinea
			print sep
			print saltoLinea
			print bufferInfo
			print sep
			call finREPGENERAL
			call finREPGENERALTRIP
			Editar archDIP, listaDiptongos, handCrear
			getchar
			jmp menuPrincipal
		REPHIAT:
		REPTRIP:
			print saltoLinea
			print saltoLinea
			print sep
			print saltoLinea
			print bufferInfo
			print sep
			Editar archTRI, listaTriptongos, handCrear
			getchar
			jmp menuPrincipal
		REPFINAL:
			print saltoLinea
			print saltoLinea
			print sep
			print saltoLinea
			print bufferInfo
			print sep
			Editar archFIN, listaPalabras, handCrear
			Editar archFIN, bufferInfo, handCrear
			getchar
			jmp menuPrincipal
		Salir:
			mov ah, 4ch
			mov al, al
			int 21h
	.exit
	
	mayusP proc near
		cmp bufferInfo[si], 00F1h
		je n1Mayus
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
		n1Mayus:
			mov bufferInfo[si], 00D1h
			jmp nelMayus2
		a1Mayus:
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
		cmp bufferInfo[si], 00D1h
		je n1Minus
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
		n1Minus:
			mov bufferInfo[si], 00F1h 
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
	
	capP proc far
		mov al,bufferInfo[si]
    	cmp bufferInfo[si], 64
    	ja CAP1 
    	cmp bufferInfo[si+1], 36
    	je YEET  
    	jmp nainCAP
    	CAP1: 
      		cmp bufferInfo[si], 91
        	jb MINIR
       		cmp bufferInfo[si], 96
   			ja CAP2
        	jmp nainCAP
		MINIR:
        	mov al, bufferInfo[si]
			add al, 32
        	mov bufferInfo[si], al
        	jmp CAPFinal
       	CAP2: 
        	cmp bufferInfo[si], 123
        	jb CAPFinal
			cmp bufferInfo[si], 00E1h
			je CAPFinal
			cmp bufferInfo[si], 00E9h
			je CAPFinal
			cmp bufferInfo[si], 00EDh
			je CAPFinal
			cmp bufferInfo[si], 00F3h
			je CAPFinal
			cmp bufferInfo[si], 00FAh
			je CAPFinal
			cmp bufferInfo[si], 00C1h
			je CAPFinal
			cmp bufferInfo[si], 00C9h
			je CAPFinal
			cmp bufferInfo[si], 00CDh
			je CAPFinal
			cmp bufferInfo[si], 00D3h
			je CAPFinal
			cmp bufferInfo[si], 00DAh
			je CAPFinal
			cmp bufferInfo[si], 00E4h
			je CAPFinal
			cmp bufferInfo[si], 00EBh
			je CAPFinal
			cmp bufferInfo[si], 00EFh
			je CAPFinal
			cmp bufferInfo[si], 00F6h
			je CAPFinal
			cmp bufferInfo[si], 00FCh
			je CAPFinal
			cmp bufferInfo[si], 00C4h
			je CAPFinal
			cmp bufferInfo[si], 00CBh
			je CAPFinal
			cmp bufferInfo[si], 00CFh
			je CAPFinal
			cmp bufferInfo[si], 00D6h
			je CAPFinal
			cmp bufferInfo[si], 00DCh
			je CAPFinal		
			cmp bufferInfo[si], 00F1h
			je CAPFinal		
			cmp bufferInfo[si], 00D1h
			je CAPFinal		
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
        		mov aux1, si
        		mov ax, contadorLetras
				mov aux2, ax
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
        			cmp bufferInfo[si], 34
        			je ESPALABRA 
        			cmp bufferInfo[si], 36
        			je ESPALABRA 
        			cmp bufferInfo[si], 39
        			je ESPALABRA 
        			cmp bufferInfo[si], 41
        			je ESPALABRA 
        			cmp bufferInfo[si], 44
        			je ESPALABRA 
        			cmp bufferInfo[si], 46
        			je ESPALABRA 
        			cmp bufferInfo[si], 58
        			je ESPALABRA 
        			cmp bufferInfo[si], 59
        			je ESPALABRA 
        			cmp bufferInfo[si], 63
        			je ESPALABRA 
        			cmp bufferInfo[si], 93
        			je ESPALABRA 
        			cmp bufferInfo[si], 125
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
						cmp bufferInfo[si], 00E1h
						je CAPFinal2
						cmp bufferInfo[si], 00E9h
						je CAPFinal2
						cmp bufferInfo[si], 00EDh
						je CAPFinal2
						cmp bufferInfo[si], 00F3h
						je CAPFinal2
						cmp bufferInfo[si], 00FAh
						je CAPFinal2
						cmp bufferInfo[si], 00C1h
						je CAPFinal2
						cmp bufferInfo[si], 00C9h
						je CAPFinal2
						cmp bufferInfo[si], 00CDh
						je CAPFinal2
						cmp bufferInfo[si], 00D3h
						je CAPFinal2
						cmp bufferInfo[si], 00DAh
						je CAPFinal2
						cmp bufferInfo[si], 00E4h
						je CAPFinal2
						cmp bufferInfo[si], 00EBh
						je CAPFinal2
						cmp bufferInfo[si], 00EFh
						je CAPFinal2
						cmp bufferInfo[si], 00F6h
						je CAPFinal2
						cmp bufferInfo[si], 00FCh
						je CAPFinal2
						cmp bufferInfo[si], 00C4h
						je CAPFinal2
						cmp bufferInfo[si], 00CBh
						je CAPFinal2
						cmp bufferInfo[si], 00CFh
						je CAPFinal2
						cmp bufferInfo[si], 00D6h
						je CAPFinal2
						cmp bufferInfo[si], 00DCh
						je CAPFinal2		
						cmp bufferInfo[si], 00F1h
						je CAPFinal2		
						cmp bufferInfo[si], 00D1h
						je CAPFinal2	
        				jmp nainCAP2
        			CAPFinal2:
        				inc si
        				inc contadorLetras
        				jmp CICLO
        			ESPALABRA:   
        				mov si, aux1
        				mov al, bufferInfo[si]
        				sub al, 32
        				mov bufferInfo[si], al
        				mov si, contadorLetras
						print bufferInfo
						;getchar
        				jmp nainCAP
        			nainCAP2:
        			mov si, aux1 
					mov ax, aux2
        			mov contadorLetras, ax
        			jmp nainCAP 
       	YEET:
       	    mov cx,1   
       	nainCAPP:
       		inc si
       	nainCAP:
       		inc si
       		inc contadorLetras
		ret
	capP endp
	
	invP proc far
		mov al,bufferInfo[si]
    	cmp bufferInfo[si], 64
    	ja invCAP1 
    	cmp bufferInfo[si+1], 36
    	je invYEET  
    	jmp invnainCAP
    	invCAP1: 
      		cmp bufferInfo[si], 91
        	jb invCAPFinal
       		cmp bufferInfo[si], 96
   			ja invCAP2
        	jmp invnainCAP
       	invCAP2: 
        	cmp bufferInfo[si], 123
        	jb invCAPFinal
			cmp bufferInfo[si], 00E1h
			je invCAPFinal
			cmp bufferInfo[si], 00E9h
			je invCAPFinal
			cmp bufferInfo[si], 00EDh
			je invCAPFinal
			cmp bufferInfo[si], 00F3h
			je invCAPFinal
			cmp bufferInfo[si], 00FAh
			je invCAPFinal
			cmp bufferInfo[si], 00C1h
			je invCAPFinal
			cmp bufferInfo[si], 00C9h
			je invCAPFinal
			cmp bufferInfo[si], 00CDh
			je invCAPFinal
			cmp bufferInfo[si], 00D3h
			je invCAPFinal
			cmp bufferInfo[si], 00DAh
			je invCAPFinal
			cmp bufferInfo[si], 00E4h
			je invCAPFinal
			cmp bufferInfo[si], 00EBh
			je invCAPFinal
			cmp bufferInfo[si], 00EFh
			je invCAPFinal
			cmp bufferInfo[si], 00F6h
			je invCAPFinal
			cmp bufferInfo[si], 00FCh
			je invCAPFinal
			cmp bufferInfo[si], 00C4h
			je invCAPFinal
			cmp bufferInfo[si], 00CBh
			je invCAPFinal
			cmp bufferInfo[si], 00CFh
			je invCAPFinal
			cmp bufferInfo[si], 00D6h
			je invCAPFinal
			cmp bufferInfo[si], 00DCh
			je invCAPFinal		
			cmp bufferInfo[si], 00F1h
			je invCAPFinal		
			cmp bufferInfo[si], 00D1h
			je invCAPFinal		
        	jmp invnainCAP
        invCAPFinal: 
        	dec si 
        	cmp bufferInfo[si], 9
        	je invsegCAP 
        	cmp bufferInfo[si], 10
        	je invsegCAP 
        	cmp bufferInfo[si], 11
        	je invsegCAP 
        	cmp bufferInfo[si], 12
        	je invsegCAP 
        	cmp bufferInfo[si], 13
        	je invsegCAP 
        	cmp bufferInfo[si], 32
        	je invsegCAP
        	cmp bufferInfo[si], 34
        	je invsegCAP
        	cmp bufferInfo[si], 39
        	je invsegCAP
        	cmp bufferInfo[si], 40
        	je invsegCAP
        	cmp bufferInfo[si], 91
        	je invsegCAP
        	cmp bufferInfo[si], 123
        	je invsegCAP
        	jmp invnainCAPP
        	invsegCAP:
        		inc si
				
				mov contadorAUX, 1
				mov bx,contadorAUX
				mov al, bufferInfo[si]
				mov nomnom[bx],al
				
        		mov aux1, si
        		mov ax, contadorLetras
				mov aux2, ax
        		inc si
        		invCICLO:
        		    mov al,bufferInfo[si]
        			cmp bufferInfo[si], 9
        			je invESPALABRA
        			cmp bufferInfo[si], 10
        			je invESPALABRA
        			cmp bufferInfo[si], 11
        			je invESPALABRA
        			cmp bufferInfo[si], 12
        			je invESPALABRA
        			cmp bufferInfo[si], 13
        			je invESPALABRA
        			cmp bufferInfo[si], 32
        			je invESPALABRA  
        			cmp bufferInfo[si], 34
        			je invESPALABRA 
        			cmp bufferInfo[si], 36
        			je invESPALABRA 
        			cmp bufferInfo[si], 39
        			je invESPALABRA 
        			cmp bufferInfo[si], 41
        			je invESPALABRA 
        			cmp bufferInfo[si], 44
        			je invESPALABRA 
        			cmp bufferInfo[si], 46
        			je invESPALABRA 
        			cmp bufferInfo[si], 58
        			je invESPALABRA 
        			cmp bufferInfo[si], 59
        			je invESPALABRA 
        			cmp bufferInfo[si], 63
        			je invESPALABRA 
        			cmp bufferInfo[si], 93
        			je invESPALABRA 
        			cmp bufferInfo[si], 125
        			je invESPALABRA 
        			cmp bufferInfo[si], 64
        			ja invCAP12
        			jmp invnainCAP2
        			invCAP12:
        				cmp bufferInfo[si], 91
        				jb invCAPFinal2
        				cmp bufferInfo[si], 96
        				ja invCAP22
        				jmp invnainCAP2
        			invCAP22:
        				cmp bufferInfo[si], 123
        				jb invCAPFinal2
						cmp bufferInfo[si], 00E1h
						je invCAPFinal2
						cmp bufferInfo[si], 00E9h
						je invCAPFinal2
						cmp bufferInfo[si], 00EDh
						je invCAPFinal2
						cmp bufferInfo[si], 00F3h
						je invCAPFinal2
						cmp bufferInfo[si], 00FAh
						je invCAPFinal2
						cmp bufferInfo[si], 00C1h
						je invCAPFinal2
						cmp bufferInfo[si], 00C9h
						je invCAPFinal2
						cmp bufferInfo[si], 00CDh
						je invCAPFinal2
						cmp bufferInfo[si], 00D3h
						je invCAPFinal2
						cmp bufferInfo[si], 00DAh
						je invCAPFinal2
						cmp bufferInfo[si], 00E4h
						je invCAPFinal2
						cmp bufferInfo[si], 00EBh
						je invCAPFinal2
						cmp bufferInfo[si], 00EFh
						je invCAPFinal2
						cmp bufferInfo[si], 00F6h
						je invCAPFinal2
						cmp bufferInfo[si], 00FCh
						je invCAPFinal2
						cmp bufferInfo[si], 00C4h
						je invCAPFinal2
						cmp bufferInfo[si], 00CBh
						je invCAPFinal2
						cmp bufferInfo[si], 00CFh
						je invCAPFinal2
						cmp bufferInfo[si], 00D6h
						je invCAPFinal2
						cmp bufferInfo[si], 00DCh
						je invCAPFinal2		
						cmp bufferInfo[si], 00F1h
						je invCAPFinal2		
						cmp bufferInfo[si], 00D1h
						je invCAPFinal2	
        				jmp invnainCAP2
        			invCAPFinal2:
						inc contadorAUX
						
						mov bx,contadorAUX
						mov al, bufferInfo[si]
						mov nomnom[bx],al
						
        				inc si
        				inc contadorLetras
        				jmp invCICLO
        			invESPALABRA:   
        				mov si, aux1
						
						mov bx,contadorAUX
						mov cx,contadorAUX
						CICLOn:
							mov al,nomnom[bx]
							mov bufferInfo[si],al
							inc si
							dec bx
						loop CICLOn
						Limpiar nomnom, SIZEOF nomnom, 24h
        				mov si, contadorLetras
        				jmp invnainCAP
        			invnainCAP2:
        			mov si, aux1 
					mov ax, aux2
        			mov contadorLetras, ax
        			jmp invnainCAP 
       	invYEET:
       	    mov cx,1   
       	invnainCAPP:
       		inc si
       	invnainCAP:
       		inc si
       		inc contadorLetras
		ret
	invP endp
	
	verificarP proc far
		mov al,bufferInfo[si]
    	cmp bufferInfo[si], 64
    	ja veriCAP1
    	cmp bufferInfo[si+1], 36
    	je veriYEET  
    	jmp verinainCAP
    	veriCAP1: 
      		cmp bufferInfo[si], 91
        	jb veriCAPFinal
       		cmp bufferInfo[si], 96
   			ja veriCAP2
        	jmp verinainCAP
       	veriCAP2: 
        	cmp bufferInfo[si], 123
        	jb veriCAPFinal
			cmp bufferInfo[si], 00E1h
			je veriCAPFinal
			cmp bufferInfo[si], 00E9h
			je veriCAPFinal
			cmp bufferInfo[si], 00EDh
			je veriCAPFinal
			cmp bufferInfo[si], 00F3h
			je veriCAPFinal
			cmp bufferInfo[si], 00FAh
			je veriCAPFinal
			cmp bufferInfo[si], 00C1h
			je veriCAPFinal
			cmp bufferInfo[si], 00C9h
			je veriCAPFinal
			cmp bufferInfo[si], 00CDh
			je veriCAPFinal
			cmp bufferInfo[si], 00D3h
			je veriCAPFinal
			cmp bufferInfo[si], 00DAh
			je veriCAPFinal
			cmp bufferInfo[si], 00E4h
			je veriCAPFinal
			cmp bufferInfo[si], 00EBh
			je veriCAPFinal
			cmp bufferInfo[si], 00EFh
			je veriCAPFinal
			cmp bufferInfo[si], 00F6h
			je veriCAPFinal
			cmp bufferInfo[si], 00FCh
			je veriCAPFinal
			cmp bufferInfo[si], 00C4h
			je veriCAPFinal
			cmp bufferInfo[si], 00CBh
			je veriCAPFinal
			cmp bufferInfo[si], 00CFh
			je veriCAPFinal
			cmp bufferInfo[si], 00D6h
			je veriCAPFinal
			cmp bufferInfo[si], 00DCh
			je veriCAPFinal		
			cmp bufferInfo[si], 00F1h
			je veriCAPFinal		
			cmp bufferInfo[si], 00D1h
			je veriCAPFinal		
        	jmp verinainCAP
        veriCAPFinal: 
        	dec si 
        	cmp bufferInfo[si], 9
        	je verisegCAP 
        	cmp bufferInfo[si], 10
        	je verisegCAP 
        	cmp bufferInfo[si], 11
        	je verisegCAP 
        	cmp bufferInfo[si], 12
        	je verisegCAP 
        	cmp bufferInfo[si], 13
        	je verisegCAP 
        	cmp bufferInfo[si], 32
        	je verisegCAP
        	cmp bufferInfo[si], 34
        	je verisegCAP
        	cmp bufferInfo[si], 39
        	je verisegCAP
        	cmp bufferInfo[si], 40
        	je verisegCAP
        	cmp bufferInfo[si], 91
        	je verisegCAP
        	cmp bufferInfo[si], 123
        	je verisegCAP
        	jmp verinainCAPP
        	verisegCAP:
        		inc si
				
				mov contadorAUX, 1
				mov bx,contadorAUX
				mov al, bufferInfo[si]
				mov nomnom[bx],al
				
        		mov aux1, si
        		mov ax, contadorLetras
				mov aux2, ax
        		inc si
        		veriCICLO:
        		    mov al,bufferInfo[si]
        			cmp bufferInfo[si], 9
        			je veriESPALABRA
        			cmp bufferInfo[si], 10
        			je veriESPALABRA
        			cmp bufferInfo[si], 11
        			je veriESPALABRA
        			cmp bufferInfo[si], 12
        			je veriESPALABRA
        			cmp bufferInfo[si], 13
        			je veriESPALABRA
        			cmp bufferInfo[si], 32
        			je veriESPALABRA  
        			cmp bufferInfo[si], 34
        			je veriESPALABRA 
        			cmp bufferInfo[si], 36
        			je veriESPALABRA 
        			cmp bufferInfo[si], 39
        			je veriESPALABRA 
        			cmp bufferInfo[si], 41
        			je veriESPALABRA 
        			cmp bufferInfo[si], 44
        			je veriESPALABRA 
        			cmp bufferInfo[si], 46
        			je veriESPALABRA 
        			cmp bufferInfo[si], 58
        			je veriESPALABRA 
        			cmp bufferInfo[si], 59
        			je veriESPALABRA 
        			cmp bufferInfo[si], 63
        			je veriESPALABRA 
        			cmp bufferInfo[si], 93
        			je veriESPALABRA 
        			cmp bufferInfo[si], 125
        			je veriESPALABRA 
        			cmp bufferInfo[si], 64
        			ja veriCAP12	
        			jmp verinainCAP2
        			veriCAP12:
        				cmp bufferInfo[si], 91
        				jb veriCAPFinal2
        				cmp bufferInfo[si], 96
        				ja veriCAP22
        				jmp verinainCAP2
        			veriCAP22:
        				cmp bufferInfo[si], 123
        				jb veriCAPFinal2
						cmp bufferInfo[si], 00E1h
						je veriCAPFinal2
						cmp bufferInfo[si], 00E9h
						je veriCAPFinal2
						cmp bufferInfo[si], 00EDh
						je veriCAPFinal2
						cmp bufferInfo[si], 00F3h
						je veriCAPFinal2
						cmp bufferInfo[si], 00FAh
						je veriCAPFinal2
						cmp bufferInfo[si], 00C1h
						je veriCAPFinal2
						cmp bufferInfo[si], 00C9h
						je veriCAPFinal2
						cmp bufferInfo[si], 00CDh
						je veriCAPFinal2
						cmp bufferInfo[si], 00D3h
						je veriCAPFinal2
						cmp bufferInfo[si], 00DAh
						je veriCAPFinal2
						cmp bufferInfo[si], 00E4h
						je veriCAPFinal2
						cmp bufferInfo[si], 00EBh
						je veriCAPFinal2
						cmp bufferInfo[si], 00EFh
						je veriCAPFinal2
						cmp bufferInfo[si], 00F6h
						je veriCAPFinal2
						cmp bufferInfo[si], 00FCh
						je veriCAPFinal2
						cmp bufferInfo[si], 00C4h
						je veriCAPFinal2
						cmp bufferInfo[si], 00CBh
						je veriCAPFinal2
						cmp bufferInfo[si], 00CFh
						je veriCAPFinal2
						cmp bufferInfo[si], 00D6h
						je veriCAPFinal2
						cmp bufferInfo[si], 00DCh
						je veriCAPFinal2		
						cmp bufferInfo[si], 00F1h
						je veriCAPFinal2		
						cmp bufferInfo[si], 00D1h
						je veriCAPFinal2	
        				jmp verinainCAP2
        			veriCAPFinal2:
						inc contadorAUX
						
						mov bx,contadorAUX
						mov al, bufferInfo[si]
						mov nomnom[bx],al
						
        				inc si
        				inc contadorLetras
        				jmp veriCICLO
        			veriESPALABRA:   
        				mov si, aux1
						
						mov cx,contadorAUX
						veriCICLOn:
							call verificarP2
						loop veriCICLOn
						
        				mov si, contadorLetras
        				jmp verinainCAP
        			verinainCAP2:
        			mov si, aux1 
					mov ax, aux2
        			mov contadorLetras, ax
        			jmp verinainCAP 
       	veriYEET:
       	    mov cx,1   
       	verinainCAPP:
       		inc si
       	verinainCAP:
       		inc si
       		inc contadorLetras
		ret
	verificarP endp

	verificarP2 proc near
		cmp bufferInfo[si], 65
		je esLetraYAS
		cmp bufferInfo[si], 69
		je esLetraYAS
		cmp bufferInfo[si], 73
		je esLetraYAS
		cmp bufferInfo[si], 79
		je esLetraYAS
		cmp bufferInfo[si], 85
		je esLetraYAS
		cmp bufferInfo[si], 97
		je esLetraYAS
		cmp bufferInfo[si], 101
		je esLetraYAS
		cmp bufferInfo[si], 105
		je esLetraYAS
		cmp bufferInfo[si], 111
		je esLetraYAS
		cmp bufferInfo[si], 117
		je esLetraYAS
		cmp bufferInfo[si], 00E1h
		je esLetraYAS
		cmp bufferInfo[si], 00E9h
		je esLetraYAS
		cmp bufferInfo[si], 00EDh
		je esLetraYAS
		cmp bufferInfo[si], 00F3h
		je esLetraYAS
		cmp bufferInfo[si], 00FAh
		je esLetraYAS
		cmp bufferInfo[si], 00C1h
		je esLetraYAS
		cmp bufferInfo[si], 00C9h
		je esLetraYAS
		cmp bufferInfo[si], 00CDh
		je esLetraYAS
		cmp bufferInfo[si], 00D3h
		je esLetraYAS
		cmp bufferInfo[si], 00DAh
		je esLetraYAS
		cmp bufferInfo[si], 00E4h
		je esLetraYAS
		cmp bufferInfo[si], 00EBh
		je esLetraYAS
		cmp bufferInfo[si], 00EFh
		je esLetraYAS
		cmp bufferInfo[si], 00F6h
		je esLetraYAS
		cmp bufferInfo[si], 00FCh
		je esLetraYAS
		cmp bufferInfo[si], 00C4h
		je esLetraYAS
		cmp bufferInfo[si], 00CBh
		je esLetraYAS
		cmp bufferInfo[si], 00CFh
		je esLetraYAS
		cmp bufferInfo[si], 00D6h
		je esLetraYAS
		cmp bufferInfo[si], 00DCh
		je esLetraYAS
		cmp bufferInfo[si], 72
		je esHACHE
		cmp bufferInfo[si], 104
		je esHACHE
		jmp noLetra
		esLetraYAS:
			inc contadorAUX2
			cmp contadorAUX2, 2
			je esDIPHIAT
			cmp contadorAUX2, 3
			je esTRIPTONGO
			jmp veriSigue
			esDIPHIAT:
				cmp bufferInfo[si+1], 65
				je esLetraYAS
				cmp bufferInfo[si+1], 69
				je esLetraYAS
				cmp bufferInfo[si+1], 73
				je esLetraYAS
				cmp bufferInfo[si+1], 79
				je esLetraYAS
				cmp bufferInfo[si+1], 85
				je esLetraYAS
				cmp bufferInfo[si+1], 97
				je esLetraYAS
				cmp bufferInfo[si+1], 101
				je esLetraYAS
				cmp bufferInfo[si+1], 105
				je esLetraYAS
				cmp bufferInfo[si+1], 111
				je esLetraYAS
				cmp bufferInfo[si+1], 117
				je esLetraYAS
				cmp bufferInfo[si+1], 00E1h
				je esLetraYAS
				cmp bufferInfo[si+1], 00E9h
				je esLetraYAS
				cmp bufferInfo[si+1], 00EDh
				je esLetraYAS
				cmp bufferInfo[si+1], 00F3h
				je esLetraYAS
				cmp bufferInfo[si+1], 00FAh
				je esLetraYAS
				cmp bufferInfo[si+1], 00C1h
				je esLetraYAS
				cmp bufferInfo[si+1], 00C9h
				je esLetraYAS
				cmp bufferInfo[si+1], 00CDh
				je esLetraYAS
				cmp bufferInfo[si+1], 00D3h
				je esLetraYAS
				cmp bufferInfo[si+1], 00DAh
				je esLetraYAS
				cmp bufferInfo[si+1], 00E4h
				je esLetraYAS
				cmp bufferInfo[si+1], 00EBh
				je esLetraYAS
				cmp bufferInfo[si+1], 00EFh
				je esLetraYAS
				cmp bufferInfo[si+1], 00F6h
				je esLetraYAS
				cmp bufferInfo[si+1], 00FCh
				je esLetraYAS
				cmp bufferInfo[si+1], 00C4h
				je esLetraYAS
				cmp bufferInfo[si+1], 00CBh
				je esLetraYAS
				cmp bufferInfo[si+1], 00CFh
				je esLetraYAS
				cmp bufferInfo[si+1], 00D6h
				je esLetraYAS
				cmp bufferInfo[si+1], 00DCh
				je esLetraYAS
				cmp bufferInfo[si+1], 89
				je esLetraYAS
				cmp bufferInfo[si+1], 121
				je esLetraYAS
				mov otroaux3, bx
				mov otroaux2, ax
				
				inc contadorDip
				mov bx, contadorDip
				mov al,'<'
				mov listaDiptongos[bx],al
				inc contadorDip
				mov bx, contadorDip
				mov al,'t'
				mov listaDiptongos[bx],al
				inc contadorDip
				mov bx, contadorDip
				mov al,'r'
				mov listaDiptongos[bx],al
				inc contadorDip
				mov bx, contadorDip
				mov al,'>'
				mov listaDiptongos[bx],al
				inc contadorDip
				mov bx, contadorDip
				mov al,'<'
				mov listaDiptongos[bx],al
				inc contadorDip
				mov bx, contadorDip
				mov al,'t'
				mov listaDiptongos[bx],al
				inc contadorDip
				mov bx, contadorDip
				mov al,'d'
				mov listaDiptongos[bx],al
				inc contadorDip
				mov bx, contadorDip
				mov al,'>'
				mov listaDiptongos[bx],al
				
				mov ax,otroaux2
				mov otroaux1, si
				mov si, 1
				
				mov otroaux22, cx
				mov cx, contadorAUX
				DIPLOOP:
					inc contadorDip
					mov bx, contadorDip
					mov otroaux2, ax
					mov al, nomnom[si]
					mov listaDiptongos[bx],	al
					mov ax, otroaux2
					inc si
				LOOP DIPLOOP
				mov cx, otroaux22
				mov si, otroaux1
				
				inc contadorDip
				mov bx, contadorDip
				mov listaDiptongos[bx],'<'
				inc contadorDip
				mov bx, contadorDip
				mov listaDiptongos[bx],'/'
				inc contadorDip
				mov bx, contadorDip
				mov listaDiptongos[bx],'t'
				inc contadorDip
				mov bx, contadorDip
				mov listaDiptongos[bx],'d'
				inc contadorDip
				mov bx, contadorDip
				mov listaDiptongos[bx],'>'
				inc contadorDip
				mov bx, contadorDip
				mov listaDiptongos[bx],'<'
				inc contadorDip
				mov bx, contadorDip
				mov listaDiptongos[bx],'/'
				inc contadorDip
				mov bx, contadorDip
				mov listaDiptongos[bx],'t'
				inc contadorDip
				mov bx, contadorDip
				mov listaDiptongos[bx],'r'
				inc contadorDip
				mov bx, contadorDip
				mov listaDiptongos[bx],'>'

				mov bx, otroaux3
				jmp veriSigue
			esTRIPTONGO:
				mov otroaux3, bx
				mov otroaux2, ax
				
				inc contadorTri
				mov bx, contadorTri
				mov al,'<'
				mov listaTriptongos[bx],al
				inc contadorTri
				mov bx, contadorTri
				mov al,'t'
				mov listaTriptongos[bx],al
				inc contadorTri
				mov bx, contadorTri
				mov al,'r'
				mov listaTriptongos[bx],al
				inc contadorTri
				mov bx, contadorTri
				mov al,'>'
				mov listaTriptongos[bx],al
				inc contadorTri
				mov bx, contadorTri
				mov al,'<'
				mov listaTriptongos[bx],al
				inc contadorTri
				mov bx, contadorTri
				mov al,'t'
				mov listaTriptongos[bx],al
				inc contadorTri
				mov bx, contadorTri
				mov al,'d'
				mov listaTriptongos[bx],al
				inc contadorTri
				mov bx, contadorTri
				mov al,'>'
				mov listaTriptongos[bx],al
				
				mov ax,otroaux2
				mov otroaux1, si
				mov si, 1
				
				mov otroaux22, cx
				mov cx, contadorAUX
				TRIPLOOP:
					inc contadorTri
					mov bx, contadorTri
					mov otroaux2, ax
					mov al, nomnom[si]
					mov listaTriptongos[bx],	al
					mov ax, otroaux2
					inc si
				LOOP TRIPLOOP
				mov cx, otroaux22
				mov si, otroaux1
				
				inc contadorTri
				mov bx, contadorTri
				mov listaTriptongos[bx],'<'
				inc contadorTri
				mov bx, contadorTri
				mov listaTriptongos[bx],'/'
				inc contadorTri
				mov bx, contadorTri
				mov listaTriptongos[bx],'t'
				inc contadorTri
				mov bx, contadorTri
				mov listaTriptongos[bx],'d'
				inc contadorTri
				mov bx, contadorTri
				mov listaTriptongos[bx],'>'
				inc contadorTri
				mov bx, contadorTri
				mov listaTriptongos[bx],'<'
				inc contadorTri
				mov bx, contadorTri
				mov listaTriptongos[bx],'/'
				inc contadorTri
				mov bx, contadorTri
				mov listaTriptongos[bx],'t'
				inc contadorTri
				mov bx, contadorTri
				mov listaTriptongos[bx],'r'
				inc contadorTri
				mov bx, contadorTri
				mov listaTriptongos[bx],'>'

				mov bx, otroaux3
				jmp veriSigue
		noLetra:
			mov contadorAUX2, 0
		esHACHE:
		veriSigue:
			inc si
		ret
	verificarP2 endp

	encabezadoDIP proc far
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'h'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'m'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'l'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'h'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'e'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'a'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'d'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'i'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'l'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'e'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'D'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'i'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'p'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'o'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'n'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'g'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'o'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'s'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'/'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'i'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'l'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'e'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'/'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'h'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'e'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'a'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'d'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'b'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'o'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'d'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'y'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'a'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'b'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'l'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'e'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],' '
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'b'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'o'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'r'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'d'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'e'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'r'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'='
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],34
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'1'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],34
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'r'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'h'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'D'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'i'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'p'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'o'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'n'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'g'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'o'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'s'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'/'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'h'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'/'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'r'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
	ret
	encabezadoDIP endp
	
	finREPGENERAL proc far	
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'/'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'a'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'b'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'l'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'e'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		
		mov ah, 2ch
		int 21h
		
		mov horas, ch
		mov minutos, cl
		mov segundos, dh
		
		mov ah, 2ah
		int 21h
		
		mov mes, dh
		mov dia_mes, dl
		
		mov al,[dia_mes]
		mov cl,10
		mov ah,0
		div cl
		or ax,3030h
		mov bx, offset dia_mes_conv
		mov [bx],al
		inc bx
		mov [bx],ah

		inc contadorDip
		mov bx, contadorDip
		mov al, dia_mes_conv[0]
		mov listaDiptongos[bx], al
		inc contadorDip
		mov bx, contadorDip
		mov al, dia_mes_conv[1]
		mov listaDiptongos[bx], al
		
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'/'
		
		mov al, [mes]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset mes_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorDip
		mov bx, contadorDip
		mov al, mes_conv[0]
		mov listaDiptongos[bx], al
		inc contadorDip
		mov bx, contadorDip
		mov al, mes_conv[1]
		mov listaDiptongos[bx], al
		
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'/'
		
		inc contadorDip
		mov bx, contadorDip
		mov al, anio_conv[0]
		mov listaDiptongos[bx], al
		inc contadorDip
		mov bx, contadorDip
		mov al, anio_conv[1]
		mov listaDiptongos[bx], al

		mov al, [horas]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset horas_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'-'
		
		inc contadorDip
		mov bx, contadorDip
		mov al, horas_conv[0]
		mov listaDiptongos[bx], al
		inc contadorDip
		mov bx, contadorDip
		mov al, horas_conv[1]
		mov listaDiptongos[bx], al
				
		Mostrar_minutos:
		mov al, [minutos]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset min_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],':'
		
		inc contadorDip
		mov bx, contadorDip
		mov al, min_conv[0]
		mov listaDiptongos[bx], al
		inc contadorDip
		mov bx, contadorDip
		mov al, min_conv[1]
		mov listaDiptongos[bx], al

		Mostrar_segundos:
		mov al, [segundos]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset seg_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],':'
		
		inc contadorDip
		mov bx, contadorDip
		mov al, seg_conv[0]
		mov listaDiptongos[bx], al
		inc contadorDip
		mov bx, contadorDip
		mov al, seg_conv[1]
		mov listaDiptongos[bx], al
		
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'/'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'b'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'o'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'d'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'y'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'<'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'/'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'h'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'t'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'m'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'l'
		inc contadorDip
		mov bx, contadorDip
		mov listaDiptongos[bx],'>'
		ret
	finREPGENERAL endp

	encabezadoTRIP proc far
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'h'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'m'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'l'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'h'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'e'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'a'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'d'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'i'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'l'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'e'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'T'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'r'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'i'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'p'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'o'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'n'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'g'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'o'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'s'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'/'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'i'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'l'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'e'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'/'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'h'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'e'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'a'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'d'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'b'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'o'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'d'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'y'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'a'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'b'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'l'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'e'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],' '
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'b'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'o'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'r'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'d'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'e'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'r'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'='
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],34
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'1'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],34
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'r'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'h'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'T'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'r'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'i'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'p'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'o'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'n'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'g'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'o'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'s'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'/'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'h'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'/'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'r'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
	ret
	encabezadoTRIP endp
	
	finREPGENERALTRIP proc far	
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'/'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'a'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'b'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'l'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'e'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		
		mov ah, 2ch
		int 21h
		
		mov horas, ch
		mov minutos, cl
		mov segundos, dh
		
		mov ah, 2ah
		int 21h
		
		mov mes, dh
		mov dia_mes, dl
		
		mov al,[dia_mes]
		mov cl,10
		mov ah,0
		div cl
		or ax,3030h
		mov bx, offset dia_mes_conv
		mov [bx],al
		inc bx
		mov [bx],ah

		inc contadorTri
		mov bx, contadorTri
		mov al, dia_mes_conv[0]
		mov listaTriptongos[bx], al
		inc contadorTri
		mov bx, contadorTri
		mov al, dia_mes_conv[1]
		mov listaTriptongos[bx], al
		
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'/'
		
		mov al, [mes]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset mes_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorTri
		mov bx, contadorTri
		mov al, mes_conv[0]
		mov listaTriptongos[bx], al
		inc contadorTri
		mov bx, contadorTri
		mov al, mes_conv[1]
		mov listaTriptongos[bx], al
		
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'/'
		
		inc contadorTri
		mov bx, contadorTri
		mov al, anio_conv[0]
		mov listaTriptongos[bx], al
		inc contadorTri
		mov bx, contadorTri
		mov al, anio_conv[1]
		mov listaTriptongos[bx], al

		mov al, [horas]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset horas_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'-'
		
		inc contadorTri
		mov bx, contadorTri
		mov al, horas_conv[0]
		mov listaTriptongos[bx], al
		inc contadorTri
		mov bx, contadorTri
		mov al, horas_conv[1]
		mov listaTriptongos[bx], al
				
		Mostrar_minutos:
		mov al, [minutos]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset min_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],':'
		
		inc contadorTri
		mov bx, contadorTri
		mov al, min_conv[0]
		mov listaTriptongos[bx], al
		inc contadorTri
		mov bx, contadorTri
		mov al, min_conv[1]
		mov listaTriptongos[bx], al

		Mostrar_segundos:
		mov al, [segundos]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset seg_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],':'
		
		inc contadorTri
		mov bx, contadorTri
		mov al, seg_conv[0]
		mov listaTriptongos[bx], al
		inc contadorTri
		mov bx, contadorTri
		mov al, seg_conv[1]
		mov listaTriptongos[bx], al
		
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'/'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'b'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'o'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'d'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'y'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'<'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'/'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'h'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'t'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'m'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'l'
		inc contadorTri
		mov bx, contadorTri
		mov listaTriptongos[bx],'>'
		ret
	finREPGENERALTRIP endp

	repifinal proc far
		mov bx, contadorPalab
		mov listaPalabras[bx],13
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],10
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'J'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'o'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'s'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],00E9h
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],' '
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'P'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'a'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'b'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'l'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'o'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],13
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],10
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'2'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'0'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'1'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'6'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'0'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'2'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'7'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'1'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'3'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],13
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],10
		
		mov ah, 2ch
		int 21h
		
		mov horas, ch
		mov minutos, cl
		mov segundos, dh
		
		mov ah, 2ah
		int 21h
		
		mov mes, dh
		mov dia_mes, dl
		
		mov al,[dia_mes]
		mov cl,10
		mov ah,0
		div cl
		or ax,3030h
		mov bx, offset dia_mes_conv
		mov [bx],al
		inc bx
		mov [bx],ah

		inc contadorPalab
		mov bx, contadorPalab
		mov al, dia_mes_conv[0]
		mov listaPalabras[bx], al
		inc contadorPalab
		mov bx, contadorPalab
		mov al, dia_mes_conv[1]
		mov listaPalabras[bx], al
		
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'/'
		
		mov al, [mes]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset mes_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorPalab
		mov bx, contadorPalab
		mov al, mes_conv[0]
		mov listaPalabras[bx], al
		inc contadorPalab
		mov bx, contadorPalab
		mov al, mes_conv[1]
		mov listaPalabras[bx], al
		
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'/'
		
		inc contadorPalab
		mov bx, contadorPalab
		mov al, anio_conv[0]
		mov listaPalabras[bx], al
		inc contadorPalab
		mov bx, contadorPalab
		mov al, anio_conv[1]
		mov listaPalabras[bx], al

		mov al, [horas]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset horas_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'-'
		
		inc contadorPalab
		mov bx, contadorPalab
		mov al, horas_conv[0]
		mov listaPalabras[bx], al
		inc contadorPalab
		mov bx, contadorPalab
		mov al, horas_conv[1]
		mov listaPalabras[bx], al
				
		Mostrar_minutos:
		mov al, [minutos]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset min_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],':'
		
		inc contadorPalab
		mov bx, contadorPalab
		mov al, min_conv[0]
		mov listaPalabras[bx], al
		inc contadorPalab
		mov bx, contadorPalab
		mov al, min_conv[1]
		mov listaPalabras[bx], al

		Mostrar_segundos:
		mov al, [segundos]
		mov cl, 10
		mov ah, 0
		div cl
		or ax, 3030h
		mov bx, offset seg_conv
		mov [bx], al
		inc bx
		mov [bx], ah
		
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],':'
		
		inc contadorPalab
		mov bx, contadorPalab
		mov al, seg_conv[0]
		mov listaPalabras[bx], al
		inc contadorPalab
		mov bx, contadorPalab
		mov al, seg_conv[1]
		mov listaPalabras[bx], al
		
		
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],13
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],10
	ret
	repifinal endp	
	
	seAPLICO proc far
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'-'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'S'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'e'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],' '
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'a'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'p'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'l'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'i'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'c'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],00F3h
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],' '
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'e'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'l'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],' '
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'f'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'i'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'l'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'t'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'r'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'o'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],' '
	ret
	seAPLICO endp
	
	filtroMAYUS proc far
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'M'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'a'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'y'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'u'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'s'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'c'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'u'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'l'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'a'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],13
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],10
	ret	
	filtroMAYUS endp
	
	filtroMINUS proc far	
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'M'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'i'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'n'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'u'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'s'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'c'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'u'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'l'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'a'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],13
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],10	
	ret
	filtroMINUS endp 
	
	filtroCAPI proc far
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'C'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'a'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'p'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'i'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'t'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'a'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'l'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],13
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],10	
	ret
	filtroCAPI endp 
	
	filtroINV proc far
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'I'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'n'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'v'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'e'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'r'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'t'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'i'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'r'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],13
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],10		
	ret
	filtroINV endp 
	
	filtroBYR proc far
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'B'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'u'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'s'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'c'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'a'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'r'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],' '
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'y'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],' '
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'R'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'e'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'e'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'m'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'p'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'l'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'a'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'z'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'a'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],'r'
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],13
		inc contadorPalab
		mov bx, contadorPalab
		mov listaPalabras[bx],10	
	ret
	filtroBYR endp 
	
	reemplazar proc far
	
			print saltoLinea
			print pedirRuta
			Limpiar bufferInfo2, SIZEOF bufferInfo2, 24h
			getTexto bufferInfo2
			print bufferInfo2
			print saltoLinea
			print sep
			print saltoLinea
			
			print saltoLinea
			print pedirRuta
			Limpiar bufferInfo3, SIZEOF bufferInfo3, 24h
			getTexto bufferInfo3
			print bufferInfo3
			print saltoLinea
			print sep
			print saltoLinea
	
	xor si, si
			xor cx, cx
			xor bx,bx
			xor di,di
			mov cx,00h
			jmp ComparacionesBR

			VerificarOtraVez:
				LimpiarBufferLectura
				ActualizarBufferLectura
				LimpiarBufferLecturaNuevo
				
				mov si,cx
				xor cx, cx
				xor bx,bx
				xor di,di
				mov cx,00h
			jmp ComparacionesBR

			Limpiarrr:
				mov cx,si
			CompletarbufferLecturaNuevo:
				mov al,bufferInfo[di]
				cmp al,24h
				je VerificarOtraVez
				mov bufferInfoAuxiliar[si],al
				inc di
				inc si
			jmp CompletarbufferLecturaNuevo
				
			Volver:
				mov cx,00h

			PalabraVieja:
				mov bx,cx
				mov al,bufferInfo2[bx]
				cmp al,24h
				je  Limpiarrr
				inc di
				inc cx
			jmp PalabraVieja
			PalabraNueva:
				mov bx,cx 
				
				mov al,bufferInfo3[bx]
				cmp al,24h
				je  Volver
				mov bufferInfoAuxiliar[si],al
				inc cx
				inc si

			jmp PalabraNueva

			Reemplazando:
				mov al,bufferInfo[si]
				mov bufferInfoAuxiliar[si],al
				cmp si,di
				je PalabraNueva
				cmp al,24h;----------------------->dolar
				je FinComparacionesBR
				inc si
			jmp Reemplazando
			Reemplaza:
				;print probar				
				xor si, si
				mov cx,00h
			jmp Reemplazando
				
			LetraIgual:
				;print probar2
				inc si
				inc cx

				mov bx,cx
				mov al ,bufferInfo2[bx]
				cmp al,0dh
				je Reemplaza
				cmp al,24h  ;---------------------->dolar
				je Reemplaza
				cmp al,bufferInfo[si]
				je LetraIgual
			jmp AumentoBR
			AumentoBR:
				inc si
			ComparacionesBR:
				mov di,si
				mov cx,00h
				mov al,bufferInfo[si]
				cmp al,24h  ;--------------------------->dolar
				je FinComparacionesBR
				
				cmp al,bufferInfo2[0]
				je LetraIgual

			jmp AumentoBR
			FinComparacionesBR:
				ActualizarBufferEscritura
			print bufferInfo
			print sep
	ret
	reemplazar endp
end 
	
	