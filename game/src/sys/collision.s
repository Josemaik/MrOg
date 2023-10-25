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
;; Funciones para poner la velocidad a 0
;;
sys_collision_player_tilemap_w:
    ld h , 4(ix)
    ld l,  5(ix)
    ld      a, #1
    ld      (hl), a
    ld hl, #VY
    add hl, de
    ld (hl), #0

    ret
sys_collision_player_tilemap_s:
    ld h , 4(ix)
    ld l,  5(ix)
    inc hl
    ld      a, #1
    ld      (hl), a
    ld hl, #VY
    add hl, de
    ld (hl), #0

    ret

sys_collision_player_tilemap_d:
    ld h , 4(ix)
    ld l,  5(ix)
    inc hl
    inc hl
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
    ld h , 4(ix)
    ld l,  5(ix)
    inc hl
    inc hl
    inc hl
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
calcular_colisiones_jugador:
 ld    hl, #colision_actual
    ld  (hl), #0
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Colision con la parte de arriba (W) ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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


    ; ld   hl, #X
    ; add  hl, de
    ; ld    a, (hl)
    ; dec   a
    ; ld    (hl), a

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

    ;ld   hl, #X
    ;add  hl, de
    ;ld    a, (hl)
    ;inc   a
    ;ld    (hl), a
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE ONE ENTITY WITH THE TILEMAP
;;
sys_collision_update_one_entity:

    ;;;;;;;;;;;;;; Comprobar si es player ;;;;;;;;;;;;;;

    ld hl, #TYPE
    add hl, de
    ld a, (hl)
    cp #E_TYPE_PLAYER
    jr z, ini_jugador
    ret
    ini_jugador:
        call inicializar_player_colision
        ld hl, #is_colliding_player
        ld 4(ix), h
        ld 5(ix), l
        call calcular_colisiones_jugador

    ;;;;;;;;;;;; Fin Colisiones ;;;;;;;;;;;;
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

    ;; Colision jugador con entidad
    ld   a, TYPE(ix)
    and  COLLIDES_AGAINST(iy)
    cp   COLLIDES_AGAINST(iy)
    jr z, check_collision_between_entities

    ;; Colision entidad con jugador
    ld   a, TYPE(iy)
    and  COLLIDES_AGAINST(ix)
    cp   COLLIDES_AGAINST(ix)
    jr nz, __no_collision

    ;;;;;;;;;;;;;;;;
    ;; Colisiones ;;
    ;;;;;;;;;;;;;;;;
    check_collision_between_entities:
    ;; |-----[DE]a--b[BC]-----|
    ;; if ( X(DE) + WIDTH(DE) - X(BC) < 0 )
    ld a, X(ix)
    add WIDTH(ix)
    sub #2
    sub X(iy)
    jr c, __no_collision

    ;; |-----[BC]c--d[DE]-----|
    ;; if ( X(BC) + WIDTH(BC) - X(DE) < 0 )
    ld a, X(iy)
    add WIDTH(iy)
    sub #2
    sub X(ix)
    jr c, __no_collision

    ;; if ( Y(DE) + HEIGHT(DE) - Y(BC) < 0 )
    ld a, Y(ix)
    add HEIGHT(ix)
    sub #2
    sub Y(iy)
    jr c, __no_collision

    ;; if ( Y(BC) + HEIGHT(BC) - Y(DE) < 0 )
    ld a, Y(iy)
    add HEIGHT(iy)
    sub #2
    sub Y(ix)
    jr c, __no_collision

    ;;;;;;;;;;;;;;;
    ;; Collision ;; --- Comprobamos con que colisionamos
    ;;;;;;;;;;;;;;;

    ld a, TYPE(iy)
    and #E_TYPE_ENEMY
    cp  #E_TYPE_ENEMY
    jr  z, colision_con_enemigo

    ld a, TYPE(iy)
    and #E_TYPE_ENEMY2
    cp  #E_TYPE_ENEMY2
    jr  z, colision_con_enemigo

    ld a, TYPE(iy)
    and #E_TYPE_ENEMY3
    cp  #E_TYPE_ENEMY3
    jr  z, colision_con_enemigo

    ld a, TYPE(iy)
    and #E_TYPE_ENEMY4
    cp  #E_TYPE_ENEMY4
    jr  z, colision_con_enemigo

    ld a, TYPE(iy)
    and #E_TYPE_FOOD
    cp  #E_TYPE_FOOD
    jr  z, colision_con_comida

;; Colision con el enemigo
colision_con_enemigo:
    push de
    call sys_render_draw_solid_box_player
    pop de
    ld X(ix), #20
    ld Y(ix), #60

    jr final_colisiones

;; Colision con la comida
colision_con_comida:
    ld TYPE(iy), #E_TYPE_DEAD

    jr final_colisiones

    ;;;;;;;;;;;;;;;;;;
    ;; No Collision ;;
    ;;;;;;;;;;;;;;;;;;

    __no_collision:

    final_colisiones:

    pop ix
    pop iy

    ret

_sys_collision_update::
    ld   bc, #sys_collision_update_one_entity
    ld   hl, #E_CMP_COLLIDER
    call _man_entity_for_all_matching

    ld bc, #sys_collisions_update_entities
    ld hl, #E_CMP_COLLIDER
    call _man_entity_for_all_pairs_matching_while1

    ret