.module Game_Manager
.include "game.h.s"

.area _DATA

.area _CODE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PUBLIC FUNCTIONS        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GAME INIT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_game_init::
    ;; configuramos modo de video, paleta y borde
      call     _sys_render_init
   ;; inicializamos manager de entidades
      call     _man_entity_init 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PLAY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_game_play::
;; Bucle infinito
   loop:
      ;; actualizamos posiciones
         call     _sys_physics_update
      ;; renderizamos
         call     _sys_render_update
      ;; actualizamos manager
         call     _man_entity_update
      ;; señal de sincronización
         call cpct_waitVSYNC_asm
      ;; saltamos a loop
         jr       loop