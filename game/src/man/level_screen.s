.include "cpctelera.h.s"

.module Level_Screen_Manager

.globl cpct_scanKeyboard_f_asm
.globl cpct_isKeyPressed_asm
.globl cpct_setDrawCharM0_asm
.globl cpct_drawStringM0_asm
.globl cpct_getScreenPtr_asm
.globl _sys_render_level_screen
.globl _sys_render_level_screen
.globl mapa_actual
.globl puntos_conseguidos

nivel_actual:
.db 0

string_intro: .asciz "MY SWAMP"
string: .asciz "LEVEL"

string_puntos: .asciz "CURRENT POINTS:"

numeros::
.db "0"
.db 0x00
.db "1"
.db 0x00
.db "2"
.db 0x00
.db "3"
.db 0x00
.db "4"
.db 0x00
.db "5"
.db 0x00
.db "6"
.db 0x00
.db "7"
.db 0x00
.db "8"
.db 0x00
.db "9"
.db 0x00
id_numeros::
    .db 0x01
set_level_screen::
;; Level Screen
      call man_levelscreen_init
      levelscreen_loop:
         call man_levelscreen_update
         jr    z, levelscreen_loop
ret
set_iy:
   ld a , (hl)
   cp #0
   jr z, poner_iy_0
   ld a , (hl)
   cp #1
   jr z, poner_iy_1
   ld a , (hl)
   cp #2
   jr z, poner_iy_2
     ld a , (hl)
   cp #3
   jr z, poner_iy_3
     ld a , (hl)
   cp #4
   jr z, poner_iy_4
     ld a , (hl)
   cp #5
   jr z, poner_iy_5
     ld a , (hl)
   cp #6
   jr z, poner_iy_6
     ld a , (hl)
   cp #7
   jr z, poner_iy_7
     ld a , (hl)
   cp #8
   jr z, poner_iy_8
   ld a , (hl)
   cp #9
   jr z, poner_iy_9
   ret
   poner_iy_0: 
   ld iy, #numeros 
   ret
   poner_iy_1: 
   ld iy, #numeros + 2
   ret
   poner_iy_2: 
   ld iy, #numeros + 4
   ret
   poner_iy_3: 
   ld iy, #numeros + 6
   ret
   poner_iy_4: 
   ld iy, #numeros + 8
   ret
   poner_iy_5: 
   ld iy, #numeros + 10
   ret
   poner_iy_6: 
   ld iy, #numeros + 12
   ret
   poner_iy_7: 
   ld iy, #numeros + 14
   ret
   poner_iy_8: 
   ld iy, #numeros + 16
   ret
   poner_iy_9: 
   ld iy, #numeros + 18
ret
man_levelscreen_init::
    call _sys_render_level_screen
    ld    h, #0
    ld    l, #10     
    call cpct_setDrawCharM0_asm
   ;; Calculate a video-memory location for printing a string
   ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, #24                  ;; B = y coordinate (24 = 0x18)
   ld    c, #16                  ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL


   ;; Print the string in video memory
   ;; HL already points to video memory, as it is the return
   ;; value from cpct_getScreenPtr_asm
   ld   iy, #string    ;; IY = Pointer to the string 

   call cpct_drawStringM0_asm  ;; Draw the string

   ;; Calculate a video-memory location for printing a string
   ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, #24                  ;; B = y coordinate (24 = 0x18)
   ld    c, #40                ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
    ld a, (id_numeros)
    cp #1
    jr z, set_lvl_1
    ;;lvl2
    ld iy , #numeros + 4
    jr dibujar_lvl
    set_lvl_1:
    ld iy, #numeros + 2
    dibujar_lvl:
    call cpct_drawStringM0_asm  ;; Draw the string
    ld a, (id_numeros)
    inc a
    ld (id_numeros), a

   ;; Calculate a video-memory location for printing a string
   ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, #50                  ;; B = y coordinate (24 = 0x18)
   ld    c, #16                ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

    call set_iy
    ld iy, #string_intro
   call cpct_drawStringM0_asm  ;; Draw the string

    ;; Calculate a video-memory location for printing a string
   ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, #70                  ;; B = y coordinate (24 = 0x18)
   ld    c, #16                ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

    
    ld iy, #string_puntos
   call cpct_drawStringM0_asm  ;; Draw the string

;    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
;    ld    b, #85                  ;; B = y coordinate (24 = 0x18)
;    ld    c, #16                ;; C = x coordinate (16 = 0x10)

;    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

;     ld hl , #puntos_conseguidos
;     ; call set_iy
;     ld iy, #puntos_conseguidos
;    call cpct_drawStringM0_asm  ;; Draw the string

;      ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
;    ld    b, #85                  ;; B = y coordinate (24 = 0x18)
;    ld    c, #23               ;; C = x coordinate (16 = 0x10)

;    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

;      ld hl , #puntos_conseguidos+1
;     ; call set_iy
;     ld iy, #puntos_conseguidos+1
;    call cpct_drawStringM0_asm  ;; Draw the string

;     ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
;    ld    b, #85                 ;; B = y coordinate (24 = 0x18)
;    ld    c, #28            ;; C = x coordinate (16 = 0x10)

;    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

;     ld hl , #puntos_conseguidos+2
;     ; call set_iy
;     ld iy, #puntos_conseguidos + 2
;    call cpct_drawStringM0_asm  ;; Draw the string

ret

man_levelscreen_update::
    call cpct_scanKeyboard_f_asm
    ld  hl, #Key_Return
    call cpct_isKeyPressed_asm
    
ret