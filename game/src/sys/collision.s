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
    ld   hl, #Y
    add  hl, de
    ld    a, (hl)

    push de

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

    pop de
    push hl

    ;; A = X
    ld   hl, #X
    add  hl, de
    ld    a, (hl)
    srl    a ;; | A = tx (x/4)
    srl    a ;; |

    pop hl
    push de

    add_hl_a  ;; HL = ty * tw + tx
    ld     de, #_tilemap_01
    add    hl, de

    pop de

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Funciones para poner la velocidad y la posicion a 0
;;
sys_collision_player_tilemap_w:
    ld  hl, #is_colliding_player
    ld      a, #1
    ld      (hl), a
    ld hl, #VY
    add hl, de
    ld (hl), #0

    ret
sys_collision_player_tilemap_s:
    ld  hl, #is_colliding_player + 1
    ld      a, #1
    ld      (hl), a
    ld hl, #VY
    add hl, de
    ld (hl), #0

    ret

sys_collision_player_tilemap_d:
    ld  hl, #is_colliding_player + 2
    ld      a, #1
    ld      (hl), a
    ld hl, #VX
    add hl, de
    ld (hl), #0

    ld hl, #X
    add hl, de
    ld  a, (hl)
    dec a
    ld (hl), a

    ret

sys_collision_player_tilemap_a:
    ld  hl, #is_colliding_player + 3
    ld      a, #1
    ld      (hl), a
    ld hl, #VX
    add hl, de
    ld (hl), #0

    ld hl, #X
    add hl, de
    ld  a, (hl)
    inc a
    ld (hl), a

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COLISIONES DEL PLAYER CON EL TILEMAP ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sys_collision_update_player_tilemap:
    ;; Inicializamos los valores
    call inicializar_player_colision

    ld   de, #m_entities
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de arriba (W) 
    ;;

    ld    hl, #colision_actual
    ld  (hl), #1

    ld   hl, #Y
    add  hl, de
    ld    a, (hl)
    dec   a
    ld    (hl), a

    call comprobar_colision                ;; Upper-left

    ld   hl, #X
    add  hl, de
    ld    a, (hl)
    add   a, #3
    ld    (hl), a
    call comprobar_colision                ;; Upper-mid

    ld   hl, #X
    add  hl, de
    ld    a, (hl)
    add   a, #4
    ld    (hl), a
    call comprobar_colision                ;; Upper-right
    ld   hl, #X
    add  hl, de
    ld    a, (hl)
    sub   a, #7
    ld    (hl), a

    ld   hl, #Y
    add  hl, de
    ld    a, (hl)
    inc   a
    ld    (hl), a

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de abajo (S) ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ld    hl, #colision_actual
    ld  (hl), #2

    ld   hl, #Y
    add  hl, de
    ld    a, (hl)
    add   a, #16
    ld    (hl), a

    call comprobar_colision                ;; Down-left

    ld   hl, #X
    add  hl, de
    ld    a, (hl)
    add   a, #3
    ld    (hl), a
    call comprobar_colision                ;; Down-mid

    ld   hl, #X
    add  hl, de
    ld    a, (hl)
    add   a, #4
    ld    (hl), a
    call comprobar_colision                ;; Down-right
    ld   hl, #X
    add  hl, de
    ld    a, (hl)
    sub   a, #7
    ld    (hl), a

    ld   hl, #Y
    add  hl, de
    ld    a, (hl)
    sub   a, #16
    ld    (hl), a

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de derecha (D) ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ld    hl, #colision_actual
    ld  (hl), #3

    ld   hl, #X
    add  hl, de
    ld    a, (hl)
    add   a, #7
    ld    (hl), a

    call comprobar_colision                ;; Right-up

    ld   hl, #Y
    add  hl, de
    ld    a, (hl)
    add   a, #7
    ld    (hl), a
    call comprobar_colision                ;; Right-up

    ld   hl, #Y
    add  hl, de
    ld    a, (hl)
    add   a, #8
    ld    (hl), a
    call comprobar_colision                ;; Right-down
    ld   hl, #Y
    add  hl, de
    ld    a, (hl)
    sub   a, #15
    ld    (hl), a

    ld   hl, #X
    add  hl, de
    ld    a, (hl)
    sub   a, #7
    ld    (hl), a

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de izquierda (A) ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ld    hl, #colision_actual
    ld  (hl), #4

    call comprobar_colision                ;; Left-up

    ld   hl, #Y
    add  hl, de
    ld    a, (hl)
    add   a, #7
    ld    (hl), a
    call comprobar_colision                ;; Left-mid

    ld   hl, #Y
    add  hl, de
    ld    a, (hl)

    add   a, #8
    ld    (hl), a
    call comprobar_colision                ;; Left-down
    ld   hl, #Y
    add  hl, de
    ld    a, (hl)
    sub   a, #15
    ld    (hl), a

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