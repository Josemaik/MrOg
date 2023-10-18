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

.area _CODE

