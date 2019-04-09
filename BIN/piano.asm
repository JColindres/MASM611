.model small
.stack 100h
.data

;----------------------------------------------------------------------------

playMS         DB '                        PIANO ++  by Reuven',13,10
               DB 13,10
               DB '                    welcome! this is your piano:',13,10
               DB '       example: piano note(keyboard key)',13,10
               DB 13,10
               DB '                C#(2)   D#(3)        F#(5)   G#(6)    A#(7)' ,13,10
               DB '            C(q)    D(w)    E(e)  F(r)    G(t)    A(y)    B(u)',13,10,13,10
               DB 13,10
               DB '                       press ESC to exit','$'

;----------------------------------------------------------------------------

.code

TONO MACRO NUMERO               ;macro that of the tune 
        MOV     BX,NUMERO       ;call the PROC
        CALL    BOCINA
ENDM

;----------------------------------------------------------------------------

CLRSCR PROC
;clean the window
        MOV     AH,6
        XOR     AL,AL
        XOR     CX,CX
        MOV     DX,184FH
        MOV     BH,13
        INT     10H
        RET
ENDP

;----------------------------------------------------------------------------

BocinaOn  PROC                  ;Turn on the horn
        IN      AL, 61h
        OR      AL, 11B
        OUT     61h, AL
        RET
BocinaOn  ENDP

;----------------------------------------------------------------------------

BocinaOff  PROC                 ;Turn off the horn
        IN      AL, 61h
        AND     AL, 11111100b
        OUT     61h, AL
        RET
BocinaOff  ENDP

;----------------------------------------------------------------------------

Ajustar  PROC                  ;Adjusts the horn with the note frequency
        PUSH    BP
        MOV     BP, SP
        MOV     DX, 18      
        MOV     AX, 13353   
        MOV     BX, [BP + 4]
        DIV     BX
        MOV     BX, AX  
        MOV     AL, 0B6h
        OUT     43h, AL
;SEND TO PORT THE FREQUENCY IN TWO BYTES BY SEPARATE
        MOV     AX, BX
        OUT     42h, AL ;SEND FIRST BYTE = 378H
        MOV     AL, AH
        OUT     42h, AL ;SENDS SECOND BYTE = 3F8H
        POP     BP
        RET
Ajustar  ENDP

;----------------------------------------------------------------------------

Suena proc                      ;מפעיל את הצופר ומציב שם
        CALL bocinaON           ;מקש מהמקלדת
        MOV     AX,40H
        MOV     ES,AX
        MOV     DX,ES:[006EH]
        MOV     AX,ES:[006CH]
        ADD     AX,7
        ADC     DX,0            ;הוספה של שבע יחידות לערך
CLIC:
        CMP     DX,ES:[006EH]   ;עד שיהיה שיוויון
        JB      FINI            ;פעולה מעגלית עד הסוף
        JA      CLIC            ;שיהיה שייוין צריך לצאת מהמעגל
        CMP     AX,ES:[006CH]
        JA      CLIC
FINI:
        CALL    BocinaOff       ;כיבוי של הצופר
        RET
Suena endp

;----------------------------------------------------------------------------

Bocina proc                     ;Este procedimiento guarda AX y BX en
        PUSH    BX              ;la pila para no perder su valor, con
        MOV     AX, BX          ;esto llama a ajusta y a suena
        PUSH    AX
        CALL    Ajustar         ;Pone la frecuencia en el puerto.
        POP     AX
        POP     BX
        CALL    SUENA           ;Activa el speaker y lo desactiva.
        ret
Bocina endp

;----------------------------------------------------------------------------
;CONVERTIR A MINUSCULA SI ERA MAYUSCULA

MINUSCULA PROC
        CMP AL, 65    ;'A'
        JB  CONTINUAR ;SI LA TECLA ES MENOR QUE LA 'A' NO HACE NADA
        CMP AL, 90    ;'Z'
        JA  CONTINUAR ;SI LA TECLA ES MAYOR QUE LA 'Z' NO HACE NADA
        ADD AL, 32    ;Convierte may£scula en min£scula.
     CONTINUAR:
        RET
MINUSCULA ENDP

;----------------------------------------------------------------------------
;CAPTURA LA TECLA CON LA NOTA QUE EL USUARIO DESEA.

TECLA PROC
        MOV     AH,8            ;Si la hay, obtiene la nota
        INT     21H
        CALL    MINUSCULA
        RET
TECLA ENDP
;----------------------------------------------------------------------------
;Cicla el programa hasta que el usuario presione la tecla ESC.
;El procedimiento reacciona a las teclas indicadas en el segmento de datos.
;Cualquier otra tecla es ignorada.
;La tecla presionada es convertida a min£scula, ya que la tabla ASCII
;trata distinto unas de otras.
;Despu‚s de que cada tecla es presionada, el ciclo vuelve al inicio y
;se repite.
;Si la tecla presionada corresponde a una nota musical, el c¢digo
;correspondiente es enviado al parlante.

SPEAKER PROC
COMIENZA:
        CALL    TECLA
        CMP     AL,'q'   ;DO alto
        JNE     S1       ;SI NO ES LA TECLA ESPERADA, SALTA PARA VERIFICAR LA SIGUIENTE.
        TONO    523      ;SI ES LA TECLA ESPERADA, GENERA EL SONIDO CORRESPONDIENTE
        JMP     COMIENZA ;DESPUES DEL SONIDO REINICIA PARA ESPERAR OTRO SONIDO.
S1:     CMP     AL,'w'   ;RE alto
        JNE     S2
        TONO    587
        JMP     COMIENZA
S2:     CMP     AL,'e'   ;MI alto
        JNE     S3
        TONO    659
        JMP     COMIENZA
S3:     CMP     AL,'r'   ;FA alto
        JNE     S4
        TONO    698
        JMP     COMIENZA
S4:     CMP     AL,'t'   ;SOL alto
        JNE     S5
        TONO    784
        JMP     COMIENZA
S5:     CMP     AL,'y'   ;LA alto
        JNE     S6
        TONO    880
        JMP     COMIENZA
S6:     CMP     AL,'u'   ;SI alto
        JNE     S8
        TONO    988
        JMP     NOSALTO1
SALTO1:
   JMP COMIENZA
NOSALTO1:
        JMP     COMIENZA
S8:     CMP     AL,'2'   ;DO# alto
        JNE     S9
        TONO    554
        JMP     COMIENZA
S9:     CMP     AL,'3'   ;RE# alto
        JNE     S10
        TONO    622
        JMP     COMIENZA
S10:    CMP     AL,'5'   ;FA# alto
        JNE     S11
        TONO    740
        JMP     COMIENZA
S11:    CMP     AL,'6'   ;SOL# alto
        JNE     S12
        TONO    830
        JMP     COMIENZA
S12:    CMP     AL,'7'   ;SIb alto
        JNE     S25
        TONO    923
        JMP     COMIENZA
SALTO2:
   JMP SALTO1
S25:    CMP     AL,27 ;27 = tecla ESC (terminar).
        JNE     SALTO2
        RET
SPEAKER ENDP

;----------------------------------------------------------------------------

msg PROC
        MOV     AH,9
        LEA     DX,playMS
        INT     21H
        RET
msg ENDP

;----------------------------------------------------------------------------

RUN:
        MOV     AX, @data         
        MOV     DS, AX            
        CALL    CLRSCR            ;clean.
        CALL    msg               ;msg.
        CALL    SPEAKER           ;sound on.
        MOV     AX, 4C00H
        INT     21H

;----------------------------------------------------------------------------

END RUN