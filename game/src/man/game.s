.module Game_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.area _DATA
is_bomb_active:: ;; 0 no activo 1 activo
   .db 0x00
bombs_available::
   .db 0x03
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
   ;; resto 1 al numero de bombas disponibles
   ld a, (bombs_available)
   dec a
   ld (bombs_available), a
ret
set_xy_bomb::
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
      ;; PLAYER
        ld       hl, #player_entity
        call man_game_create_template_entity
        ;; DEFLATOR DENNIS
      ;   ld       hl, #deflator_Dennis_entity
      ;   call man_game_create_template_entity
      ;; FROBLIES
      ld       hl, #flobier_entity
      call man_game_create_template_entity
      ld       hl, #flobier_entity2
      call man_game_create_template_entity
      ; ld       hl, #flobier_entity_patron_mapa1
      ; call man_game_create_template_entity

      call crear_helados_mapa_prueba
      
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Creacion de los helados
;;
crear_helados_mapa_prueba:

   ld       ix, #helado_entity

   ld    X(ix), #8
   ld    Y(ix), #32
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ld    Y(ix), #48
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ld    Y(ix), #64
   ld       hl, #helado_entity
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
   ;; crear hud
      ; call create_HUD
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
         ;; call ai manager
         call      _sys_ai_update
      ;; render
         call     _sys_render_update

         ;; crear hud
      call create_HUD
      ;; update manager
         call     _man_entity_update


         call cpct_waitVSYNC_asm

      ;; jump to loop
         jr       loop
ret
