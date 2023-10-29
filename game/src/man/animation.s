.module Animation_Manager

.include "cpctelera.h.s"
.include "animation.h.s"
.include "entity.h.s"
.area _DATA


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
    .dw #anim_W

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
    .dw #anim_A

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
    .dw #anim_S

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
    .dw #anim_D



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




anim_muelte::
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_0
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_0
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_1
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_1
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_2
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_2
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_3
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_3
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_4
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_4
    .db #0x00
    .dw #anim_muelte

anim_golpeado::
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_0
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_0
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_0
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_muelte_0
    .db #0x00
    .dw #anim_golpeado
    
anim_llave::
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_llave_0
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_llave_1
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_llave_2
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_llave_3
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_llave_4
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_llave_5
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_llave_6
    .db #MAN_ANIM_PLAYER_TIME
    .dw _spr_llave_7
    .db #0x00
    .dw #anim_llave
    
    
.area _CODE

