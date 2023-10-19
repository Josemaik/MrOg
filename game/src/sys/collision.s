.module System_Collision

.include "collision.h.s"
.include "man/entity.h.s"
.include "cpctelera.h.s"


is_colliding_player:: ;; 0 no collision | 1 collision
    .db 0x00       ;; up
    .db 0x00       ;; down
    .db 0x00       ;; right
    .db 0x00       ;; left

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; INITIALIZE is_colliding_player
;;
sys_initialize_collision_player_tilemap:
    ld      a, #0
    ld      (is_colliding_player), a 
    ld      (is_colliding_player + 1), a 
    ld      (is_colliding_player + 2), a 
    ld      (is_colliding_player + 3), a 

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Check collisions player with tilemap
;;
sys_collision_player_tilemap:

    ld      a, #1
    ld      (is_colliding_player), a 

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE ONE ENTITY WITH THE TILEMAP 
;; 
sys_collision_update_one_entity:

    ld hl, #TYPE
    add hl, de
    ld a, (hl)
    cp #E_TYPE_PLAYER
    jr z, iniciar_colision
    jr comprobar_colision
    iniciar_colision:
    call sys_initialize_collision_player_tilemap

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

    ;; Para calcular el sprite de abajo sumar el height (add #15)
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

    ;; A = X
    ld   hl, #X
    add  hl, de
    ld    a, (hl)
    srl    a ;; | A = tx (x/4)
    srl    a ;; |

    push de

    add_hl_a  ;; HL = ty * tw + tx
    ld     de, #_tilemap_01
    add    hl, de

    pop de

    ;; HL = tilemap + ty * tw + tx
    ld      a, (hl)
    and     #0b11111110
    ret     nz

    ;call stop_sprite

    ;; 11111110

    ;; 00000000
    ;; 00000001
    ;; 00000010 no colision

    ld hl, #TYPE
    add hl, de
    ld a, (hl)
    cp #E_TYPE_PLAYER
    jr z, finalizar_colision
    jr final_colision
    finalizar_colision:
    call sys_collision_player_tilemap

    final_colision:

    ;; reposicionar la entidad
    ;;ld   hl, #Y
    ;;add  hl, de
    ;;ld    a, (hl)
    ;;inc   a
    ;;ld  (hl), a
    ;;
    ;;;; velocidad a 0
    ;;call stop_sprite

    ret
_sys_collision_update::
    ld   bc, #sys_collision_update_one_entity
    ld   hl, #E_CMP_COLLIDER
    call _man_entity_for_all_matching

    ret