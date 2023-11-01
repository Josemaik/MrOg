.module Level_Manager

.include "cpctelera.h.s"
.include "level.h.s"
.include "entity.h.s"

mapa_actual::
    .db 0x00

consumibles_actuales::
    .db 0x00

.area _DATA
.area _CODE

;;;;;;;;;;;;;;;;;;;;;;
;; Cambio de mapa
;;
cambio_de_mapa::
    ;; guardar puntuacion
    call save_points
    ;; stop music
    call cpct_akp_stop_asm

    ;; borramos todas las entidades
    call _man_entity_init
    ;; creamos jugador
    call _inicialize_templates
    

    ;; Comprobar que mapa cargamos
    ld      a, (mapa_actual)
    dec     a
    jr      z, mapa_2
    dec     a
    jr      z, mapa_3
    dec     a
    jr      z, mapa_4
    dec     a
    jr      z, mapa_5
    dec     a
    jr      z, mapa_bonus
    dec     a
    jr      z, mapa_6
    dec     a
    jr      z, mapa_7
    dec     a
    jr      z, mapa_8
    dec     a
    jr      z, mapa_9
    dec     a
    jr      z, mapa_10
    ;dec     a
    ;jr      z, gotomenu

    ret

    mapa_2:
        call set_level_screen
        call cargar_mapa_2
        ;; play music
        call cpct_akp_musicPlay_asm
        ;; reseteamos hud
        call reset_hud
    ret

    mapa_3:
        call set_level_screen
        call cargar_mapa_3
        ;; play music
        call cpct_akp_musicPlay_asm
        ;; reseteamos hud
        call reset_hud
    ret

    mapa_4:
        call set_level_screen
        call cargar_mapa_4
        ;; play music
        call cpct_akp_musicPlay_asm
        ;; reseteamos hud
        call reset_hud
    ret

    mapa_5:
        call set_level_screen
        call cargar_mapa_5
        ;; play music
        call cpct_akp_musicPlay_asm
        ;; reseteamos hud
        call reset_hud
    ret

    mapa_bonus:
        call set_level_screen
        call cargar_mapa_bonus
        ;; play music
        call cpct_akp_musicPlay_asm
        ;; reseteamos hud
        call reset_hud
    ret

    mapa_6:
        call set_level_screen
        call cargar_mapa_6
        ;; play music
        call cpct_akp_musicPlay_asm
        ;; reseteamos hud
        call reset_hud
    ret

    mapa_7:
        call set_level_screen
        call cargar_mapa_7
        ;; play music
        call cpct_akp_musicPlay_asm
        ;; reseteamos hud
        call reset_hud
    ret

    mapa_8:
        call set_level_screen
        call cargar_mapa_8
        ;; play music
        call cpct_akp_musicPlay_asm
        ;; reseteamos hud
        call reset_hud
    ret

    mapa_9:
        call set_level_screen
        call cargar_mapa_9
        ;; play music
        call cpct_akp_musicPlay_asm
        ;; reseteamos hud
        call reset_hud
    ret

    mapa_10:
        call set_level_screen
        call cargar_mapa_10
        ;; play music
        call cpct_akp_musicPlay_asm
        ;; reseteamos hud
        call reset_hud
    ret

    gotomenu:
        ld a, #3
        ld (lifes_available), a
        call reset_hud
        call reset_vidas_hud
        ld bc, #_main
        push bc 
    ret
    
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Creacion de los mapas
;;
cargar_mapa_1::

    ;; Guardamos en mapa_actual el mapa en el que estamos
    ld      a, #1
    ld      (mapa_actual), a

    ;; Borrar entidades (menos el player, en el caso de borrarlo crearlo de nuevo, el primero)

    ;; Dibujar el tilemap
    ld    a, #0
    ld    (tilemap_position), a
    ld   de, #_tilemap_01 
    add_de_a
    call sys_render_tilemap

    ;; Reposicionar el player
    ld     ix, #m_entities
    ld  X(ix), #12
    ld  Y(ix), #112
    ;; Guardar la posicion inicial del jugador
    ld     ix, #position_initial_player
    ld  0(ix), #12
    ld  1(ix), #112

    ;; Crear enemigos y objetos
    call crear_enemigos_mapa_1
    call crear_objetos_mapa_1
    call set_burro_animations
    ;; Guardamos en helados_actuales los helados para recoger
    ld      a, #3
    ld      (consumibles_actuales), a
    ;  ld a, #3
    ; ld      (lifes_available), a
    ld a, #0
    ld (stop_score),a

ret
cargar_mapa_2::

    ;; Guardamos en mapa_actual el mapa en el que estamos
    ld      a, #2
    ld      (mapa_actual), a

    ;; Borrar entidades (menos el player, en el caso de borrarlo crearlo de nuevo, el primero)

    ;; Redibujar el nuevo tilemap
    ld    a, #20
    ld    (tilemap_position), a
    ld   de, #_tilemap_01 
    add_de_a
    call sys_render_tilemap

    ;; Reposicionar el player
    ld     ix, #m_entities
    ld  X(ix), #4
    ld  Y(ix), #88
    ;; Guardar la posicion inicial del jugador
    ld     ix, #position_initial_player
    ld  0(ix), #4
    ld  1(ix), #88

    ;; Crear enemigos y objetos
    call crear_enemigos_mapa_2
    call crear_objetos_mapa_2
    call set_burro_animations

    ;; Guardamos en helados_actuales los helados para recoger
    ld      a, #3
    ld      (consumibles_actuales), a
    ;  ld a, #3
    ; ld      (lifes_available), a
    ld a, #0
    ld (stop_score),a

ret
cargar_mapa_3::

    ;; Guardamos en mapa_actual el mapa en el que estamos
    ld      a, #3
    ld      (mapa_actual), a

    ;; Borrar entidades (menos el player, en el caso de borrarlo crearlo de nuevo, el primero)

    ;; Dibujar el tilemap
    ld    hl, #0x00
    ld    (tilemap_position), hl
    ld   de, #_tilemap_01 + 1200
    ;add_de_hl
    call sys_render_tilemap

    ;; Reposicionar el player
    ld     ix, #m_entities
    ld  X(ix), #8
    ld  Y(ix), #40
    ;; Guardar la posicion inicial del jugador
    ld     ix, #position_initial_player
    ld  0(ix), #8
    ld  1(ix), #40

    ;; Crear enemigos y objetos
    call crear_enemigos_mapa_3
    call crear_objetos_mapa_3
    call set_burro_animations
    ;; Guardamos en helados_actuales los helados para recoger
    ld      a, #3
    ld      (consumibles_actuales), a
    ;  ld a, #3
    ; ld      (lifes_available), a
    ld a, #0
    ld (stop_score),a

ret
cargar_mapa_4::

    ;; Guardamos en mapa_actual el mapa en el que estamos
    ld      a, #4
    ld      (mapa_actual), a

    ;; Borrar entidades (menos el player, en el caso de borrarlo crearlo de nuevo, el primero)

    ;; Dibujar el tilemap
    ld    hl, #20
    ld    (tilemap_position), hl
    ld   de, #_tilemap_01 + 1220
    ;add_de_hl
    call sys_render_tilemap

    ;; Reposicionar el player
    ld     ix, #m_entities
    ld  X(ix), #40
    ld  Y(ix), #32
    ;; Guardar la posicion inicial del jugador
    ld     ix, #position_initial_player
    ld  0(ix), #40
    ld  1(ix), #32

    ;; Crear enemigos y objetos
    call crear_enemigos_mapa_4
    call crear_objetos_mapa_4
    call set_burro_animations
    ;; Guardamos en helados_actuales los helados para recoger
    ld      a, #3
    ld      (consumibles_actuales), a
    ; ld a, #3
    ; ld      (lifes_available), a
    ld a, #0
    ld (stop_score),a

ret
cargar_mapa_5::

    ;; Guardamos en mapa_actual el mapa en el que estamos
    ld      a, #5
    ld      (mapa_actual), a

    ;; Borrar entidades (menos el player, en el caso de borrarlo crearlo de nuevo, el primero)

    ;; Dibujar el tilemap
    ld    hl, #0
    ld    (tilemap_position), hl
    ld   de, #_tilemap_01 + 2400
    ;add_de_hl
    call sys_render_tilemap

    ;; Reposicionar el player
    ld     ix, #m_entities
    ld  X(ix), #36
    ld  Y(ix), #104
    ;; Guardar la posicion inicial del jugador
    ld     ix, #position_initial_player
    ld  0(ix), #36
    ld  1(ix), #104

    ;; Crear enemigos y objetos
    call crear_enemigos_mapa_5
    call crear_objetos_mapa_5
    call set_burro_animations
    ;; Guardamos en helados_actuales los helados para recoger
    ld      a, #3
    ld      (consumibles_actuales), a
    ;  ld a, #3
    ; ld      (lifes_available), a
    ld a, #0
    ld (stop_score),a 

ret

cargar_mapa_bonus::

    ;; Guardamos en mapa_actual el mapa en el que estamos
    ld      a, #6
    ld      (mapa_actual), a

    ;; Borrar entidades (menos el player, en el caso de borrarlo crearlo de nuevo, el primero)

    ;; Dibujar el tilemap
    ld    hl, #20
    ld    (tilemap_position), hl
    ld   de, #_tilemap_01 + 2420
    ;add_de_hl
    call sys_render_tilemap

    ;; Reposicionar el player
    ld     ix, #m_entities
    ld  X(ix), #44
    ld  Y(ix), #40
    ;; Guardar la posicion inicial del jugador
    ld     ix, #position_initial_player
    ld  0(ix), #44
    ld  1(ix), #40

    ;; Crear enemigos y objetos
    call crear_enemigos_mapa_bonus
    call crear_objetos_mapa_bonus
    call set_burro_animations
    ;; Guardamos en helados_actuales los helados para recoger
    ld      a, #1
    ld      (consumibles_actuales), a
    ;  ld a, #3
    ; ld      (lifes_available), a
     ld a, #0
    ld (stop_score),a

ret

cargar_mapa_6::
    ;; Guardamos en mapa_actual el mapa en el que estamos
    ld      a, #7
    ld      (mapa_actual), a

    ;; Borrar entidades (menos el player, en el caso de borrarlo crearlo de nuevo, el primero)

    ;; Dibujar el tilemap
    ld    hl, #0
    ld    (tilemap_position), hl
    ld   de, #_tilemap_01 + 3600
    ;add_de_hl
    call sys_render_tilemap

    ;; Reposicionar el player
    ld     ix, #m_entities
    ld  X(ix), #36
    ld  Y(ix), #40
    ;; Guardar la posicion inicial del jugador
    ld     ix, #position_initial_player
    ld  0(ix), #36
    ld  1(ix), #40

    ;; Crear enemigos y objetos
    call crear_enemigos_mapa_6
    call crear_objetos_mapa_6
    call set_lord_animations
    ;; Guardamos en helados_actuales los helados para recoger
    ld      a, #3
    ld      (consumibles_actuales), a
    ;  ld a, #3
    ; ld      (lifes_available), a
     ld a, #0
    ld (stop_score),a
ret

cargar_mapa_7::
    ;; Guardamos en mapa_actual el mapa en el que estamos
    ld      a, #8
    ld      (mapa_actual), a

    ;; Borrar entidades (menos el player, en el caso de borrarlo crearlo de nuevo, el primero)

    ;; Dibujar el tilemap
    ld    hl, #20
    ld    (tilemap_position), hl
    ld   de, #_tilemap_01 + 3620
    ;add_de_hl
    call sys_render_tilemap

    ;; Reposicionar el player
    ld     ix, #m_entities
    ld  X(ix), #36
    ld  Y(ix), #40
    ;; Guardar la posicion inicial del jugador
    ld     ix, #position_initial_player
    ld  0(ix), #36
    ld  1(ix), #40

    ;; Crear enemigos y objetos
    call crear_enemigos_mapa_7
    call crear_objetos_mapa_7
    call set_lord_animations
    ;; Guardamos en helados_actuales los helados para recoger
    ld      a, #3
    ld      (consumibles_actuales), a
    ;  ld a, #3
    ; ld      (lifes_available), a
     ld a, #0
    ld (stop_score),a
ret

cargar_mapa_8::
    ;; Guardamos en mapa_actual el mapa en el que estamos
    ld      a, #9
    ld      (mapa_actual), a

    ;; Borrar entidades (menos el player, en el caso de borrarlo crearlo de nuevo, el primero)

    ;; Dibujar el tilemap
    ld    hl, #0
    ld    (tilemap_position), hl
    ld   de, #_tilemap_01 + 4800
    ;add_de_hl
    call sys_render_tilemap

    ;; Reposicionar el player
    ld     ix, #m_entities
    ld  X(ix), #8
    ld  Y(ix), #40
    ;; Guardar la posicion inicial del jugador
    ld     ix, #position_initial_player
    ld  0(ix), #8
    ld  1(ix), #40

    ;; Crear enemigos y objetos
    call crear_enemigos_mapa_8
    call crear_objetos_mapa_8
    call set_lord_animations
    ;; Guardamos en helados_actuales los helados para recoger
    ld      a, #3
    ld      (consumibles_actuales), a
    ;  ld a, #3
    ; ld      (lifes_available), a
     ld a, #0
    ld (stop_score),a

ret

cargar_mapa_9::

    ;; Guardamos en mapa_actual el mapa en el que estamos
    ld      a, #10
    ld      (mapa_actual), a

    ;; Borrar entidades (menos el player, en el caso de borrarlo crearlo de nuevo, el primero)

    ;; Dibujar el tilemap
    ld    hl, #20
    ld    (tilemap_position), hl
    ld   de, #_tilemap_01 + 4820
    ;add_de_hl
    call sys_render_tilemap

    ;; Reposicionar el player
    ld     ix, #m_entities
    ld  X(ix), #8
    ld  Y(ix), #168
    ;; Guardar la posicion inicial del jugador
    ld     ix, #position_initial_player
    ld  0(ix), #8
    ld  1(ix), #168

    ;; Crear enemigos y objetos
    call crear_enemigos_mapa_9
    call crear_objetos_mapa_9
    call set_lord_animations
    ;; Guardamos en helados_actuales los helados para recoger
    ld      a, #3
    ld      (consumibles_actuales), a
    ;  ld a, #3
    ; ld      (lifes_available), a
     ld a, #0
    ld (stop_score),a

ret

cargar_mapa_10::

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Creacion de los enemigos
;; 
crear_enemigos_mapa_1:
    ld ix, #flobier_entity
    ld    X(ix), #68
    ld    Y(ix), #80
    ld       hl, #flobier_entity
    call man_game_create_template_entity
ret

crear_enemigos_mapa_2:
    ld ix, #flobier_entity
    ld    X(ix), #68
    ld    Y(ix), #104
    ld       hl, #flobier_entity
    call man_game_create_template_entity
ret
crear_enemigos_mapa_3:
    ld ix, #flobier_entity2
    ld    X(ix), #56
    ld    Y(ix), #129
    ld       hl, #flobier_entity2
    call man_game_create_template_entity
ret
crear_enemigos_mapa_4:
    ld ix, #flobier_entity_patron
    ld    X(ix), #41
    ld    Y(ix), #56
    ld       hl, #flobier_entity_patron
    call man_game_create_template_entity
ret
crear_enemigos_mapa_5:
    ld ix, #flobier_entity
    ld    X(ix), #68
    ld    Y(ix), #72
    ld       hl, #flobier_entity
    call man_game_create_template_entity
ret

crear_enemigos_mapa_bonus:

ret

crear_enemigos_mapa_6:

ret

crear_enemigos_mapa_7:

ret

crear_enemigos_mapa_8:

ret

crear_enemigos_mapa_9:

ret

crear_enemigos_mapa_10:

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Creacion de los objetos
;;
;;;;;;;;;;;;;;;; Mundo 1 ;;;;;;;;;;;;;;;;
crear_objetos_mapa_1:
   ;;;;;;;;;;;;;
   ;; Helados ;;
   ;;;;;;;;;;;;;

   ld       ix, #helado_entity

   ld    X(ix), #4
   ld    Y(ix), #56
   ld       hl, #helado_entity
   call man_game_create_template_entity
   
   ld    Y(ix), #144
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ld    X(ix), #68
   ld    Y(ix), #56
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;
   ;; Llaves ;;
   ;;;;;;;;;;;;

   ld       ix, #llave_entity

   ld    X(ix), #68
   ld    Y(ix), #104
   ld       hl, #llave_entity
   call man_game_create_template_entity

   ld    X(ix), #32
   ld    Y(ix), #152
   ld       hl, #llave_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Puertas Horizontales ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;

   ld       ix, #puerta_horizontal_entity

   ld    X(ix), #16
   ld    Y(ix), #48
   ld    direction(ix), #DIRECT_S
   ld       hl, #puerta_horizontal_entity
   call man_game_create_template_entity

   ld    X(ix), #56
   ld       hl, #puerta_horizontal_entity
   call man_game_create_template_entity


ret
crear_objetos_mapa_2:
   ;;;;;;;;;;;;;
   ;; Helados ;;
   ;;;;;;;;;;;;;

   ld       ix, #helado_entity

   ld    X(ix), #20
   ld    Y(ix), #32
   ld       hl, #helado_entity
   call man_game_create_template_entity
   
   ld       ix, #helado_entity
   ld    X(ix), #36
   ld    Y(ix), #176
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ld    X(ix), #52
   ld    Y(ix), #80
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;
   ;; Llaves ;;
   ;;;;;;;;;;;;

   ld       ix, #llave_entity

   ld    X(ix), #52
   ld    Y(ix), #56
   ld       hl, #llave_entity
   call man_game_create_template_entity

   ld    X(ix), #68
   ld    Y(ix), #152
   ld       hl, #llave_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Puertas Horizontales ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;

   ld       ix, #puerta_horizontal_entity

   ld    X(ix), #20
   ld    Y(ix), #120
   ld    direction(ix), #DIRECT_S
   ld       hl, #puerta_horizontal_entity
   call man_game_create_template_entity

   ld    X(ix), #68
   ld    Y(ix), #96
   ld       hl, #puerta_horizontal_entity
   call man_game_create_template_entity

ret
crear_objetos_mapa_3:

   ;;;;;;;;;;;;;
   ;; Helados ;;
   ;;;;;;;;;;;;;

   ld       ix, #helado_entity

   ld    X(ix), #68
   ld    Y(ix), #48
   ld       hl, #helado_entity
   call man_game_create_template_entity
   
   ld       ix, #helado_entity
   ld    X(ix), #32
   ld    Y(ix), #176
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ld    X(ix), #52
   ld    Y(ix), #152
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;
   ;; Llaves ;;
   ;;;;;;;;;;;;

   ld       ix, #llave_entity

   ld    X(ix), #36
   ld    Y(ix), #56
   ld       hl, #llave_entity
   call man_game_create_template_entity

   ld    X(ix), #16
   ld    Y(ix), #128
   ld       hl, #llave_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Puertas Horizontales ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;

   ld       ix, #puerta_horizontal_entity

   ld    X(ix), #52
   ld    Y(ix), #168
   ld    direction(ix), #DIRECT_S
   ld       hl, #puerta_horizontal_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Puertas Verticales ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;

   ld       ix, #puerta_vertical_entity

   ld    X(ix), #40
   ld    Y(ix), #176
   ld    direction(ix), #DIRECT_D
   ld       hl, #puerta_vertical_entity
   call man_game_create_template_entity

ret
crear_objetos_mapa_4:

   ;;;;;;;;;;;;;
   ;; Helados ;;
   ;;;;;;;;;;;;;

   ld       ix, #helado_entity

   ld    X(ix), #56
   ld    Y(ix), #80
   ld       hl, #helado_entity
   call man_game_create_template_entity
   
   ld       ix, #helado_entity
   ld    X(ix), #28
   ld    Y(ix), #176
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ld    X(ix), #56
   ld    Y(ix), #152
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;
   ;; Llaves ;;
   ;;;;;;;;;;;;

   ld       ix, #llave_entity

   ld    X(ix), #28
   ld    Y(ix), #80
   ld       hl, #llave_entity
   call man_game_create_template_entity

   ld    X(ix), #16
   ld    Y(ix), #120
   ld       hl, #llave_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Puertas Horizontales ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;

   ld       ix, #puerta_horizontal_entity

   ld    X(ix), #40
   ld    Y(ix), #120
   ld    direction(ix), #DIRECT_S
   ld       hl, #puerta_horizontal_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Puertas Verticales ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;

   ld       ix, #puerta_vertical_entity

   ld    X(ix), #36
   ld    Y(ix), #152
   ld    direction(ix), #DIRECT_A
   ld       hl, #puerta_vertical_entity
   call man_game_create_template_entity

ret
crear_objetos_mapa_5:

   ;;;;;;;;;;;;;
   ;; Helados ;;
   ;;;;;;;;;;;;;

   ld       ix, #helado_entity

   ld    X(ix), #68
   ld    Y(ix), #176
   ld       hl, #helado_entity
   call man_game_create_template_entity
   
   ld       ix, #helado_entity
   ld    X(ix), #28
   ld    Y(ix), #160
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ld    X(ix), #52
   ld    Y(ix), #128
   ld       hl, #helado_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;
   ;; Llaves ;;
   ;;;;;;;;;;;;

   ld       ix, #llave_entity

   ld    X(ix), #4
   ld    Y(ix), #32
   ld       hl, #llave_entity
   call man_game_create_template_entity

   ld    X(ix), #68
   ld       hl, #llave_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Puertas Horizontales ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;

   ld       ix, #puerta_horizontal_entity

   ld    X(ix), #68
   ld    Y(ix), #168
   ld    direction(ix), #DIRECT_W
   ld       hl, #puerta_horizontal_entity
   call man_game_create_template_entity

   ;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Puertas Verticales ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;

   ld       ix, #puerta_vertical_entity

   ld    X(ix), #60
   ld    Y(ix), #128
   ld    direction(ix), #DIRECT_D
   ld       hl, #puerta_vertical_entity
   call man_game_create_template_entity

ret
crear_objetos_mapa_bonus:

    ;;;;;;;;;;;;;
    ;; AMSTRAD ;;
    ;;;;;;;;;;;;;

    ld       ix, #amstrad_entity

    ld    X(ix), #44
    ld    Y(ix), #104
    ld       hl, #amstrad_entity
    call man_game_create_template_entity

    ;;;;;;;;;;;;
    ;; Llaves ;;
    ;;;;;;;;;;;;

    ld       ix, #llave_entity

    ld    X(ix), #4
    ld    Y(ix), #32
    ld       hl, #llave_entity
    call man_game_create_template_entity

    ld    Y(ix), #56
    ld       hl, #llave_entity
    call man_game_create_template_entity

    ld    X(ix), #48
    ld    Y(ix), #168
    ld       hl, #llave_entity
    call man_game_create_template_entity

    ;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Puertas Verticales ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;

    ld       ix, #puerta_vertical_entity

    ld    X(ix), #32
    ld    Y(ix), #104
    ld    direction(ix), #DIRECT_A
    ld       hl, #puerta_vertical_entity
    call man_game_create_template_entity

    ld    X(ix), #36
    ld    direction(ix), #DIRECT_A
    ld       hl, #puerta_vertical_entity
    call man_game_create_template_entity

    ld    X(ix), #40
    ld    direction(ix), #DIRECT_A
    ld       hl, #puerta_vertical_entity
    call man_game_create_template_entity


ret
;;;;;;;;;;;;;;;; Mundo 2 ;;;;;;;;;;;;;;;;
crear_objetos_mapa_6::
    ;;;;;;;;;;;;;;;
    ;; Chocolate ;;
    ;;;;;;;;;;;;;;;

    ld       ix, #chocolate_entity

    ld    X(ix), #4
    ld    Y(ix), #32
    ld       hl, #chocolate_entity
    call man_game_create_template_entity
    
    ld    X(ix), #68
    ld       hl, #chocolate_entity
    call man_game_create_template_entity

    ld    X(ix), #4
    ld    Y(ix), #176
    ld       hl, #chocolate_entity
    call man_game_create_template_entity

    ;;;;;;;;;;;;
    ;; Llaves ;;
    ;;;;;;;;;;;;

    ld       ix, #llave_entity

    ld    X(ix), #28
    ld    Y(ix), #128
    ld       hl, #llave_entity
    call man_game_create_template_entity

    ld    X(ix), #68
    ld       hl, #llave_entity
    call man_game_create_template_entity

    ;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Puertas Verticales ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;

    ld       ix, #puerta_vertical_entity

    ld    X(ix), #12
    ld    Y(ix), #32
    ld    direction(ix), #DIRECT_D
    ld       hl, #puerta_vertical_entity
    call man_game_create_template_entity

    ld    X(ix), #64
    ld    direction(ix), #DIRECT_A
    ld       hl, #puerta_vertical_entity
    call man_game_create_template_entity
ret
crear_objetos_mapa_7::
    ;;;;;;;;;;;;;;;
    ;; Chocolate ;;
    ;;;;;;;;;;;;;;;

    ld       ix, #chocolate_entity

    ld    X(ix), #68
    ld    Y(ix), #32
    ld       hl, #chocolate_entity
    call man_game_create_template_entity
    
    ld    X(ix), #44
    ld    Y(ix), #152
    ld       hl, #chocolate_entity
    call man_game_create_template_entity

    ld    X(ix), #16
    ld    Y(ix), #120
    ld       hl, #chocolate_entity
    call man_game_create_template_entity

    ;;;;;;;;;;;;
    ;; Llaves ;;
    ;;;;;;;;;;;;

    ld       ix, #llave_entity

    ld    X(ix), #68
    ld    Y(ix), #112
    ld       hl, #llave_entity
    call man_game_create_template_entity

    ld    Y(ix), #56
    ld       hl, #llave_entity
    call man_game_create_template_entity

    ;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Puertas Verticales ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;

    ld       ix, #puerta_vertical_entity

    ld    X(ix), #64
    ld    Y(ix), #32
    ld    direction(ix), #DIRECT_A
    ld       hl, #puerta_vertical_entity
    call man_game_create_template_entity

    ;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Puertas Horizontales ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;

    ld       ix, #puerta_horizontal_entity

    ld    X(ix), #44
    ld    Y(ix), #144
    ld    direction(ix), #DIRECT_W
    ld       hl, #puerta_horizontal_entity
    call man_game_create_template_entity
ret

crear_objetos_mapa_8::
    ;;;;;;;;;;;;;;;
    ;; Chocolate ;;
    ;;;;;;;;;;;;;;;

    ld       ix, #chocolate_entity

    ld    X(ix), #68
    ld    Y(ix), #64
    ld       hl, #chocolate_entity
    call man_game_create_template_entity
    
    ld    X(ix), #56
    ld    Y(ix), #64
    ld       hl, #chocolate_entity
    call man_game_create_template_entity

    ld    X(ix), #8
    ld    Y(ix), #120
    ld       hl, #chocolate_entity
    call man_game_create_template_entity

    ;;;;;;;;;;;;
    ;; Llaves ;;
    ;;;;;;;;;;;;

    ld       ix, #llave_entity

    ld    X(ix), #68
    ld    Y(ix), #136
    ld       hl, #llave_entity
    call man_game_create_template_entity

    ld    Y(ix), #176
    ld       hl, #llave_entity
    call man_game_create_template_entity

    ;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Puertas Horizontales ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;

    ld       ix, #puerta_horizontal_entity

    ld    X(ix), #68
    ld    Y(ix), #56
    ld    direction(ix), #DIRECT_W
    ld       hl, #puerta_horizontal_entity
    call man_game_create_template_entity

    ld    X(ix), #56
    ld    Y(ix), #88
    ld    direction(ix), #DIRECT_S
    ld       hl, #puerta_horizontal_entity
    call man_game_create_template_entity

ret

crear_objetos_mapa_9::
    ;;;;;;;;;;;;;;;
    ;; Chocolate ;;
    ;;;;;;;;;;;;;;;

    ld       ix, #chocolate_entity

    ld    X(ix), #4
    ld    Y(ix), #32
    ld       hl, #chocolate_entity
    call man_game_create_template_entity
    
    ld    X(ix), #44
    ld    Y(ix), #112
    ld       hl, #chocolate_entity
    call man_game_create_template_entity

    ld    X(ix), #68
    ld    Y(ix), #176
    ld       hl, #chocolate_entity
    call man_game_create_template_entity

    ;;;;;;;;;;;;
    ;; Llaves ;;
    ;;;;;;;;;;;;

    ld       ix, #llave_entity

    ld    X(ix), #68
    ld    Y(ix), #80
    ld       hl, #llave_entity
    call man_game_create_template_entity

    ld    X(ix), #28
    ld    Y(ix), #48
    ld       hl, #llave_entity
    call man_game_create_template_entity

    ;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Puertas Horizontales ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;

    ld       ix, #puerta_horizontal_entity

    ld    X(ix), #68
    ld    Y(ix), #168
    ld    direction(ix), #DIRECT_W
    ld       hl, #puerta_horizontal_entity
    call man_game_create_template_entity

    ld    X(ix), #44
    ld    Y(ix), #128
    ld    direction(ix), #DIRECT_S
    ld       hl, #puerta_horizontal_entity
    call man_game_create_template_entity
ret

crear_objetos_mapa_10::

ret