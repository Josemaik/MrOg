.module Animation_Manager

.include "cpctelera.h.s"
.include "animation.h.s"
.include "entity.h.s"
.area _DATA

anims_actual_enemy::
    .dw 0x0000 ;; arriba 0 
    .dw 0x0000 ;; abajo 2
    .dw 0x0000 ;; derecha 4
    .dw 0x0000 ;; izquierda 6

;;Array de sprites
anim_W::
  .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_08
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_09
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_10
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_11
    .db #0x00
    .dw #anim_W
anim_A::
 .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_04
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_05
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_06
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_07
    .db #0x00
    .dw #anim_A
anim_S::
 .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_00
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_01
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_02
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_03
    .db #0x00
    .dw #anim_S
anim_D::
  .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_12
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_13
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_14
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_spritesheet_15
    .db #0x00
    .dw #anim_D
anim_player_died::
    .db #MAN_ANIM_PLAYER_HIT_ENEMY
    .dw _spr_muelte_0
    .db #MAN_ANIM_PLAYER_HIT_ENEMY
    .dw _spr_muelte_1
    .db #MAN_ANIM_PLAYER_HIT_ENEMY
    .dw _spr_muelte_2
    .db #MAN_ANIM_PLAYER_HIT_ENEMY
    .dw _spr_muelte_3
    .db #MAN_ANIM_PLAYER_HIT_ENEMY
    .dw _spr_muelte_4
    .db #0x00
    .dw #anim_player_died
anim_player_resucitar::
    .db #MAN_ANIM_PLAYER_HIT_ENEMY
    .dw _spr_resucitar_0
    .db #MAN_ANIM_PLAYER_HIT_ENEMY
    .dw _spr_resucitar_1
    .db #MAN_ANIM_PLAYER_HIT_ENEMY
    .dw _spr_resucitar_2
    .db #MAN_ANIM_PLAYER_HIT_ENEMY
    .dw _spr_resucitar_3
    .db #MAN_ANIM_PLAYER_HIT_ENEMY
    .dw _spr_resucitar_4
    .db #MAN_ANIM_PLAYER_HIT_ENEMY
    .dw _spr_resucitar_5
    .db #0x00
    .dw #anim_player_resucitar
anim_eat::
    .db #MAN_ANIM_PLAYER_EAT
    .dw _spr_comer_0
    .db #MAN_ANIM_PLAYER_EAT
    .dw _spr_comer_1
    .db #MAN_ANIM_PLAYER_EAT
    .dw _spr_comer_2
    .db #0x00
    .dw #anim_eat

anim_burro_up::
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_08
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_09
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_10
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_11
    .db #0x00
    .dw #anim_burro_up

anim_burro_left::
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_04
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_05
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_06
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_07
    .db #0x00
    .dw #anim_burro_left

anim_burro_down::
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_00
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_01
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_02
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_03
    .db #0x00
    .dw #anim_burro_down

anim_burro_right::
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_12
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_13
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_14
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_burro_15
    .db #0x00
    .dw #anim_burro_right



anim_enemy_up::
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_enemigo_flobier_6
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_enemigo_flobier_7
    .db #0x00
    .dw #anim_enemy_up

anim_enemy_left::
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_enemigo_flobier_4
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_enemigo_flobier_5
    .db #0x00
    .dw #anim_enemy_left

anim_enemy_down::
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_enemigo_flobier_0
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_enemigo_flobier_1
    .db #0x00
    .dw #anim_enemy_down

anim_enemy_right::
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_enemigo_flobier_2
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_enemigo_flobier_3
    .db #0x00
    .dw #anim_enemy_right

    
anim_llave::
    .db #MAN_ANIM_PLAYER_KEY
    .dw _spr_llave_0
    .db #MAN_ANIM_PLAYER_KEY
    .dw _spr_llave_1
    .db #MAN_ANIM_PLAYER_KEY
    .dw _spr_llave_2
    .db #MAN_ANIM_PLAYER_KEY
    .dw _spr_llave_3
    .db #MAN_ANIM_PLAYER_KEY
    .dw _spr_llave_4
    .db #MAN_ANIM_PLAYER_KEY
    .dw _spr_llave_5
    .db #MAN_ANIM_PLAYER_KEY
    .dw _spr_llave_6
    .db #MAN_ANIM_PLAYER_KEY
    .dw _spr_llave_7
    .db #0x00
    .dw #anim_llave


anim_helado::
    .db #MAN_ANIM_PLAYER_ICECREAM
    .dw _spr_helado_0
    .db #MAN_ANIM_PLAYER_ICECREAM
    .dw _spr_helado_1
    .db #MAN_ANIM_PLAYER_ICECREAM
    .dw _spr_helado_2
    .db #MAN_ANIM_PLAYER_ICECREAM
    .dw _spr_helado_3
    .db #0x00
    .dw #anim_helado
    

.area _CODE

set_burro_animations::
    ;; arriba
    ld bc, #anim_burro_up
    ld a , c
    ld (anims_actual_enemy) , a
    ld a , b
    ld (anims_actual_enemy + 1) , a
    ;; abajo
    ld bc, #anim_burro_down
    ld a , c
    ld (anims_actual_enemy+ 2) , a
    ld a , b
    ld (anims_actual_enemy + 3) , a
    ;; derecha
    ld bc, #anim_burro_right
    ld a , c
    ld (anims_actual_enemy + 4) , a
    ld a , b
    ld (anims_actual_enemy + 5) , a
    ;; izquierda
    ld bc, #anim_burro_left
    ld a , c
    ld (anims_actual_enemy + 6) , a
    ld a , b
    ld (anims_actual_enemy + 7) , a
ret
set_lord_animations::
 ;; arriba
    ld bc, #anim_enemy_up
    ld a , c
    ld (anims_actual_enemy) , a
    ld a , b
    ld (anims_actual_enemy + 1) , a
    ;; abajo
    ld bc, #anim_enemy_down
    ld a , c
    ld (anims_actual_enemy +2) , a
    ld a , b
    ld (anims_actual_enemy + 3) , a
    ;; derecha
    ld bc, #anim_enemy_right
    ld a , c
    ld (anims_actual_enemy+ 4) , a
    ld a , b
    ld (anims_actual_enemy + 5) , a
    ;; izquierda
    ld bc, #anim_enemy_left
    ld a , c
    ld (anims_actual_enemy + 6) , a
    ld a , b
    ld (anims_actual_enemy + 7) , a
ret