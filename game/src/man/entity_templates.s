.module Templates_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.include "animation.h.s"

.area _DATA
playership_template0_e:: 
		.db 	#E_TYPE_PLAYER			;; entity type
      .db     #E_CMP_RENDER | #E_CMP_MOVABLE | #E_CMP_INPUT | #E_CMP_ANIMATED ;; cmps
		.db     #0x26               ;; x = 38
		.db     #65              ;; y = 180
		.db     #SPR_SPRITE1_S_W   ;; width 
		.db     #SPR_SPRITE1_S_H   ;; height
		.db     #0x00                 ;; vx = 0
		.db     #0x00               ;; vy = 0
		.dw     #_spr_sprite1_S  ;; sprite (2b)
      .dw     #0x0000 ;; behaviour
	  .db 	#0x00					;; ai_counter
      .dw     #0x0000 ;; anim
      .db     #0x01            ;;animcounter c = 0
	  .db 	#0x00				;;collides_against
	  .dw   #0x0000				;; last draw
