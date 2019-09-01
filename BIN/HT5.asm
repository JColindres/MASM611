;=============================================macros=======================================================================
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

multiplicar13 macro
	sub resulta, 30h
	
	mov al, resulta
	shl al, 1
	shl al, 1  ; al = al * 4
	mov bl, al ; al = al * 4
	shl al, 1  ; al = al * 8
	add al, bl ; al = al * 8 + al * 4;
	add al, resulta
	
	aam
	
	mov uni, al
	mov al, ah
	aam
	mov cen, ah
	mov dece, al 
		
	mov ah, 02h
		
	mov dl, cen
	add dl, 30h
	int 21h
		
	mov dl, dece
	add dl, 30h
	int 21h
		
	mov dl, uni
	add dl, 30h
	int 21h
endm

;====================================================================================================================

.model small

.stack

.data

sep db 0ah, 0dh, '==============================================', '$'
nombre db 0ah, 0dh, 'NOMBRE: JOS',144,' PABLO COLINDRES ORELLANA','$'
carnet db 0ah, 0dh, 'CARN',144,': 201602713','$'
saltoLinea db 0ah, 0dh, ' ','$'
ingresar db 0ah, 0dh, 'Ingrese un n',163,'mero: ','$'
rango1 db 0ah, 0dh, 'N',163,'mero en el rango [0-4]','$'
rango2 db 0ah, 0dh, 'N',163,'mero en el rango [5-9]','$'
llamProc db 0ah, 0dh, 'LLamada Procedimiento...','$'
llamMacro db 0ah, 0dh, 'LLamada Macro...','$'
mult16 db 0ah, 0dh, 'Multiplicando por 16...','$'
mult13 db 0ah, 0dh, 'Multiplicando por 13...','$'
resultado db 0ah, 0dh, 'Resultado: ','$'
continuar db 0ah, 0dh, 'Continuar? Y/N','$'
pruebe db 0ah, 0dh, 'Pruebe otra vez','$'

resulta db 0

cen db 0 
dece db 0
uni db 0

.code
.startup
    menuPrincipal:
		print sep
        print nombre
        print carnet
        print saltoLinea
        print ingresar
        getchar
		mov resulta, al
        cmp al, 30h
        jb Repetir
		je M16
		cmp al, 35h
		jb M16
		cmp al, 39h
		jb M13
		je M13
		ja Repetir
	Reaundar:
		print saltoLinea
		print continuar
		print saltoLinea
		getchar
		cmp al, 59h
		je menuPrincipal
		cmp al, 4Eh
		je Salir
		jmp Reaundar
    M16:
		print rango1
		print llamProc
		print mult16
		print saltoLinea
		
		call multiplicar16
		
		print saltoLinea
		
		jmp Reaundar
	M13:
		print rango2
		print llamMacro
		print mult13
		print saltoLinea
		
		multiplicar13
		
		print saltoLinea
		
		jmp Reaundar
	Repetir:
		print pruebe
		jmp menuPrincipal
    Salir:
        mov ah, 4ch
        mov al, al
        int 21h
.exit

multiplicar16 proc near
	sub resulta, 30h
	
	mov al, resulta
	shl al, 1
	shl al, 1
	shl al, 1  ; al = al * 8
	mov bl, al ; al = al * 8
	add al, bl ; al = al * 8 + al * 8
	
	aam
	
	mov uni, al
	mov al, ah
	aam
	mov cen, ah
	mov dece, al 
		
	mov ah, 02h
		
	mov dl, cen
	add dl, 30h
	int 21h
		
	mov dl, dece
	add dl, 30h
	int 21h
		
	mov dl, uni
	add dl, 30h
	int 21h
	ret
multiplicar16 endp
end