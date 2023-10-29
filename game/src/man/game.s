.module Game_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.area _DATA
lifes_available::
   .db 0x04 ;; 3 vidas
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
_inicialize_templates:
      ;; PLAYER
      ld       hl, #player_entity
      call man_game_create_template_entity
      
      call cargar_mapa_2
      
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
      ;; call input
         call     _sys_input_update
      ;; call collisions
         call     _sys_collision_update
      ;; call physics
         call     _sys_physics_update
      ;; call animations system
         call     _sys_animations_update
      ;; call ai manager
         call     _sys_ai_update
      ;; call render
         call     _sys_render_update

         ;; crear hud
      call create_HUD
      ;; update manager
         call     _man_entity_update


         call cpct_waitVSYNC_asm

      ;; jump to loop
         jr       loop
ret
