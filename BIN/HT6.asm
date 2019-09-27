print macro buffer
    mov ax, @data
    mov ds, ax
    mov ah, 09h
    mov dx, offset buffer
    int 21h
endm

getchar macro
    mov ah, 01h
    int 21h
endm

obtenerTexto macro buffer
    LOCAL ObtenerChar, FinOT  
    mov contador, 0
	mov contadorAUX, 0
    xor si,si
    ObtenerChar:
        getChar
        cmp al,0dh
        je FinOT
		mov bl,contador
		cmp bl,7
		je FinOT
        mov buffer[si],al
        inc si      
        inc contador
		inc contadorAUX
        jmp ObtenerChar
    FinOT:
        mov al,24h
        mov buffer[si],al
endm


.model small

.stack

.data

sep db 0ah, 0dh, '==============================================', '$'
nombre1 db 0ah, 0dh, 'NOMBRE: JOS',144,' PABLO COLINDRES ORELLANA','$'
carnet1 db 0ah, 0dh, 'CARN',144,': 201602713','$'
nombre2 db 0ah, 0dh, 'NOMBRE: CARLOS MANUEL GARCIA ESCALANTE','$'
carnet2 db 0ah, 0dh, 'CARN',144,': 201612276','$'
saltoLinea db 0ah, 0dh, ' ','$'
opcion1 db 0ah, 0dh, '1) Ingrese un n',163,'mero (max 7 digitos): ','$'
opcion2 db 0ah, 0dh, '2) Es split? ','$'
opcion3 db 0ah, 0dh, '3) Es palindromo? ','$'
opcion4 db 0ah, 0dh, '4) Salir ','$'
sies db 0ah, 0dh, 'Si es!','$'
noes db 0ah, 0dh, 'No es!','$'

arreglo db 7 dup('$'),'$'
arregloAUX db 7 dup('$'),'$'

igual db ' = ','$'

contador db 0,'$'
contadorAUX dw 0,'$'

izq db 0
der db 0 

aver db 0,'$'

.code
	main proc
		menuPrincipal:
			print sep
			print nombre1
			print carnet1
			print nombre2
			print carnet2
			print saltoLinea
			print opcion1
			print opcion2
			print opcion3
			print opcion4
			print saltoLinea 
			getchar
			cmp al, 31h
			je Op1
			cmp al, 32h
			je Op2
			cmp al, 33h
			je Op3
			cmp al, 34h
			je Salir
			jmp menuPrincipal
		Op1:
			mov arreglo[0],'$'
			mov arreglo[1],'$'
			mov arreglo[2],'$'
			mov arreglo[3],'$'
			mov arreglo[4],'$'
			mov arreglo[5],'$'
			mov arreglo[6],'$'
			mov arregloAUX[0],'$'
			mov arregloAUX[1],'$'
			mov arregloAUX[2],'$'
			mov arregloAUX[3],'$'
			mov arregloAUX[4],'$'
			mov arregloAUX[5],'$'
			mov arregloAUX[6],'$'
			print saltoLinea
			obtenerTexto arreglo
			print saltoLinea
			jmp menuPrincipal
		Op2:
			print saltoLinea 
			
			mov al, contador
			cmp al,1
			je NAIN
			cmp al,2
			je NAIN
			cmp al,3
			je TRES
			cmp al,4
			je CUATRO
			cmp al,5
			je CINCO
			cmp al,6
			je SEIS
			cmp al,7
			je SIETE
		
			TRES:
				mov al,arreglo[0]
				mov bl,arreglo[2]
				cmp al,bl
				je SE 
				jmp NAIN
			CUATRO:
				mov al,arreglo[0]
				mov bl,arreglo[1]
				add al,bl
				mov izq,al
				
				mov al,arreglo[2]
				mov bl,arreglo[3]
				add al,bl
				mov der,al
				
				mov al,izq
				mov bl,der
				cmp al,bl
				je SE
				jmp NAIN
			CINCO:
				mov al,arreglo[0]
				mov bl,arreglo[1]
				add al,bl
				mov izq,al
				
				mov al,arreglo[3]
				mov bl,arreglo[4]
				add al,bl
				mov der,al
				
				mov al,izq
				mov bl,der
				cmp al,bl
				je SE
				jmp NAIN
			SEIS:
				mov al,arreglo[0]
				mov bl,arreglo[1]
				add al,bl
				mov bl,arreglo[2]
				add al,bl
				mov izq,al
				
				mov al,arreglo[3]
				mov bl,arreglo[4]
				add al,bl
				mov bl,arreglo[5]
				add al,bl
				mov der,al
				
				mov al,izq
				mov bl,der
				cmp al,bl
				je SE
				jmp NAIN
			SIETE:
				mov al,arreglo[0]
				mov bl,arreglo[1]
				add al,bl
				mov bl,arreglo[2]
				add al,bl
				mov izq,al
				
				mov al,arreglo[4]
				mov bl,arreglo[5]
				add al,bl
				mov bl,arreglo[6]
				add al,bl
				mov der,al
				
				mov al,izq
				mov bl,der
				cmp al,bl
				je SE
				jmp NAIN
				
			print sep
			jmp menuPrincipal
			SE:
				print sies
				jmp menuPrincipal
			NAIN:
				print noes
				jmp menuPrincipal
			
		Op3:
			print saltoLinea
				
			seguir:				
				mov si,contadorAUX
				xor bx,bx
				mov cx,contadorAUX
				CICLO:
					mov al,arreglo[si-1]
					mov arregloAUX[bx],al
					inc bx
					dec si
				loop CICLO
			
			print arreglo
			print igual
			print arregloAUX
			
			mov al,arreglo
			mov bl,arregloAUX
			cmp al,bl
			je SE2
		    jne NAIN2
			
			SE2:
				print sies
				jmp menuPrincipal
			NAIN2:
				print noes
				jmp menuPrincipal
		Salir:
			mov ah, 4ch
			mov al, al
			int 21h
	main endp
end 