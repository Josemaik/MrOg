.include "cpctelera.h.s"
.include "level_screen.h.s"

.module Level_Screen_Manager


nivel_actual:
.db 0

.globl id_first_digit
.globl id_second_digit
.globl dec_to_acii_first_digit
.globl dec_to_acii_second_digit
.globl sys_render_char

string_level: .asciz "LEVEL"
string_intro: 
.asciz "MY DEAR SWAMP"
string_intro_2:
.asciz "MY SWAMP EVOLVED"
string_intro_3:
.asciz "MY SWAMP REAWAKENED"
string_intro_4:
.asciz "NOT MY SWAMP"
string_intro_5:
.asciz "GOODBYE MY SWAMP"
string_intro_11:
.asciz "CONGRATS"
string_intro_11_1:
.asciz "AMSTRAD Z80 !"
string_intro_6:
.asciz "CASTLE ME"
string_intro_7:
.asciz "MAYBE MY CASTLE"
string_intro_8:
.asciz "NO PRINCESS YET"
string_intro_9:
.asciz "ON ANOTHER CASTLE"
string_intro_10:
.asciz "YOUR CASTLE IS HERE"
string_instrucciones:
.asciz "EAT ALL ICECREAM"
string_instrucciones1:
.asciz "IN THE LEAST TIME" 
string_score: .asciz "TOTAL SCORE:"
string_puntos: .asciz "CURRENT POINTS:"

string_died: .asciz "YOU DIED :("
string_gotomenu: .asciz "PRESS [ENTER] TO"
string_gotomenu1: .asciz "GO TO THE MENU"
string_bonus: .asciz "BONUS"
string_10: .asciz "10"

string_enter: .asciz "PRESS ENTER"
numeros::
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
.db "6"
.db 0x00
.db "7"
.db 0x00
.db "8"
.db 0x00
.db "9"
.db 0x00
.db "10"
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
set_died_screen::
;; Died Screen
      call man_diedscreen_init
      levelscreen_loop1:
         call man_levelscreen_update
         jr    z, levelscreen_loop1
ret
man_diedscreen_init:
    ;; stop music
        call cpct_akp_stop_asm
    call _sys_render_level_screen
    ld    h, #0
    ld    l, #10     
    call cpct_setDrawCharM0_asm
    ;; Calculate a video-memory location for printing a string
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #80                  ;; B = y coordinate (24 = 0x18)
    ld    c, #24                  ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm 
    ld   iy, #string_died    ;; IY = Pointer to the string 
    call cpct_drawStringM0_asm  ;; Draw the string

    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #120                  ;; B = y coordinate (24 = 0x18)
    ld    c, #5                  ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm 
    ld iy, #string_gotomenu
    call cpct_drawStringM0_asm  ;; Draw the string

    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #140                  ;; B = y coordinate (24 = 0x18)
    ld    c, #15                  ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm 
    ld iy, #string_gotomenu1
    call cpct_drawStringM0_asm  ;; Draw the string

ret
man_levelscreen_init::
    call _sys_render_level_screen
    ld    h, #0
    ld    l, #10     
    call cpct_setDrawCharM0_asm
    ;; Calculate a video-memory location for printing a string
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #24                  ;; B = y coordinate (24 = 0x18)
    ld    c, #24                  ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL


    ;; Print the string in video memory
    ;; HL already points to video memory, as it is the return
    ;; value from cpct_getScreenPtr_asm
    ld   iy, #string_level    ;; IY = Pointer to the string 

    call cpct_drawStringM0_asm  ;; Draw the string

    ;; Calculate a video-memory location for printing a string
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #24                  ;; B = y coordinate (24 = 0x18)
    ld    c, #50                ;; C = x coordinate (16 = 0x10)


    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
    
    ld a, (id_numeros)
    cp #11
    jr z, bonus_level
    
    ld a, (id_numeros)
    cp #10
    jr z, level_10

    jr lvl_normal

    bonus_level:
    ld iy, #string_bonus
    jr dibujar_lvl

    level_10:
    ld iy, #string_10
    jr dibujar_lvl

    lvl_normal:
    ld iy, #numeros
    dibujar_lvl:
    call cpct_drawStringM0_asm  ;; Draw the string
    

    ;; Calculate a video-memory location for printing a string
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #50                  ;; B = y coordinate (24 = 0x18)
    ld    c, #4                ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL


    ld a, (id_numeros)
    cp #1
    jr z, intro_1

    ld a, (id_numeros)
    cp #2
    jr z, intro_2

    ld a, (id_numeros)
    cp #3
    jr z, intro_3

    ld a, (id_numeros)
    cp #4
    jr z, intro_4

    ld a, (id_numeros)
    cp #5
    jr z, intro_5

    ld a, (id_numeros)
    cp #6
    jr z, intro_6

    ld a, (id_numeros)
    cp #7
    jr z, intro_7

    ld a, (id_numeros)
    cp #8
    jr z, intro_8

    ld a, (id_numeros)
    cp #9
    jr z, intro_9

    ld a, (id_numeros)
    cp #10
    jr z, intro_10

    ld a, (id_numeros)
    cp #11
    jr z, intro_11
    
    intro_1:
    ld iy, #string_intro
    jr draw_intro_1

    intro_2:
    ld iy, #string_intro_2
    jr draw_intro_desp

    intro_3:
    ld iy, #string_intro_3
    jr draw_intro_desp

    intro_4:
    ld iy, #string_intro_4
    jr draw_intro_desp

    intro_5:
    ld iy, #string_intro_5
    jr draw_intro_desp

    intro_6:
    ld iy, #string_intro_6
    jr draw_intro_desp

    intro_7:
    ld iy, #string_intro_7
    jr draw_intro_desp

    intro_8:
    ld iy, #string_intro_8
    jr draw_intro_desp

    intro_9:
    ld iy, #string_intro_9
    jr draw_intro_desp

    intro_10:
    ld iy, #string_intro_10
    jr draw_intro_desp

    intro_11:
    ld iy, #string_intro_11
    jr draw_intro_desp1

    draw_intro_1:
    jr instrucciones

    draw_intro_desp:
    call cpct_drawStringM0_asm
    jr goto_decrementar
    draw_intro_desp1:
    call cpct_drawStringM0_asm

    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #64                  ;; B = y coordinate (24 = 0x18)
    ld    c, #4                ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm 
    ld iy, ##string_intro_11_1
    call cpct_drawStringM0_asm
    jr goto_decrementar
    instrucciones:
    call cpct_drawStringM0_asm

    ld    h, #0
    ld    l, #10     
    call cpct_setDrawCharM0_asm

    ;; Calculate a video-memory location for printing a string
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #80                  ;; B = y coordinate (24 = 0x18)
    ld    c, #5                ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

    ld iy, #string_instrucciones
    call cpct_drawStringM0_asm

    ;; Calculate a video-memory location for printing a string
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #92                  ;; B = y coordinate (24 = 0x18)
    ld    c, #5                ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

    ld iy, #string_instrucciones1
    call cpct_drawStringM0_asm

    goto_decrementar:
    ld a, (numeros)
    inc a
    ld (numeros), a
    ld a, (id_numeros)
    inc a
    ld (id_numeros), a
    ;; string score
    ld    h, #0
    ld    l, #10     
    call cpct_setDrawCharM0_asm

    ;; Calculate a video-memory location for printing a string
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #130                  ;; B = y coordinate (24 = 0x18)
    ld    c, #05                ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

    ld iy, #string_score
    call cpct_drawStringM0_asm




;; draw score
   ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, #130                  ;; B = y coordinate (24 = 0x18)
   ld    c, #55                ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
    push hl
    ld hl , #puntos_conseguidos
    ld e, (hl)
    pop hl
    ; call set_e
    ; ld iy, #puntos_conseguidos
   call cpct_drawCharM0_asm  ;; Draw the string

     ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, #130                 ;; B = y coordinate (24 = 0x18)
   ld    c, #60               ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
    push hl
     ld hl , #puntos_conseguidos+1
     ld e, (hl)
     pop hl
    ; call set_e
    ;;ld iy, #puntos_conseguidos+1
   call cpct_drawCharM0_asm  ;; Draw the string

    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, #130                 ;; B = y coordinate (24 = 0x18)
   ld    c, #65            ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
    push hl
    ld hl , #puntos_conseguidos+2
    ld e, (hl)
    pop hl
    ; call set_e
    ;;ld iy, #puntos_conseguidos + 2
   call cpct_drawCharM0_asm  ;; Draw the string
   ;; enter
    ld    h, #0
    ld    l, #9     
    call cpct_setDrawCharM0_asm
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #165                  ;; B = y coordinate (24 = 0x18)
    ld    c, #16              ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

    ld iy, #string_enter
    call cpct_drawStringM0_asm

ret

man_levelscreen_update::
    call cpct_scanKeyboard_f_asm
    ld  hl, #Key_Return
    call cpct_isKeyPressed_asm 
ret