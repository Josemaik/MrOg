.module Templates_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.include "animation.h.s"

.area _DATA
player_entity:: 
		.db 	#E_TYPE_PLAYER			;; entity type
      .db     #E_CMP_RENDER | #E_CMP_MOVABLE | #E_CMP_INPUT | #E_CMP_ANIMATED | #E_CMP_COLLIDER;; cmps
		.db     #20               ;; x = 38
		.db     #60              ;; y = 180
		.db     #SPR_SPRITE1_S_W   ;; width 
		.db     #SPR_SPRITE1_S_H   ;; height
		.db     #0x00                 ;; vx = 0
		.db     #0x00               ;; vy = 0
		.dw     #_spr_spritesheet_00  ;; sprite (2b)
      .dw     #0x0000 ;; behaviour
	  .db 	#0x00					;; ai_counter   //// HABRA QUE BORRARLO YA QUE NO LO USAREMOS DE MOMENTO
      .dw     #anim_S ;; anim
      .db     #0x0c            ;;animcounter c = 0
	  .db 	#0x00				;;collides_against
	  .dw   #0x0000				;; last draw
	;   .dw   #0x00C4			;; last draw2
	  .db   #DIRECT_S			;; direction
	  .db  #0x00
; deflator_Dennis_entity:: 
; 		.db 	#E_TYPE_ENEMY			;; entity type
;       .db     #E_CMP_RENDER | #E_CMP_MOVABLE | #E_CMP_IA ;; | #E_CMP_ANIMATED |#E_CMP_COLLIDER ;; cmps
; 		.db     #70               ;; x = 38
; 		.db     #20              ;; y = 180
; 		.db     #SPR_SPRITE1_S_W   ;; width 
; 		.db     #SPR_SPRITE1_S_H   ;; height
; 		.db     #0x00                 ;; vx = -1
; 		.db     #0x00               ;; vy = 0
; 		.dw     #_spr_burro_00  ;; sprite (2b)
;       .dw     #sys_ai_surround_map ;; behaviour
; 	  .db 	#0x00					;; ai_counter
;       .dw     #0x0000 ;; anim
;       .db     #MAN_ANIM_PLAYER_TIME            ;;animcounter c = 0
; 	  .db 	#0x00				;;collides_against
; 	  .dw   #0x0000				;; last draw
; 	;   .dw   #0x00C4				;; last draw2
; 	  .db   #DIRECT_S			;; direction
; 	  .db  #0x00
flobier_entity:: 
		.db 	#E_TYPE_ENEMY2			;; entity type
      .db     #E_CMP_RENDER | #E_CMP_MOVABLE | #E_CMP_IA | #E_CMP_ANIMATED | #E_CMP_COLLIDER;; | #E_CMP_ANIMATED |#E_CMP_COLLIDER ;; cmps
		.db     #64               ;; x = 38
		.db     #33              ;; y = 180
		.db     #SPR_ENEMIE_FLOBIER_W   ;; width 
		.db     #SPR_ENEMIE_FLOBIER_H   ;; height
		.db     #-1                 ;; vx = -1
		.db     #0x00               ;; vy = 0
		.dw     #_spr_enemigo_flobier_0  ;; sprite (2b)
      .dw     #sys_ai_vertical_enemie ;; behaviour
	  .db 	#0x0c					;; ai_counter
      .dw     #anim_enemy_left ;; anim
      .db     #MAN_ANIM_PLAYER_ENEMY            ;;animcounter c = 0
	  .db 	#E_TYPE_PLAYER				;;collides_against
	  .dw   #0x0000				;; last draw
	;   .dw   #0x00C4				;; last draw2
	  .db   #DIRECT_S			;; direction
	  .db  #0x00
flobier_entity2:: 
		.db 	#E_TYPE_ENEMY3			;; entity type
      .db     #E_CMP_RENDER | #E_CMP_MOVABLE | #E_CMP_IA | #E_CMP_COLLIDER | #E_CMP_ANIMATED ;;|#E_CMP_COLLIDER ;; cmps
		.db     #32               ;; x = 38
		.db     #160              ;; y = 180
		.db     #SPR_ENEMIE_FLOBIER_W   ;; width 
		.db     #SPR_ENEMIE_FLOBIER_H   ;; height
		.db     #0x00                 ;; vx = -1
		.db     #-1               ;; vy = 0
		.dw     #_spr_enemigo_flobier_0  ;; sprite (2b)
      .dw     #sys_ai_horizontal_enemie ;; behaviour
	  .db 	#0x0c					;; ai_counter
      .dw     #anim_enemy_down ;; anim
      .db     #MAN_ANIM_PLAYER_ENEMY            ;;animcounter c = 0
	  .db 	#E_TYPE_PLAYER				;;collides_against
	  .dw   #0x0000				;; last draw
	;   .dw   #0x00C4				;; last draw2
	  .db   #DIRECT_S			;; direction
	  .db  #0x00
flobier_entity_patron_mapa1:: 
		.db 	#E_TYPE_ENEMY4			;; entity type
      .db     #E_CMP_RENDER | #E_CMP_MOVABLE | #E_CMP_IA ;;| #E_CMP_COLLIDER;; | #E_CMP_ANIMATED |#E_CMP_COLLIDER ;; cmps
		.db     #56               ;; x = 38
		.db     #72              ;; y = 180
		.db     #SPR_ENEMIE_FLOBIER_W   ;; width 
		.db     #SPR_ENEMIE_FLOBIER_H   ;; height
		.db     #1                ;; vx = -1
		.db     #0x00               ;; vy = 0
		.dw     #_spr_enemigo_flobier_0  ;; sprite (2b)
      .dw     #sys_ai_patron_enemie_mapa1 ;; behaviour
	  .db 	#0x00					;; ai_counter
      .dw     #0x0000 ;; anim
      .db     #MAN_ANIM_PLAYER_ENEMY            ;;animcounter c = 0
	  .db 	#0x00				;;collides_against
	  .dw   #0x0000				;; last draw
	;   .dw   #0x00C4				;; last draw2
	  .db   #DIRECT_S			;; direction
	  .db  #0x00
bomba_entity:: 
		.db 	#E_TYPE_BOMB			;; entity type
      .db     #E_CMP_RENDER | #E_CMP_ANIMATED ;; |#E_CMP_COLLIDER ;; cmps
		.db     #0X00               ;; x = 38
		.db     #0X00             ;; y = 180
		.db     #SPR_BOMBA_W   ;; width 
		.db     #SPR_BOMBA_H   ;; height
		.db     #0x00                 ;; vx = -1
		.db     #0x00               ;; vy = 0
		.dw     #_spr_bomba_0  ;; sprite (2b)
      .dw     #0x0000;; behaviour
	  .db 	#0x00					;; ai_counter
      .dw     #anim_bomba ;; anim
      .db     #MAN_ANIM_PLAYER_BOMB          ;;contador para morir c = 0
	  .db 	#0x00				;;collides_against
	  .dw   #0x0000				;; last draw
	;   .dw   #0x00C4				;; last draw2
	  .db   #0x00			;; direction
	  .db  #0x58

helado_entity::
		 .db 	#E_TYPE_FOOD			;; entity type
      .db     #E_CMP_RENDER | #E_CMP_COLLIDER ;; cmps
		.db     #0x00               ;; x = 38
		.db     #0x00             ;; y = 180
		.db     #SPR_HELADO_W   ;; width 
		.db     #SPR_HELADO_H   ;; height
		.db     #0x00                 ;; vx = -1
		.db     #0x00               ;; vy = 0
		.dw     #_spr_helado  ;; sprite (2b)
      .dw     #0x0000;; behaviour
	  .db 	#0x00					;; ai_counter
      .dw     #0x00 ;; anim
      .db     #0x00          ;;contador para morir c = 0
	  .db 	#E_TYPE_PLAYER				;;collides_against
	  .dw   #0x0000				;; last draw
	;   .dw   #0x00C4				;; last draw2
	  .db   #0x00			;; direction
	  .db  #0x00