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

    ret

    mapa_2:
    call cargar_mapa_2
    ret

    mapa_3:
    call cargar_mapa_3
    ret

    mapa_4:
    call cargar_mapa_4
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
    ld  X(ix), #8
    ld  Y(ix), #40
    ;; Guardar la posicion inicial del jugador
    ld     ix, #position_initial_player
    ld  0(ix), #8
    ld  1(ix), #40

    ;; Crear enemigos y objetos
    call crear_enemigos_mapa_4
    call crear_objetos_mapa_4
    call set_burro_animations
    ;; Guardamos en helados_actuales los helados para recoger
    ld      a, #3
    ld      (consumibles_actuales), a

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

ret

crear_enemigos_mapa_4:

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Creacion de los objetos
;;
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

ret