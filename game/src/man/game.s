.module Game_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.area _DATA
is_bomb_active:: ;; 0 no activo 1 activo
   .db 0x00
.area _CODE

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
   check_bomb_state::
      ;; guardo en pila x e y player
        ld hl, #X
        add hl, de
        ld a, (hl)
        ld 4(ix), a
        ld hl, #Y
        add hl, de
        ld a, (hl)
        ld 5(ix), a
        ;; guardo en c la dirección
        ld hl, #direction
        add hl, de
        ld a, (hl)
        ld c, a
   ret
man_game_create_bomb::
   ld hl, #bomba_entity
   call man_game_create_template_entity
   ld a, #1
   ld (is_bomb_active) ,a
ret
set_xy_bomb::
   ld a , c
   and #DIRECT_W
   cp #DIRECT_W
   jr z, set_w
   ld a , c
   and #DIRECT_S
   cp #DIRECT_S
   jr z, set_s
   ld a , c
   and #DIRECT_A
   cp #DIRECT_A
   jr z, set_a
   ld a , c
   and #DIRECT_D
   cp #DIRECT_D
   jr z, set_d
   set_w:
      ld a , 5(ix)
      add #8
      ld 5(ix), a
      jr setxybomb
   set_a:
      ld a , 4(ix)
      add #8
      ld 4(ix), a
      jr setxybomb
   set_s:
      ld a , 5(ix)
      sub #8
      ld 5(ix), a
      jr setxybomb
   set_d:
      ld a , 4(ix)
      sub #8
      ld 4(ix), a
   setxybomb:
   ld hl, #X
   add hl, de
   ld a, 4(ix)
   ld (hl), a
   ld hl, #Y
   add hl, de
   ld a, 5(ix)
   ld (hl), a
ret
_inicialize_templates:
        ld       hl, #player_entity
        call man_game_create_template_entity
        ld       hl, #deflator_Dennis_entity
        call man_game_create_template_entity
ret
;;;;;;;;;;;;;;;;;;;;
;; INIT
;;
man_game_init::
    ;; configure videomode, palet y border
       call     _sys_render_init

    ;; inicialize manager entity
       call     _man_entity_init

    ;; Create player
       call    _inicialize_templates

    ;;music init
       ld de, #_song_prueba
       call cpct_akp_musicInit_asm
   ret
;;;;;;;;;;;;;;;;;;;;;;
;; PLAY
;;

man_game_play::
   
   ;; infinite loop
   loop:
      ;; call music player
         call     cpct_akp_musicPlay_asm
         ; call      _sys_ai_update
      ;; call input
         call     _sys_input_update
      ;; update positions
         call     _sys_physics_update
      ;; check collisions
         call     _sys_collision_update
      ;; call animations system
         call     _sys_animations_update
      ;; render
         call     _sys_render_update
      ;; call ai manager
         call      _sys_ai_update
      ;; update manager
         call     _man_entity_update


         call cpct_waitVSYNC_asm

      ;; jump to loop
         jr       loop
ret
