;; sprites
.globl _spr_vidas
.globl _spr_bombahud
;; sys
.globl sys_render_life_or_bomb
.globl sys_render_score
;;cpct
.globl cpct_setDrawCharM0_asm
.globl cpct_drawStringM0_asm
;;array_vidas
    DIE_OR_ALIVE = 0
    X = 1
    Y = 2
    sprite = 3

DISTANCE_BETWEEN_VIDAS = 5