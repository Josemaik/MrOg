.include "cpctelera.h.s"
.include "assets/screens/menu_screen_z.h.s"

.module Menu_Manager

.globl cpct_zx7b_decrunch_s_asm
.globl _sys_render_init
.globl cpct_scanKeyboard_f_asm
.globl cpct_isKeyPressed_asm
man_menu_init::
    call _sys_render_init

    ld  hl, #_menu_screen_z_end
    ld  de, #0xFFFF
    call cpct_zx7b_decrunch_s_asm
ret

man_menu_update::
    call cpct_scanKeyboard_f_asm
    ld  hl, #Key_Return
    call cpct_isKeyPressed_asm
    
    ret