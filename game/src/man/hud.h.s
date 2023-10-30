;; sprites
.globl _spr_vidas
.globl _spr_llave_hud
.globl _spr_llave_hud_gris
;; sys
.globl sys_render_life
.globl sys_render_char
.globl sys_render_key
.globl tengo_llave
;;man
.globl lifes_available
.globl consumibles_actuales
;;array_vidas
    DIE_OR_ALIVE = 0
    X = 1
    Y = 2
    sprite = 3
    sprite_key = 2

DISTANCE_BETWEEN_VIDAS = 5
TIME_UPDATE_SCORE = 60