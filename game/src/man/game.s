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

      call crear_objetos_mapa_prueba
      
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Creacion de los objetos
;;
crear_objetos_mapa_prueba:

   ;;;;;;;;;;;;;
   ;; Helados ;;
   ;;;;;;;;;;;;;

   ld       ix, #helado_entity

   ld    X(ix), #8
   ld    Y(ix), #32
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ;ld    Y(ix), #48
   ;ld       hl, #helado_entity
   ;call man_game_create_template_entity

   ;ld    Y(ix), #64
   ;ld       hl, #helado_entity
   ;call man_game_create_template_entity

   ;ld    Y(ix), #136
   ;ld       hl, #helado_entity
   ;call man_game_create_template_entity

   ; ld    Y(ix), #152
   ; ld       hl, #helado_entity
   ; call man_game_create_template_entity

   ld    Y(ix), #168
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Puertas Horizontales ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;

   ld       ix, #puerta_horizontal_entity

   ld    X(ix), #8
   ld    Y(ix), #80
   ld       hl, #puerta_horizontal_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Puertas Verticales ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;

   ld       ix, #puerta_vertical_entity

   ld    X(ix), #16
   ld    Y(ix), #112
   ld       hl, #puerta_vertical_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;
   ;; Llaves ;;
   ;;;;;;;;;;;;

   ld       ix, #llave_entity

   ld    X(ix), #56
   ld    Y(ix), #112
   ld       hl, #llave_entity
   call man_game_create_template_entity

   ld    X(ix), #20
   ld    Y(ix), #32
   ld       hl, #llave_entity
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
