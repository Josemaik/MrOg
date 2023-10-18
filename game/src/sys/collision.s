.module System_Collision

.include "collision.h.s"
.include "man/entity.h.s"
.include "cpctelera.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE ONE ENTITY WITH THE TILEMAP 
;;  Input:
;;     IX: Pointer to entity having movement and collider component
;; 
sys_collision_update_one_entity:
    ;; tx = x/4
    ;; ty = y/8
    ;; tw = tilemap-width (0x30, 48)
    ;; p  = tilemap + ty * tw + tx

    ;; A = y
    ld    a, Y(ix)
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
    ;; A = X
    ld     a, X(ix)
    srl    a ;; | A = tx (x/4)
    srl    a ;; |

    add_hl_a  ;; HL = ty * tw + tx
    ld     de, #_tilemap_01
    add    hl, de

    ;; HL = tilemap + ty * tw + tx
    ld      a, (hl)
    and     #0b11111110
    ret     nz

    ld      a, #0x33 ; 4F07

    ;; velocidad a 0
    ;; reposicionar la entidad

    ret
_sys_collision_update::
    ld   bc, #sys_collision_update_one_entity
    ld   hl, #E_CMP_COLLIDER
    call _man_entity_for_all_matching

    ret