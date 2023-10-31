.include "cpctelera.h.s"

.module Level_Screen_Manager

.globl cpct_scanKeyboard_f_asm
.globl cpct_isKeyPressed_asm
.globl cpct_setDrawCharM0_asm
.globl cpct_drawStringM0_asm
.globl cpct_getScreenPtr_asm
.globl _sys_render_level_screen
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
string_instrucciones:
.asciz "EAT ALL ICECREAM IN THE LEAST TIME"
string_score:
.asciz "TOTAL SCORE:"


numeros: 
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

        
    ld iy, #numeros
    call cpct_drawStringM0_asm  ;; Draw the string

    ;; Calculate a video-memory location for printing a string
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #50                  ;; B = y coordinate (24 = 0x18)
    ld    c, #10                ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL


    ld a, (numeros)
    cp #0x31
    jr z, intro_1

    ld a, (numeros)
    cp #0x32
    jr z, intro_2

    ld a, (numeros)
    cp #0x33
    jr z, intro_3
    
    intro_1:
    ld iy, #string_intro
    jr draw_intro_1

    intro_2:
    ld iy, #string_intro_2
    jr draw_intro_desp

    intro_3:
    ld iy, #string_intro_3
    jr draw_intro_desp

    draw_intro_1:
    jr instrucciones

    draw_intro_desp:
    call cpct_drawStringM0_asm


score:
    call cpct_drawStringM0_asm
    ld    h, #0
    ld    l, #2     
    call cpct_setDrawCharM0_asm

    ;; Calculate a video-memory location for printing a string
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #80                  ;; B = y coordinate (24 = 0x18)
    ld    c, #8                ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

    ld iy, #string_score
    call cpct_drawStringM0_asm

    render_first_digit:
;; renderizar firs digit
    ld de, #dec_to_acii_first_digit
    ld hl, (id_first_digit)
    ld h, #0x00
    add hl , de
    ld a, (hl)
    ld e, a
    ld b, #80
    ld c, #0x3a
    call sys_render_char
    
    render_second_digit:
;; renderizar second digit
    ld bc, #dec_to_acii_second_digit
    ld hl, (id_second_digit)
    ld h, #0x00
    add hl, bc
    ld a, (hl)
    ld e, a
    ld b, #80
    ld c, #0x3f
    call sys_render_char
    render_third_digit:
;; renderizar tercer digito
    ld de, #"0"
    ld b, #80
    ld c, #0x44
    call sys_render_char

    jr incremento

instrucciones:
    call cpct_drawStringM0_asm
    ld    h, #0
    ld    l, #2     
    call cpct_setDrawCharM0_asm

    ;; Calculate a video-memory location for printing a string
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, #80                  ;; B = y coordinate (24 = 0x18)
    ld    c, #00                ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

    ld iy, #string_instrucciones
    call cpct_drawStringM0_asm

incremento:
    ld a, (numeros)
    inc a
    ld (numeros), a

ret

man_levelscreen_update::
    call cpct_scanKeyboard_f_asm
    ld  hl, #Key_Return
    call cpct_isKeyPressed_asm
    
ret