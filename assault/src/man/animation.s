.module Animation_Manager

.include "cpctelera.h.s"
.include "animation.h.s"
.include "entity.h.s"
.area _DATA
;;Array de sprites
man_anim_enemy1::
    .db #0x0c
    .dw _spr_enemy1_0
    .db #0x0c
    .dw _spr_enemy1_1
    .db #0x00
    .dw #man_anim_enemy1

.area _CODE

