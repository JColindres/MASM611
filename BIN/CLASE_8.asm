;========================== MACROS MODO GRAFICO ===================================
;---------REGRESAR AL MODO DE TEXTO------------------
ModoTexto macro
;Regresar a modo texto  
mov ax,0003h    
int 10h
mov ax,@data
mov ds,ax
endm

;--------MODO GRAFICO-------------------
ModoGrafico macro
;Iniciacion de modo video  
mov ax,0013h ;nos da una resoluci?n de 200x320 (pixeles (alto,ancho))
int 10h
mov ax, 0A000h
mov ds, ax  ; DS = A000h (memoria de graficos).
endm

;=========================== LOS SIGUIENTE MACROS UTILIZAN LA LLAMADA A LA INTERRUPCION PARA PINTAR =======================
;------PINTAR PIXEL GRAFICO
pixel macro x0, y0, color  
push cx
mov ah, 0ch
mov al, color ;color, n?mero representado del 0-255 (256 colores)
mov bh, 0h
mov dx, y0
mov cx, x0
int 10h 
pop cx
endm

;--------------------Pintar eje X
PintarX macro
LOCAL eje_x
;Dibujar eje de las abscisas  
mov cx,13eh 
eje_x:  
pixel cx,63h,4fh
loop eje_x 
endm

;-----------------Pintar eje Y
PintarY macro
LOCAL eje_y, juera
;Dibujar eje de las ordenadas  
mov cx,150
eje_y:
cmp cx,50
je juera
pixel centro,cx,4fh  
loop eje_y 
juera:
endm

;========================= LOS SIGUIENTES MACROS UTILIZAN LA MEMORIA DE VIDEO DIRECTAMENTE (MEJOR) =======================
;----------------Pintar eje X (Forma 2)
PintarX2 macro 
LOCAL eje_x
;Dibujar eje de las abscisas  
mov cx,13eh ;n?mero de iteraciones
mov dl,4fh ;color
eje_x:
mov di,cx ;n?mero de iteraci?n
mov [di+7d00h],dl ;32,000 -> este 32,000 representa los 320 pixeles de ancho por los 100 pixeles de alto para que quede al centro
loop eje_x 
endm

;----------------Pintar eje Y (Forma 2)
PintarY2 macro 
LOCAL eje_y, juera
;Dibujar eje de las abscisas  
mov cx,110 ;n?mero de iteraciones
eje_y:
cmp cx, 30
je juera
mov di,cx
mov ax,320
mul di
mov di,ax
mov dl,04h ;color
mov [di+10],dl ;160 -> este 160 representa los 160 pixeles de ancho que es la distancia a la que se estar?n pintando las de Y
mov di,cx
mov ax,320
mul di
mov di,ax
mov dl,04h ;color
mov [di+11],dl
mov di,cx
mov ax,320
mul di
mov di,ax
mov dl,04h ;color
mov [di+12],dl
loop eje_y
juera:
endm

;================================================================================
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
;push ds
mov ax,@data
mov ds,ax
mov ah,09
mov dx,offset cadena
int 21h
;equivalente a lea dx,cadena, inicializa en dx la posicion donde comienza la cadena
;pop ds
pop dx
pop ax
endm

.model small
;-------------------SEGMENTO DE PILA--------------------------
.stack
;-------------------SEGMENTO DE DATO--------------------------
.data
    ;----------------------------MENSAJES---------------------------------------------------
    salt db 0ah,0dh, '  ','$'
    ;ENCABEZADO
    enc0 db 0ah,0dh, '  UNIVERSIDAD DE SAN CARLOS DE GUATEMALA',0ah,0dh,'   FACULTAD DE INGENIERIA', 0ah,0dh, ' ESCUELA DE CIENCIAS Y SISTEMAS',0ah,0dh, '  ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 A',0ah,0dh, '    PRIMER SEMESTRE 2019',0ah,0dh, '    OSCAR RENE CUELLAR MANCILLA',0ah,0dh, ' 201503712',0ah,0dh, '   EJEMPLO MODO VIDEO','$'
    ;MENU PRINCIPAL
    enc1 db 0ah,0dh, '  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%',0ah,0dh,'   %%%%%%% MENU PRINCIPAL %%%%%%%',0ah,0dh,'   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%',0ah,0dh,'   %%%% 1. VIDEO 1           %%%%',0ah,0dh,'   %%%% 2. VIDEO 2       %%%%',0ah,0dh,'   %%%% 3. SALIR             %%%%',0ah,0dh,'   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%','$'

    centro dw 160 ;160 <- representa el centro del eje Y, en este caso tenemos resoluci?n de 200x320, entonces el centro es 160
;-------------------SEGMENTO DE CODIGO------------------------
.code
.386
main proc

    MenuPrincipal:
        ;--------MOSTRANDO EL MENU PRINCIPAL--------------------------
        print enc0
        print enc1
        print salt
        ;--------OBTENIENDO EL NUMERO ESCOGIDO------------------------
        getChar
        cmp al,31h; COMPARO CON EL ASCII DEL NUMERO 1 QUE ES 49 Y EN HEXA 31H
        je Video1
        cmp al,32h ;comparo con el ascii del numero 2
        je Video2
        cmp al,33h
        je Salir
        jmp MenuPrincipal

        ;LLAMANDO AL MACRO DE PINTAR PIXEL CADA VEZ
    Video1:
        ModoGrafico
        PintarX
        PintarY ;al mandar a pintar aqu? ya no nos guarda el 160 de la variable "centro", ya que cambiamos la posici?n del ds
        getChar
        ModoTexto

        ModoGrafico
        mov centro,160 ; una soluci?n que les doy, es volver a inicializar sus variables luego de cambiar a modo video
        PintarX
        PintarY
        getChar
        ModoTexto

        ;Segunda soluci?n usar la pila
        push centro ;guardo el valor de mi variable centro en la pila
        ModoGrafico ;me cambio a modo video
        pop centro ;saco el valor que hab?a guardado para mi variable centro
        PintarX
        PintarY
        push centro ;si en algun momento cambiamos el valor y lo necesitamos para los reportes, lo volvemos a meter a la pila
        getChar
        ModoTexto
        pop centro ;y lo sacamos luego al estar en modoTexto de regreso.

        ;tercera soluci?n, mover el registro ds a donde se encuentran sus datos al momento de usar una variable
        ; ojo (sin ejecutar la interrupci?n)
        ModoGrafico
        PintarX
        mov ax,@data
        mov ds,ax
        PintarY
        ; y si est?n pintando con la segunda forma (memoria de graficos), deben regresar el ds a dicha memoria
        ; luego de usar sus variables
        mov ax, 0A000h
        mov ds, ax  ; DS = A000h (memoria de graficos).
        getChar
        ModoTexto

        jmp MenuPrincipal

        ;UTILIZANDO LA MEMORIA DE VIDEO DIRECTAMENTE, COMO UN ARREGLO MAPEADO (ESTA FORMA ES MAS SENCILLA Y MAS FLUIDA)
    Video2:
        ModoGrafico
        ;al mapear el cuadro de modo video de 200x320, se tiene un arreglo de 64,000 posiciones
        PintarX2
        PintarY2
        getChar
        ModoTexto
        jmp MenuPrincipal

;---------------------METODO PARA FINALIZAR EL PROGRAMA-----------------------------
    Salir:
        mov ah, 4ch
        mov al, 00h
        int 21h
main endp ;Termina proceso
end main