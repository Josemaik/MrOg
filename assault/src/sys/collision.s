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
sys_collisions_update_entities:
    ;; check if both entities can collide
    ld hl, #COLLIDES_AGAINST
    add hl, bc
    ld a, (hl)

    ld hl, #TYPE
    add hl, de
    and (hl)

    cp (hl)
    jr z, collision_between_entities

    ld hl, #COLLIDES_AGAINST
    add hl, de
    ld a, (hl)

    ld hl, #TYPE
    add hl, bc
    and (hl)

    cp (hl)
    jr z, collision_between_entities
        jr no_collision_between_entities
    collision_between_entities:
        ;; check bounding boxes
        ;; there is collision, check entity types and react
    no_collision_between_entities:
ret
sys_collision_update::
    ld bc, #sys_collisions_update_entities
    ld hl, #E_CMP_COLLIDER
    call _man_entity_for_all_pairs_matching
ret