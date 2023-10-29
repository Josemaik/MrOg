;; sprites
.globl _spr_vidas
;; sys
.globl sys_render_life
.globl cpct_getScreenPtr_asm
.globl sys_render_char
;;cpct
;;array_vidas
    DIE_OR_ALIVE = 0
    X = 1
    Y = 2
    sprite = 3

DISTANCE_BETWEEN_VIDAS = 5
TIME_UPDATE_SCORE = 60