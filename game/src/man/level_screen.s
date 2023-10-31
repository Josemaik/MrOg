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

nivel_actual:
.db 0

string_intro: .asciz "MY SWAMP"
string: .asciz "LEVEL"

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
    ld iy , #numeros + 2
    jr dibujar_lvl
    set_lvl_1:
    ld iy, #numeros
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

    
    ld iy, #string_intro
   call cpct_drawStringM0_asm  ;; Draw the string


ret

man_levelscreen_update::
    call cpct_scanKeyboard_f_asm
    ld  hl, #Key_Return
    call cpct_isKeyPressed_asm
    
ret