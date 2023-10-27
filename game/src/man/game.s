.module Game_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.area _DATA
is_bomb_active:: ;; 0 no activo 1 activo
   .db 0x00
bombs_available::
   .db 0x03
lifes_available::
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
   call quitar_bomba
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

   ld    Y(ix), #48
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ld    Y(ix), #64
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ld    Y(ix), #136
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ; ld    Y(ix), #152
   ; ld       hl, #helado_entity
   ; call man_game_create_template_entity

   ;ld    Y(ix), #168
   ;ld       hl, #helado_entity
   ;call man_game_create_template_entity

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

   ;ld       ix, #puerta_vertical_entity
;
   ;ld    X(ix), #16
   ;ld    Y(ix), #88
   ;ld       hl, #puerta_vertical_entity
   ;call man_game_create_template_entity

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
