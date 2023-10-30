.module Game_Manager

.include "cpctelera.h.s"
.include "game.h.s"
.include "entity.h.s"
.area _DATA
lifes_available::
   .db 0x04 ;; 3 vidas
player_state:: ;; 0 -> vivo 1 -> muerto
   .db 0x00
time_anim_died:: ;; tiempo animacion muerte
   .db 0xaa
food_state:: ;;0-> viva 1-> muerta
   .db 0x00
time_anim_eat:: ;; tiempo animacion comer
   .db 0x1e
position_initial_player::
    .db 0x00
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
_inicialize_templates:
      ;; PLAYER
      ld       hl, #player_entity
      call man_game_create_template_entity
      
ret
player_reaparition::
    push ix
    ld__ix_de
    ;; dibujamos solidbox donde muere personaje
    call sys_render_draw_solid_box_player
    ;; ponemos sprite abajo
    ld bc, #_spr_spritesheet_00
    ld SPRITE(ix), c
    ld 1+SPRITE(ix), b
    ;; ponemos animacion abajo
    ld AnimCounter(ix), #0x0c
    ld bc, #anim_S
    ld AnimFrame(ix), c
    ld 1+AnimFrame(ix), b
    ;; | Reposicionar al player a la posicion inicial
    ld a, (position_initial_player)
    ld X(ix), a ;; 
    ld a, (position_initial_player + 1)
    ld Y(ix), a ;; 
    pop ix
    ;; vuelvo a poner contador a su tiempo original
    ld a, #0xaa
    ld (time_anim_died), a
ret

;;;;;;;;;;;;;;;;;;;;
;; INIT
;;
man_game_init::
    ;; Level Screen
      call man_levelscreen_init
      levelscreen_loop:
         call man_levelscreen_update
         jr    z, levelscreen_loop
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
    ;; cargar mapa
       call cargar_mapa_2

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
