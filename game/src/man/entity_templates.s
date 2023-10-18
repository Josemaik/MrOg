.module Templates_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.include "animation.h.s"

.area _DATA
player_entity:: 
		.db 	#E_TYPE_PLAYER			;; entity type
      .db     #E_CMP_RENDER | #E_CMP_MOVABLE | #E_CMP_INPUT | #E_CMP_ANIMATED | #E_CMP_COLLIDER;; cmps
		.db     #0x26               ;; x = 38
		.db     #65              ;; y = 180
		.db     #SPR_SPRITE1_S_W   ;; width 
		.db     #SPR_SPRITE1_S_H   ;; height
		.db     #0x00                 ;; vx = 0
		.db     #0x00               ;; vy = 0
		.dw     #_spr_spritesheet_00  ;; sprite (2b)
      .dw     #0x0000 ;; behaviour
	  .db 	#0x00					;; ai_counter   //// HABRA QUE BORRARLO YA QUE NO LO USAREMOS DE MOMENTO
      .dw     #0x0000 ;; anim
      .db     #0x0c            ;;animcounter c = 0
	  .db 	#0x00				;;collides_against
	  .dw   #0x0000				;; last draw
	  .db   #DIRECT_S			;; direction
deflator_Dennis_entity:: 
		.db 	#E_TYPE_ENEMY			;; entity type
      .db     #E_CMP_RENDER | #E_CMP_MOVABLE | #E_CMP_IA ;; | #E_CMP_ANIMATED |#E_CMP_COLLIDER ;; cmps
		.db     #70               ;; x = 38
		.db     #20              ;; y = 180
		.db     #SPR_SPRITE1_S_W   ;; width 
		.db     #SPR_SPRITE1_S_H   ;; height
		.db     #0x00                 ;; vx = -1
		.db     #0x00               ;; vy = 0
		.dw     #_spr_spritesheet_00  ;; sprite (2b)
      .dw     #sys_ai_surround_map ;; behaviour
	  .db 	#0x00					;; ai_counter
      .dw     #0x0000 ;; anim
      .db     #MAN_ANIM_PLAYER_TIME            ;;animcounter c = 0
	  .db 	#0x00				;;collides_against
	  .dw   #0x0000				;; last draw
	  .db   #DIRECT_S			;; direction