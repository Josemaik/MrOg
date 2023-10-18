.module Game_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.area _DATA
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
        ld       hl, #playership_template0_e
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

    ;; Create mothership
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
      ;; call ai manager
         ; call      _sys_ai_update
      ;; check collisions
         call     _sys_collision_update
      ;; call input
         call     _sys_input_update
      ;; update positions
         call     _sys_physics_update
      ;; call animations system
         call     _sys_animations_update
      ;; render
         call     _sys_render_update
      ;; update manager
         call     _man_entity_update

         call cpct_waitVSYNC_asm

      ;; jump to loop
         jr       loop
ret
