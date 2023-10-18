.module Game_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.area _DATA

m_lane_status::
        .db 0x00
        .db 0x00
        .db 0x00
m_player_shot::
        .db 0x00

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
   ld hl, #m_lane_status
   ld bc, #LANE_0
   add hl, bc
   ld a, (hl)
   cp #0
   ;; compruebo los enemigos que hay en línea (if menemyonlane == 0) creoenemy;
   jr z, create_enemy
   jr man_retrieve_bc
   ;; Create new enemy and set x and vx
   create_enemy:
         ;; create enemy
        ld       hl, #enemy1_template_e
        call man_game_create_template_entity
        ;; retrieve bc
        pop bc
        ;; load in a, x of mothership , plus 4 and load in enemy->x
        ld a, c
        add a, #4
        ld hl, #X
        add hl, de
        ld (hl), a
        ;; load in a, vx of mothership and load in enemy->x
        ld a, b
        ld hl, #VX
        add hl, de
        ld (hl), a
        ;; put lane 0 as ocuped
        ld a, #0x01
        ld		hl, #m_lane_status
		  ld		bc, #LANE_0
		  add		hl, bc
		  ld		(hl), a

        jr man_game_create_enemy_end
   man_retrieve_bc:
        pop bc
   man_game_create_enemy_end:
ret
man_game_enemy_lane_down::
   ;; only can go down if lane is 1 or 2
   ld hl, #Y
   add hl, de
   ld a, #LANE1_Y
   cp (hl) ;; e->y - LANE1Y
   jr c, man_game_enemy_lane_down_end ;; lane = 0
      ;;lane = 1
      ;; save in c that we are in lane 1
      ; ld c, #1 ;; enemy is on lane 1
      ; ld b, #0
      ld a, #LANE0_Y
      or a ;; clear carry flag
      ld c,#1
      cp (hl) ;; e->y - LANE2_Y
      jr c, man_game_go_down ;; lane = 1
      ld c,#0
      man_game_go_down:
         ;; save in stack lane = 1
         ld b,#0
         inc c ;; (1+1 = 2)
         push bc ;; 0002
         ;;m_lane_status[lane+1] = m_lane_status[2]
         ld h, #0
         ld l, c ;; 1
         ld bc, #m_lane_status
         add hl, bc ;; 1 + bc (lane 1)

         ld a, (hl) 
         pop bc
         cp #0 
         jr nz, man_game_enemy_lane_down_end ;; if!=0 (ocuped) -> end
         ;; if == 0 (is free) add distance

         push de
         push bc
         ;; create a phantom clone entity to erase trail
         call _man_entity_clone
         ld hl, #CMPs
         add hl, de
         ld (hl), #E_CMP_RENDER
         call _man_entity_set_for_destruction
         pop bc
         pop de
         ;; add de distance to entity->y
         ld hl, #Y
         add hl, de
         ld a, (hl)
         add #LANE_DY
         ld (hl), a
         ;; put lane 1 as ocuped
         ld hl, #m_lane_status
         add hl, bc
         ld (hl),#1 ;;put ocuped
         dec c ;; lane prev as free
         ld hl, #m_lane_status
         add hl, bc
         ld (hl),#0 ;; put free

man_game_enemy_lane_down_end:
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GAME ENTITY DESTROY
;; 
;;IN -> e_mother: Pointer to
man_game_entity_destroy::
   ;;if(disparo) mplayershot = 0
   ld hl,#TYPE
   add hl, de
   ld a, (hl)
   cp #E_TYPE_SHOT
   jr z, m_playershot_to0
      jr destroy_entity
   m_playershot_to0:
      ld a, #0
      ld (m_player_shot), a
   destroy_entity:
      call man_entity_destroy
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GAME PLAYER SHOT
;; 
;;IN -> e_mother: Pointer to
man_game_player_shot::
   ;;check if there is a shot already
   ld a,  (m_player_shot)
   cp #0
   jr z, create_shot
      jr man_game_player_shot_end
   create_shot:
   ;; save player pointer
   push de
   ld hl, #playershot_template_e
   call man_game_create_template_entity
   pop bc
   ;; e->player-> x + 2
   ld hl, #X
   add hl, bc
   ld a, (hl)
   add #2
   ld hl, #X
   add hl, de
   ld (hl), a

   ld a, #1
   ld (m_player_shot), a
man_game_player_shot_end:
ret
;;;;;;;;;;;;;;;;;;;;
;; INIT
;;
man_game_init::
    ;; configure videomode, palet y border
        call     _sys_render_init

    ;; inicialize manager entity
        call     _man_entity_init

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
   ld       hl, #player_entity
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
      ;; check collisions
         call     _sys_collision_update
      ;; call animations system
         call     _sys_animations_update
      ;; render
         call     _sys_render_update
      ;; update manager
         call     _man_entity_update
      ;; wait ( se mueve cada cinco fotogramas)
         ld       a, #5
		 call     _wait
         ; call cpct_waitVSYNC_asm
      ;; jump to loop
         jr       loop
ret
