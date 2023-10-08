.module Game_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.area _DATA

;; 1 = 000000001
;; 2 = 000000010
;; OR= 000000011
;; creamos una entidad de inicialización
;; MOTHERSHIP ENTITY
mothership_template_e:: 
      .db     #E_TYPE_MOVABLE | #E_TYPE_RENDER | #E_TYPE_IA;; entity type
		.db     #0x26               ;; x = 38
		.db     #0x0A               ;; y = 10
		.db     #SPR_MOTHERSHIP_W   ;; width 
		.db     #SPR_MOTHERSHIP_H   ;; height
		.db     #1                 ;; vx = -1
		.db     #0x00               ;; vy = 0
		.dw     #_spr_mothership    ;; sprite (2b)
      .dw     #sys_ai_behaviour_mothership
;; ENEMY1 ENTITY
enemy1_template_e:: 
      .db     #E_TYPE_MOVABLE | #E_TYPE_RENDER | #E_TYPE_IA;; entity type
		.db     #0x00               ;; x = 0
		.db     #0x28               ;; y = 30
		.db     #SPR_ENEMY1_0_W   ;; width 
		.db     #SPR_ENEMY1_0_H   ;; height
		.db     #0x00                 ;; vx = 0
		.db     #0x00               ;; vy = 0
		.dw     #_spr_enemy1_0    ;; sprite (2b)
      .dw     #sys_ai_behaviour_left_right

;; PLAYERSHIP ENTITY
playership_template1_e:: 
      .db     #E_TYPE_RENDER ;; entity type
		.db     #0x00               ;; x = 0
		.db     #0xC0               ;; y = 192
		.db     #SPR_PLAYERSHIP_1_W   ;; width 
		.db     #SPR_PLAYERSHIP_1_H   ;; height
		.db     #0x00                 ;; vx = 0
		.db     #0x00               ;; vy = 0
		.dw     #_spr_playership_1    ;; sprite (2b)
      .dw     #0x0000
;; PLAYER
playership_template0_e:: 
      .db     #E_TYPE_RENDER | #E_TYPE_MOVABLE | #E_TYPE_INPUT  ;; entity type
		.db     #0x26               ;; x = 38
		.db     #0xB4               ;; y = 180
		.db     #SPR_PLAYERSHIP_0_W   ;; width 
		.db     #SPR_PLAYERSHIP_0_H   ;; height
		.db     #0x00                 ;; vx = 0
		.db     #0x00               ;; vy = 0
		.dw     #_spr_playership_0    ;; sprite (2b)
      .dw     #0x0000
m_enemy_on_lane::
        .ds 1

.area _CODE
;;;;;;;;;;;;;;;;;;;;;
;; PRIVATE FUNCTION;;
;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;
;; WAIT
;;
_wait:
    ;; loop
      wait_init_for:
         ;; compare A with 0 and two halts
            cp       #0                   
            jr       z, wait_end_for      
            ld       b, #2
            call     cpct_waitHalts_asm

         ;; save a
            push     af
         ;; wait sync
            call     cpct_waitVSYNC_asm
         
         ;; a-1
            pop      af
            sub      #1
         ;; go loop
            jr       wait_init_for
   ;; end for
      wait_end_for:
   ret
;;;;;;;;;;;;;;;;;;;;;
;; PUBLIC FUNCTION ;;
;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;CREATE TEMPLATE
;;
man_game_create_template_entity::
   push hl
   ;; create entity
        call _man_entity_create
    
        ;; load entity from stack
        pop hl
        push de
        ld bc,#SPACE_4_ONE_ENTITY
        call cpct_memcpy_asm
        pop de
   ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;CREATE ENEMY
;;
man_game_create_enemy::
   ;; save in c -> x of mothership
   ld hl, #X
   add hl, de
   ld c, (hl)
   ;; save in b -> vx of mothership
   ld hl, #VX
   add hl, de
   ld b, (hl)
   ;; save bc
   push bc
   ;; save in a varibale que indica si hay o no enemigo en linea
   ld a, (m_enemy_on_lane)
   cp #0
   ;; compruebo los enemigos que hay en línea (if menemyonlane == 0) creoenemy;
   jr z, create_enemy
   jr man_game_create_enemy_end
   ;; Create new enemy and set x and vx
   create_enemy:
         ;; create enemy
        ld       hl, #enemy1_template_e
        call man_game_create_template_entity
        ;; retrieve bc
        pop bc
        ;; load in a, x of mothership , plus 4 and load in enemy->x
        ld a, c
        add #4
        ld hl, #X
        add hl, de
        ld (hl), a
        ;; load in a, vx of mothership and load in enemy->x
        ld a, b
        ld hl, #VX
        add hl, de
        ld (hl), a
        ;; put variable menemyonlane as 1
        ld a, #0x01
        ld (m_enemy_on_lane), a

   man_game_create_enemy_end:
   pop bc
ret
;;;;;;;;;;;;;;;;;;;;
;; INIT
;;
man_game_init::
    ;; configure videomode, palet y border
        call     _sys_render_init

    ;; inicialize manager entity
        call     _man_entity_init

   ;; no enemies on lane on start
       ld a, #0
       ld (m_enemy_on_lane), a
    ;; Create mothership
        ld       hl, #mothership_template_e
        call man_game_create_template_entity
        ld    hl, #X
        add   hl, de
        ld    (hl), #38
        ld    hl, #VX
        add   hl, de
        ld    (hl), #1

    ;; creamos playership en x = 0
       ld       hl, #playership_template1_e
        call man_game_create_template_entity
   ;; cambiamos a la posición x = 10
         ld    hl, #X
         add   hl, de
         ld    (hl), #10
   ;; creamos playership1
       ld       hl, #playership_template1_e
        call man_game_create_template_entity
   ;; cambiamos a la posición x = 20
         ld    hl, #X
         add   hl, de
         ld    (hl), #20
   ;; Create playership 1
       ld       hl, #playership_template1_e
      call man_game_create_template_entity
   ;; Creamos player
   ld       hl, #playership_template0_e
   call man_game_create_template_entity
ret
;;;;;;;;;;;;;;;;;;;;;;
;; PLAY
;;

man_game_play::
   ;; infinite loop
   loop:
      ;; call ai manager
         call      _sys_ai_update
      ;; update positions
         call     _sys_physics_update
      
      ;; render
         call     _sys_render_update
      ;; update manager
         call     _man_entity_update
      ;; wait ( se mueve cada cinco fotogramas)
         ld       a, #5
		 call     _wait
      ;; jump to loop
         jr       loop
ret
