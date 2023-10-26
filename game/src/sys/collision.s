.module System_Collision

.include "collision.h.s"
.include "man/entity.h.s"
.include "cpctelera.h.s"


is_colliding_player:: ;; 0 no collision | 1 collision
    .db 0x00       ;; up
    .db 0x00       ;; down
    .db 0x00       ;; right
    .db 0x00       ;; left

colision_actual:
    .db 0x00


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Inicializar is_colliding_player
;;
inicializar_player_colision:

    ld      a, #0
    ld      (is_colliding_player), a
    ld      (is_colliding_player + 1), a
    ld      (is_colliding_player + 2), a
    ld      (is_colliding_player + 3), a

    ld    hl, #colision_actual
    ld  (hl), #0

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Check collisions player with tilemap
;;
comprobar_colision:
    ;; tx = x/4
    ;; ty = y/8
    ;; tw = tilemap-width (0x30, 48)
    ;; p  = tilemap + ty * tw + tx

    ;; A = y
    ld    a, Y(ix)

    ;; A = ty (y/8)
    and   #0xF8 ;; #0xb11111000 ;; A = 8*int(ty / 8)
    ;; HL = A (HL = 8*ty)
    ld    h, #0
    ld    l, a
    ;; HL = 48*HL
    add   hl, hl   ;; HL = 16*tx
    ld     d, h    ;; | DE = 16*tx
    ld     e, l    ;; |
    add   hl, hl   ;; HL = 32*tx
    add   hl, de   ;; HL = 48*tx

    ;; A = X
    ld    a, X(ix)
    srl    a ;; | A = tx (x/4)
    srl    a ;; |

    add_hl_a  ;; HL = ty * tw + tx
    ld     de, #_tilemap_01
    add    hl, de

    ;; HL = tilemap + ty * tw + tx
    ld      a, (hl)
    and    #0b11100000

    jr      z, que_colision

    ;; 11111110

    ;; 00000000
    ;; 00000001
    ;; 00000010 no colision

    jr final_colision

    ;; Comprobar con que colision estamos
    que_colision:

    ld      a, (colision_actual)
    dec     a
    jr      z, colision_player_up
    dec     a
    jr      z, colision_player_down
    dec     a
    jr      z, colision_player_right
    dec     a
    jr      z, colision_player_left

    jr final_colision

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de arriba (W) ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    colision_player_up:
        call sys_collision_player_tilemap_w
        jr final_colision

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de abajo (S) ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    colision_player_down:
        call sys_collision_player_tilemap_s
        jr final_colision

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de derecha (D) ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    colision_player_right:
        call sys_collision_player_tilemap_d
        jr final_colision

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de izquierda (A) ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    colision_player_left:
        call sys_collision_player_tilemap_a

    final_colision:

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Funciones para poner la velocidad y la posicion a 0
;;
sys_collision_player_tilemap_w:
    ld    hl, #is_colliding_player
    ld  (hl), #1

    ld VY(ix), #0

    ret
sys_collision_player_tilemap_s:
    ld    hl, #is_colliding_player + 1
    ld  (hl), #1

    ld VY(ix), #0

    ret

sys_collision_player_tilemap_d:
    ld    hl, #is_colliding_player + 2
    ld  (hl), #1

    ld VX(ix), #0

    ld  a, X(ix)
    dec a
    ld  X(ix), a

    ret

sys_collision_player_tilemap_a:
    ld    hl, #is_colliding_player + 3
    ld  (hl), #1
    
    ld VX(ix), #0

    ld  a, X(ix)
    inc a
    ld  X(ix), a

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Colisiones en las direcciones
;;
sys_collision_up:

    ld  a, direction(ix)
    cp  #DIRECT_W
    jr  z, colision_parte_arriba

    ret

    colision_parte_arriba:

    ld    hl, #colision_actual
    ld  (hl), #1

    ld    a, Y(ix)
    dec   a
    ld    Y(ix), a

    call comprobar_colision                ;; Upper-left

    ld    a, X(ix)
    add   a, #3
    ld    X(ix), a
    call comprobar_colision                ;; Upper-mid

    ld    a, X(ix)
    add   a, #4
    ld    X(ix), a
    call comprobar_colision                ;; Upper-right
    ld    a, X(ix)
    sub   a, #7
    ld    X(ix), a

    ld    a, Y(ix)
    inc   a
    ld    Y(ix), a

    ret

sys_collision_down:

    ld  a, direction(ix)
    cp  #DIRECT_S
    jr  z, colision_parte_abajo

    ret

    colision_parte_abajo:

    ld    hl, #colision_actual
    ld  (hl), #2

    ld    a, Y(ix)
    add   a, #16
    ld    Y(ix), a

    call comprobar_colision                ;; Down-left

    ld    a, X(ix)
    add   a, #3
    ld    X(ix), a
    call comprobar_colision                ;; Down-mid

    ld    a, X(ix)
    add   a, #4
    ld    X(ix), a
    call comprobar_colision                ;; Down-right
    ld    a, X(ix)
    sub   a, #7
    ld    X(ix), a

    ld    a, Y(ix)
    sub   a, #16
    ld    Y(ix), a

    ret

sys_collision_right:

    ld  a, direction(ix)
    cp  #DIRECT_D
    jr  z, colision_parte_derecha

    ret

    colision_parte_derecha:

    ld    hl, #colision_actual
    ld  (hl), #3

    ld    a, X(ix)
    add   a, #7
    ld    X(ix), a

    call comprobar_colision                ;; Right-up

    ld    a, Y(ix)
    add   a, #7
    ld    Y(ix), a
    call comprobar_colision                ;; Right-up

    ld    a, Y(ix)
    add   a, #8
    ld    Y(ix), a
    call comprobar_colision                ;; Right-down
    ld    a, Y(ix)
    sub   a, #15
    ld    Y(ix), a

    ld    a, X(ix)
    sub   a, #7
    ld    X(ix), a

    ret

sys_collision_left:

    ld  a, direction(ix)
    cp  #DIRECT_A
    jr  z, colision_parte_izquierda

    ret

    colision_parte_izquierda:

    ld    hl, #colision_actual
    ld  (hl), #4

    call comprobar_colision                ;; Left-up

    ld    a, Y(ix)
    add   a, #7
    ld    Y(ix), a
    call comprobar_colision                ;; Left-mid

    ld    a, Y(ix)
    add   a, #8
    ld    Y(ix), a
    call comprobar_colision                ;; Left-down
    ld    a, Y(ix)
    sub   a, #15
    ld    Y(ix), a

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COLISIONES DEL PLAYER CON EL TILEMAP ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sys_collision_update_player_tilemap:
    ;; Inicializamos los valores
    call inicializar_player_colision

    ld   ix, #m_entities

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de arriba (W) 
    call sys_collision_up

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de abajo (S)
    call sys_collision_down

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de derecha (D)
    call sys_collision_right

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de izquierda (A)
    call sys_collision_left

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE PAIR ENTITIES
;;  updates the collision of a given entity
;; IN -> BC:  left entity
;;       DE: right entity
sys_collisions_update_entities::

    push ix
    push iy

    ld__ix_bc  ;; BC player
    ld__iy_de

    ld  b, #0 ;; Inicializar bounding box

    ;; Colision jugador con entidad
    ld   a, TYPE(ix)
    and  COLLIDES_AGAINST(iy)
    cp   COLLIDES_AGAINST(iy)
    jr z, comprobar_si_es_enemigo

    ;; Colision entidad con jugador
    ld   a, TYPE(iy)
    and  COLLIDES_AGAINST(ix)
    cp   COLLIDES_AGAINST(ix)
    jr nz, __no_collision

    ;; Hacer la bounding box mas pequeña si la entidad es un enemigo
    comprobar_si_es_enemigo:

    ld a, TYPE(iy)
    cp  #E_TYPE_ENEMY
    jr   z, bounding_box_mas_pequeña

    ld a, TYPE(iy)
    cp  #E_TYPE_ENEMY2
    jr   z, bounding_box_mas_pequeña

    ld a, TYPE(iy)
    cp  #E_TYPE_ENEMY3
    jr   z, bounding_box_mas_pequeña

    ld a, TYPE(iy)
    cp  #E_TYPE_ENEMY4
    jr   z, bounding_box_mas_pequeña

    jr check_collision_between_entities

    bounding_box_mas_pequeña:
    ld  b, #2

    ;;;;;;;;;;;;;;;;
    ;; Colisiones ;;
    ;;;;;;;;;;;;;;;;
    check_collision_between_entities:
    ;; |-----[DE]a--b[BC]-----|
    ;; if ( X(DE) + WIDTH(DE) - X(BC) < 0 )
    ld a, X(ix)
    add WIDTH(ix)
    sub b
    sub X(iy)
    jr c, __no_collision

    ;; |-----[BC]c--d[DE]-----|
    ;; if ( X(BC) + WIDTH(BC) - X(DE) < 0 )
    ld a, X(iy)
    add WIDTH(iy)
    sub b
    sub X(ix)
    jr c, __no_collision

    ;; if ( Y(DE) + HEIGHT(DE) - Y(BC) < 0 )
    ld a, Y(ix)
    add HEIGHT(ix)
    sub b
    sub b
    sub Y(iy)
    jr c, __no_collision

    ;; if ( Y(BC) + HEIGHT(BC) - Y(DE) < 0 )
    ld a, Y(iy)
    add HEIGHT(iy)
    sub b
    sub b
    sub Y(ix)
    jr c, __no_collision

    ;;;;;;;;;;;;;;;
    ;; Collision ;; --- Comprobamos con que colisionamos
    ;;;;;;;;;;;;;;;

    call check_food
    call check_door
    call check_enemy

    jr final_colisiones

    ;;;;;;;;;;;;;;;;;;
    ;; No Collision ;;
    ;;;;;;;;;;;;;;;;;;

    __no_collision:

    final_colisiones:

    pop ix
    pop iy

    ret

;; Colision con la comida
check_food:
    ld a, TYPE(iy)
    cp  #E_TYPE_FOOD
    ret nz

    ld TYPE(iy), #E_TYPE_DEAD

    ret

;; Colision con los enemigos
check_enemy:
    ld a, TYPE(iy)
    cp  #E_TYPE_ENEMY
    jr   z, inicio_check_enemy

    ld a, TYPE(iy)
    cp  #E_TYPE_ENEMY2
    jr   z, inicio_check_enemy

    ld a, TYPE(iy)
    cp  #E_TYPE_ENEMY3
    jr   z, inicio_check_enemy

    ld a, TYPE(iy)
    cp  #E_TYPE_ENEMY4
    jr   z, inicio_check_enemy

    ret

    inicio_check_enemy:

    push de
    call sys_render_draw_solid_box_player
    pop de

    ld X(ix), #20 ;; | 
    ld Y(ix), #60 ;; | Reposicionar al player a la posicion inicial
    
    push de
    call quitar_vida
    pop de

    ret

;; Colision con la puerta
check_door:

    ld a, TYPE(iy)
    cp  #E_TYPE_DOOR
    jr  z, inicio_check_door

    ret

    inicio_check_door:

    ld  a, direction(ix)
    cp  #DIRECT_W
    jr  z, colision_arriba_puerta

    ld  a, direction(ix)
    cp  #DIRECT_S
    jr  z, colision_abajo_puerta

    ;ld  a, direction(ix)
    ;cp  #DIRECT_A
    ;jr  z, colision_izquierda_puerta

    ;;ret

    colision_arriba_puerta:
    ld   hl, #is_colliding_player
    ld (hl),  #1
    ld VY(ix), #0
    jr final_check_door

    colision_abajo_puerta:
    ld   hl, #is_colliding_player + 1
    ld (hl),  #1
    ld VY(ix), #0
    jr final_check_door

    ;colision_izquierda_puerta:
    ;ld   hl, #is_colliding_player + 3
    ;ld (hl),  #1
    ;ld VX(ix), #0

    jr final_check_door

    final_check_door:

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sys Collision Update ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
_sys_collision_update::
    ;ld   bc, #sys_collision_update_one_entity
    ;ld   hl, #E_CMP_COLLIDER
    ;call _man_entity_for_all_matching
    call sys_collision_update_player_tilemap

    ld bc, #sys_collisions_update_entities
    ld hl, #E_CMP_COLLIDER
    call _man_entity_for_all_pairs_matching_while1

    ret