.module Templates_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.area _DATA
;; creamos una entidad de inicialización
;; MOTHERSHIP ENTITY
mothership_template_e:: 
	.db 	#E_TYPE_MOTHERSHIP				;; entity type
      .db     #E_CMP_MOVABLE | #E_CMP_RENDER | #E_CMP_IA;; cmps
		.db     #0x26               ;; x = 38
		.db     #0x0A               ;; y = 10
		.db     #SPR_MOTHERSHIP_W   ;; width 
		.db     #SPR_MOTHERSHIP_H   ;; height
		.db     #1                 ;; vx = -1
		.db     #0x00               ;; vy = 0
		.dw     #_spr_mothership    ;; sprite (2b)
      .dw     #sys_ai_behaviour_mothership ;; behaviour
	  .db 	#0x00					;; ai_counter
      .dw     #0x0000               ;;anim
      .db     #0x00              ;;animcounter c = 0
	  .db 	#0x00				;;collides_against
;; ENEMY1 ENTITY
enemy1_template_e:: 
.db 	#E_TYPE_ENEMY				;; entity type
      .db     #E_CMP_MOVABLE | #E_CMP_ANIMATED | #E_CMP_RENDER | #E_CMP_IA | #E_CMP_COLLIDER;; cmps
		.db     #0x00               ;; x = 0
		.db     #LANE0_Y               ;; y = 40
		.db     #SPR_ENEMY1_0_W   ;; width 
		.db     #SPR_ENEMY1_0_H   ;; height
		.db     #0x00                 ;; vx = 0
		.db     #0x00               ;; vy = 0
		.dw     #_spr_enemy1_0    ;; sprite (2b)
      .dw     #sys_ai_behaviour_enemy ;; behaviour
	  .db 	#0x00					;; ai_counter
      .dw     #man_anim_enemy1               ;;anim
      .db     #MAN_ANIM_ENEMY1_TIME          ;;animcounter c = 12
	  .db 	#0x00				;;collides_against

;; PLAYERSHIP ENTITY
playership_template1_e:: 
.db 	#E_TYPE_ENEMY				;; entity type
      .db     #E_CMP_RENDER ;; cmps
		.db     #0x00               ;; x = 0
		.db     #0xC0               ;; y = 192
		.db     #SPR_PLAYERSHIP_1_W   ;; width 
		.db     #SPR_PLAYERSHIP_1_H   ;; height
		.db     #0x00                 ;; vx = 0
		.db     #0x00               ;; vy = 0
		.dw     #_spr_playership_1    ;; sprite (2b)
      .dw     #0x0000 ;; behaviour
	  .db 	#0x00					;; ai_counter
      .dw     #0x0000 ;; anim
      .db     #0x00              ;;animcounter c = 0
	  .db 	#0x00				;;collides_against
;; PLAYER
playership_template0_e:: 
		.db 	#E_TYPE_PLAYER				;; entity type
      .db     #E_CMP_RENDER | #E_CMP_MOVABLE | #E_CMP_INPUT ;;| #E_CMP_COLLIDER ;; cmps
		.db     #0x26               ;; x = 38
		.db     #PLAYER_Y               ;; y = 180
		.db     #SPR_PLAYERSHIP_0_W   ;; width 
		.db     #SPR_PLAYERSHIP_0_H   ;; height
		.db     #0x00                 ;; vx = 0
		.db     #0x00               ;; vy = 0
		.dw     #_spr_playership_0    ;; sprite (2b)
      .dw     #0x0000 ;; behaviour
	  .db 	#0x00					;; ai_counter
      .dw     #0x0000 ;; anim
      .db     #0x00              ;;animcounter c = 0
	  .db 	#0x00				;;collides_against
;; PLAYER SHOT
playershot_template_e:: 
	.db 	#E_TYPE_SHOT				;; entity type
      .db     #E_CMP_MOVABLE | #E_CMP_RENDER | #E_CMP_IA | #E_CMP_COLLIDER;; cmps
		.db     #0x00               ;; x = 0
		.db     #PLAYERSHOT_Y               ;; y = 188
		.db     #SPR_VSHOT_W   ;; width 
		.db     #SPR_VSHOT_H   ;; height
		.db     #0x00                 ;; vx = 0
		.db     #-8               ;; vy = 0
		.dw     #_spr_vshot    ;; sprite (2b)
      .dw     #sys_ai_behaviour_autodestroy ;; behaviour
	  .db 	#0x0E					;; ai_counter = 14
      .dw     #0x0000               ;;anim
      .db     #0x00          ;;animcounter c = 12
	  .db 	#E_TYPE_ENEMY				;;collides_against