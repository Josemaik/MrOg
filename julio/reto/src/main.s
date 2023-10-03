.include "cpctelera.h.s"

.area _DATA

.globl cpct_disableFirmware_asm
.globl cpct_setDrawCharM1_asm
.globl cpct_drawCharM1_asm
.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm
.globl cpct_isAnyKeyPressed_asm

_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ld    d, #0        
   ld    e, #1         
   ;; Set draw char colours
   call cpct_setDrawCharM1_asm   

   ld    e, #"H"
   ld   hl, #0XC000
   ;; Draw char in HL
   call cpct_drawCharM1_asm

   ld    e, #"I"
   ld   hl, #0XC002
   ;; Draw char in HL
   call cpct_drawCharM1_asm

;; Comprobar si se ha pulsado cualquier tecla
loopCualquierLetra:
   call cpct_scanKeyboard_asm
   ;; Se pulsa la letra H
   ld   hl, #Key_H 
   call cpct_isKeyPressed_asm
   jr nz, pintarCyan
   ;; Se pulsa cualquier otra letra
   call cpct_isAnyKeyPressed_asm
   jr nz, pintarGuion

   jr loopCualquierLetra

;; Pintar en cyan
pintarCyan:
   ld    d, #0        
   ld    e, #2         
   ;; Set draw char colours
   call cpct_setDrawCharM1_asm   
   ld    e, #"H"
   ld   hl, #0XC000
   ;; Draw char in HL
   call cpct_drawCharM1_asm
   jr loopEspera

pintarGuion:
   ld    d, #0        
   ld    e, #3         
   ;; Set draw char colours
   call cpct_setDrawCharM1_asm   
   ld    e, #"-"
   ld   hl, #0XC000
   ;; Draw char in HL
   call cpct_drawCharM1_asm

ld a, #60
loopEspera:
   halt
   dec a
   jr nz, loopEspera

loopCualquierLetra2:
   call cpct_scanKeyboard_asm
   ;; Se pulsa la letra I
   ld   hl, #Key_I 
   call cpct_isKeyPressed_asm
   jr nz, pintarCyan2
   ;; Se pulsa cualquier otra letra
   call cpct_isAnyKeyPressed_asm
   jr nz, pintarGuion2

   jr loopCualquierLetra2

pintarCyan2:
   ld    d, #0        
   ld    e, #2         
   ;; Set draw char colours
   call cpct_setDrawCharM1_asm   
   ld    e, #"I"
   ld   hl, #0XC002
   ;; Draw char in HL
   call cpct_drawCharM1_asm
   jr loop2

pintarGuion2:
   ld    d, #0        
   ld    e, #3         
   ;; Set draw char colours
   call cpct_setDrawCharM1_asm   
   ld    e, #"-"
   ld   hl, #0XC002
   ;; Draw char in HL
   call cpct_drawCharM1_asm

loop2:
   jr loop2