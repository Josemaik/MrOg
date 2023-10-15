.module Animation_Manager

.include "cpctelera.h.s"
.include "animation.h.s"
.include "entity.h.s"
.area _DATA


;;Array de sprites
anim_W::
  .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite1_W
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite2_W
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite3_W
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite4_W
    .db #0x00
    .dw #anim_W
anim_A::
 .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite1_A
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite2_A
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite3_A
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite4_A
    .db #0x00
    .dw #anim_A
anim_S::
 .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite1_S
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite2_S
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite3_S
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite4_S
    .db #0x00
    .dw #anim_S
anim_D::
  .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite1_A
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite2_A
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite3_A
    .db #MAN_ANIM_ENEMY1_TIME
    .dw _spr_sprite4_A
    .db #0x00
    .dw #anim_A

.area _CODE

