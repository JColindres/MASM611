print macro buffer
    mov ax,@data
    mov ds, ax
    mov ah,09h
    mov dx,offset buffer
    int 21h
endm

printNeto macro buffer
LOCAL jeje
	xor si,si
	jeje:
    mov ax,@data
    mov ds, ax
    mov ah,09h
	mov al, buffer[si]
    mov dx,offset buffer
    int 21h
endm

getChar macro
    mov ah,01h
    int 21h
endm


obtenerTexto macro buffer
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
        mov al,24h
        mov buffer[si],al
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

CrearArchivo macro buffer, handler
LOCAL erroralcrear, fin
    mov ah, 3ch
    mov cx, 00h
    lea dx, buffer
    int 21h
    jc erroralcrear
    mov handler,ax
    jmp fin
erroralcrear:
    print err4
fin:
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

Velocidades macro tiempo
LOCAL RE0, RE1
    MOV bp,tiempo
    RE0:
      MOV di, tiempo
    RE1:
      DEC di
      JNZ RE1
      DEC bp
      JNZ RE0
endm

Determinar macro
LOCAL cero, uno, dos, tres, cuatro, cinco, seis, siete, ocho, nueve, final
	cmp retard, 30h
	je cero
	cmp retard, 31h
	je uno
	cmp retard, 32h
	je dos
	cmp retard, 33h
	je tres
	cmp retard, 34h
	je cuatro
	cmp retard, 35h
	je cinco
	cmp retard, 36h
	je seis
	cmp retard, 37h
	je siete
	cmp retard, 38h
	je ocho
	cmp retard, 39h
	je nueve
	cero:
	Velocidades 10
	jmp final
	uno:
	Velocidades 100
	jmp final
	dos:
	Velocidades 200
	jmp final
	tres:
	Velocidades 300
	jmp final
	cuatro:
	Velocidades 400
	jmp final
	cinco:
	Velocidades 500
	jmp final
	seis:
	Velocidades 600
	jmp final
	siete:
	Velocidades 700
	jmp final
	ocho:
	Velocidades 800
	jmp final
	nueve:
	Velocidades 900
	jmp final
	final:
endm

Sonidos macro frecuencia
mov al, 86h
out 43h, al
mov ax, (1193180 / frecuencia) 
out 42h, al
mov al, ah
out 42h, al 
in al, 61h
or al, 00000011b
out 61h, al
Velocidades 500
in al, 61h
and al, 11111100b
out 61h, al
endm

DeterminarFrecuencia1 macro
LOCAL rango1, rango2, rango3, rango4, rango5, fin
cmp datos[si+1], 21
jb rango1
cmp datos[si+1], 41
jb rango2
cmp datos[si+1], 61
jb rango3
cmp datos[si+1], 81
jb rango4
cmp datos[si+1], 100
jb rango5
rango1:
Sonidos 100
jmp fin
rango2:
Sonidos 300
jmp fin
rango3:
Sonidos 500
jmp fin
rango4:
Sonidos 700
jmp fin
rango5:
Sonidos 900
fin:
endm

DeterminarFrecuencia2 macro
LOCAL rango1, rango2, rango3, rango4, rango5, fin
cmp datos[si], 21
jb rango1
cmp datos[si], 41
jb rango2
cmp datos[si], 61
jb rango3
cmp datos[si], 81
jb rango4
cmp datos[si], 100
jb rango5
rango1:
Sonidos 100
jmp fin
rango2:
Sonidos 300
jmp fin
rango3:
Sonidos 500
jmp fin
rango4:
Sonidos 700
jmp fin
rango5:
Sonidos 900
fin:
endm

ModoT macro
mov ax,0003h    
int 10h
mov ax,@data
mov ds,ax
endm

ModoG macro 
mov ax,13h
int 10h
mov ax, 0A000h
mov ds, ax 
endm

PintarPixel macro x0, y0, color  
push cx
mov ax, 0A000h
mov ds, ax
mov ah, 0ch
mov al, color 
mov bh, 0h
mov dx, y0
mov cx, x0
int 10h 
pop cx
endm

PintarColumna macro 
LOCAL columna1, columna2, columna3, juera
mov cx,150
columna1:
cmp cx, altura
je juera
PintarPixel corrimiento,cx,04h  
loop columna1
mov cx,150
columna2:
cmp cx, altura
je juera
PintarPixel corrimiento+1,cx,04h  
loop columna2
mov cx,150
columna3:
cmp cx, altura
je juera
PintarPixel corrimiento+2,cx,04h  
loop columna3
juera:
endm

Altu macro num
LOCAL uno, dos, tres, cuatro, cinco, seis, siete, ocho, nueve, diez
LOCAL once, doce, trece, cator, quin, dseis, dsiete, docho, dnueve, vein
LOCAL vuno, vdos, vtres, vcuatro, vcin, vseis, vsiete, vocho, vnueve, trein
LOCAL tuno,tdos,ttres,tcua,tcin,tseis,tsiete,tocho,tnueve,cua
LOCAL cuno,cdos,ctres,ccua,ccin,cseis,csiete,cocho,cnueve,ses
LOCAL sesuno,sesdos,sestres,sescua,sescin,sesseis,sessiete,sesocho,sesnueve,set
LOCAL setuno,setdos,settres,setcua,setcin,setseis,setsiete,setocho,setnueve,och
LOCAL ouno,odos,otres,ocua,ocin,oseis,osiete,oocho,onueve,nov
LOCAL nuno,ndos,ntres,ncua,ncin,nseis,nsiete,nocho,nnueve, final
	mov ax,@data
	mov ds,ax
	mov al, num
	cmp al, 100
	ja salir
	cmp al, 1
	je uno
	cmp al, 2
	je dos
	cmp al, 3
	je tres
	cmp al, 4
	je cuatro
	cmp al, 5
	je cinco
	cmp al, 6
	je seis
	cmp al, 7
	je siete
	cmp al, 8
	je ocho
	cmp al, 9
	je nueve
	cmp al, 10
	je diez
	cmp al, 11
	je once
	cmp al, 12
	je doce
	cmp al, 13
	je trece
	cmp al, 14
	je cator
	cmp al, 15
	je quin
	cmp al, 16
	je dseis
	cmp al, 17
	je dsiete
	cmp al, 18
	je docho
	cmp al, 19
	je dnueve
	cmp al, 20
	je vein
	cmp al, 21
	je vuno
	cmp al, 22
	je vdos
	cmp al, 23
	je vtres
	cmp al, 24
	je vcuatro
	cmp al, 25
	je vcin
	cmp al, 26
	je vseis
	cmp al, 27
	je vsiete
	cmp al, 28
	je vocho
	cmp al, 29
	je vnueve
	cmp al, 30
	je trein
	cmp al, 31
	je tuno
	cmp al, 32
	je tdos
	cmp al, 33
	je ttres
	cmp al, 34
	je tcua
	cmp al, 35
	je tcin
	cmp al, 36
	je tseis
	cmp al, 37
	je tsiete
	cmp al, 38
	je tocho
	cmp al, 39
	je tnueve
	jmp final
	uno:
	mov altura, 149
	jmp final
	dos:
	mov altura, 148
	jmp final
	tres:
	mov altura, 147
	jmp final
	cuatro:
	mov altura, 146
	jmp final
	cinco:
	mov altura, 145
	jmp final
	seis:
	mov altura, 144
	jmp final
	siete:
	mov altura, 143
	jmp final
	ocho:
	mov altura, 142
	jmp final
	nueve:
	mov altura, 141
	jmp final
	diez:
	mov altura, 140
	jmp final
	once:
	mov altura, 139
	jmp final
	doce:
	mov altura, 138
	jmp final
	trece:
	mov altura, 137
	jmp final
	cator:
	mov altura, 136
	jmp final
	quin:
	mov altura, 135
	jmp final
	dseis:
	mov altura, 134
	jmp final
	dsiete:
	mov altura, 133
	jmp final
	docho:
	mov altura, 132
	jmp final
	dnueve:
	mov altura, 131
	jmp final
	vein:
	mov altura, 130
	jmp final
	vuno:
	mov altura, 129
	jmp final
	vdos:
	mov altura, 128
	jmp final
	vtres:
	mov altura, 127
	jmp final
	vcuatro:
	mov altura, 126
	jmp final
	vcin:
	mov altura, 125
	jmp final
	vseis:
	mov altura, 124
	jmp final
	vsiete:
	mov altura, 123
	jmp final
	vocho:
	mov altura, 122
	jmp final
	vnueve:
	mov altura, 121
	jmp final
	trein:
	mov altura, 120
	jmp final
	tuno:
	mov altura, 119
	jmp final
	tdos:
	mov altura, 118
	jmp final
	ttres:
	mov altura, 117
	jmp final
	tcua:
	mov altura, 116
	jmp final
	tcin:
	mov altura, 115
	jmp final
	tseis:
	mov altura, 114
	jmp final
	tsiete:
	mov altura, 113
	jmp final
	tocho:
	mov altura, 112
	jmp final
	tnueve:
	mov altura, 111
	jmp final
	final:
endm 

Distancia macro 
LOCAL cero, uno, dos, tres, cuatro, cinco, seis, siete, ocho, nueve, diez, once, doce, trece, cator, quin, dseis, dsiete, docho, dnueve, vein, vuno, vdos, vtres, vcuatro, final
	cmp contCol, 0
	je cero
	cmp contCol, 1
	je uno
	cmp contCol, 2
	je dos
	cmp contCol, 3
	je tres
	cmp contCol, 4
	je cuatro
	cmp contCol, 5
	je cinco
	cmp contCol, 6
	je seis
	cmp contCol, 7
	je siete
	cmp contCol, 8
	je ocho
	cmp contCol, 9
	je nueve
	cmp contCol, 10
	je diez
	cmp contCol, 11
	je once
	cmp contCol, 12
	je doce
	cmp contCol, 13
	je trece
	cmp contCol, 14
	je cator
	cmp contCol, 15
	je quin
	cmp contCol, 16
	je dseis
	cmp contCol, 17
	je dsiete
	cmp contCol, 18
	je docho
	cmp contCol, 19
	je dnueve
	cmp contCol, 20
	je vein
	cmp contCol, 21
	je vuno
	cmp contCol, 22
	je vdos
	cmp contCol, 23
	je vtres
	cmp contCol, 24
	je vcuatro
	cero:
	mov corrimiento, 10
	jmp final
	uno:
	mov corrimiento, 20
	jmp final
	dos:
	mov corrimiento, 30
	jmp final
	tres:
	mov corrimiento, 40
	jmp final
	cuatro:
	mov corrimiento, 50
	jmp final
	cinco:
	mov corrimiento, 60
	jmp final
	seis:
	mov corrimiento, 70
	jmp final
	siete:
	mov corrimiento, 80
	jmp final
	ocho:
	mov corrimiento, 90
	jmp final
	nueve:
	mov corrimiento, 100
	jmp final
	diez:
	mov corrimiento, 110
	jmp final
	once:
	mov corrimiento, 120
	jmp final
	doce:
	mov corrimiento, 130
	jmp final
	trece:
	mov corrimiento, 140
	jmp final
	cator:
	mov corrimiento, 150
	jmp final
	quin:
	mov corrimiento, 160
	jmp final
	dseis:
	mov corrimiento, 170
	jmp final
	dsiete:
	mov corrimiento, 180
	jmp final
	docho:
	mov corrimiento, 190
	jmp final
	dnueve:
	mov corrimiento, 200
	jmp final
	vein:
	mov corrimiento, 210
	jmp final
	vuno:
	mov corrimiento, 220
	jmp final
	vdos:
	mov corrimiento, 230
	jmp final
	vtres:
	mov corrimiento, 240
	jmp final
	vcuatro:
	mov corrimiento, 250
	jmp final
	final:
endm 

