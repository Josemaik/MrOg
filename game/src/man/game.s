.module Game_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.area _DATA

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
ret
;;;;;;;;;;;;;;;;;;;;;;
;; PLAY
;;

man_game_play::
   ;; infinite loop
   loop:
      ;; call ai manager
         ; call      _sys_ai_update
      ;; update positions
         call     _sys_physics_update
      ;; check collisions
         ; call     _sys_collision_update
      ;; call animations system
         call     _sys_animations_update
      ;; render
         call     _sys_render_update
      ;; update manager
         call     _man_entity_update
      ;; wait ( se mueve cada cinco fotogramas)
         ld       a, #4
		 call     _wait
         ; call cpct_waitVSYNC_asm
      ;; jump to loop
         jr       loop
ret
