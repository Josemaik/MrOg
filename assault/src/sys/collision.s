.module System_Animation

.include "cpctelera.h.s"
.include "collision.h.s"
.include "man/entity.h.s"
.area _DATA
;;Array de sprites


.area _CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE PAIR ENTITIES
;;  updates the collision of a given entity
;; IN -> DE: left entity
;;       BC: rght entity
sys_collisions_update_entities::
    ; ld a, #0x00
    ; ld (0xC000),a
    ;; check if both entities can collide
    ;; check if entity of right can collid another entity
    ;; e(r)->collides_against
    ld hl, #COLLIDES_AGAINST
    add hl, bc
    ld a, (hl)
    ;; e(l)->type
    ld hl, #TYPE
    add hl, de
    and (hl)
    ;; check if can collide( e(r)->collides_against && e(l)->type == 0 )
    cp (hl)
    jr z, check_collision_between_entities

    ld hl, #COLLIDES_AGAINST
    add hl, de
    ld a, (hl)

    ld hl, #TYPE
    add hl, bc
    and (hl)

    cp (hl)
    jr z, check_collision_between_entities
        jr dont_have_collision_between_entities
    check_collision_between_entities:
        ;; check bounding boxes
        ;; A < B
        ;; if(x(l) + width(l) < x(r)) no collision
        ;; if(x(l) + width(l) - x(r) < 0)no collision
        ;; x(l)
        ; ld hl, #X
        ; add hl, de
        ; ld a, (hl)
        ; ;; width(l)
        ; ld hl,#WIDTH
        ; add hl,de
        ; add (hl)
        ; ;; x(r)
        ; ld hl, #X
        ; add hl, bc
        ; sub (hl)
        ; ; ;; if carry is 1 -> no collision
        ; jr c, no_collision
        ;     jr collision
        ; ;; C < D
        ; ;; if(x(r) + width(r) < x(l)) no collision
        ; ;; if(x(r) + width(r) - x(l) < 0)no collision
        ; ;; x(l)
        ; ld hl, #X
        ; add hl, bc
        ; ld a, (hl)
        ; ;; width(l)
        ; ld hl,#WIDTH
        ; add hl,bc
        ; add (hl)
        ; ;; x(r)
        ; ld hl, #X
        ; add hl, de
        ; sub (hl)
        
        ; jr c, no_collision
        ;     jr collision
        ;; check bounding boxes
        ;; A < B
        ;; if(y(l) + height(l) < y(r)) no collision
        ;; if(y(l) + height(l) - y(r) < 0)no collision
        ;; y(l)
        ld hl, #Y
        add hl, de
        ld a, (hl)
        ;; height(l)
        ld hl,#HEIGHT
        add hl,de
        add (hl)
        ;; y(r)
        ld hl, #Y
        add hl, bc
        sub (hl)
        ; ;; if carry is 1 -> no collision
        jr c, no_collision
            jr collision
        ; ;; C < D
        ; ;; if(y(r) + height(r) < y(l)) no collision
        ; ;; if(y(r) + height(r) - y(l) < 0)no collision
        ; ;; y(l)
        ld hl, #Y
        add hl, bc
        ld a, (hl)
        ;; height(l)
        ld hl,#HEIGHT
        add hl,bc
        add (hl)
        ;; y(r)
        ld hl, #Y
        add hl, de
        sub (hl)
        
        jr c, no_collision
            jr collision


        ;; si hay colision
        collision:
            ld a, #0xFF
            ld (0xC000), a
            jr dont_have_collision_between_entities
            ; call man_game_entity_destroy
        ;; there is collision, check entity types and react
        no_collision:
            ld a, #0x00
            ld (0xC000),a
    dont_have_collision_between_entities:
ret
_sys_collision_update::
    ld bc, #sys_collisions_update_entities
    ld hl, #E_CMP_COLLIDER
    call _man_entity_for_all_pairs_matching_while1
ret