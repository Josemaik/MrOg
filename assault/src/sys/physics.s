.module Control_physics
.area _DATA
.area _CODE
.include "man/entity.h.s"
.include "physics.h.s"


;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE PHYSICS FOR ONE ENTITY ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; INPUTS ;;                  ;                                      
        ;; DE -> entity to update ;                                      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sys_physics_update_for_one:

    ;; go to entity->x and load it in a
        ld      hl, #X
        add     hl, de
        ld      a, (hl)     ;; we have in a the value of ex

    ;; go to entity-vx
        ld      hl, #VX
        add     hl, de

    ;; res vx to a
        sub     (hl)

    ;; conditional to know if entity has reach the end
        jr      c, sys_destroy_entity ;; 

    ;; position > 0        
        jr      sys_save_vx

    ;; position < 0
    sys_destroy_entity:
        call    _man_entity_set_for_destruction

    sys_save_vx:    ;; position > 0
    ;; go to entity->x and load a
        ld      hl, #X
        add     hl, de
        ld      (hl), a

    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAll PHYSICS FOR ALL ENTITY :;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_sys_physics_update::

    ;; for all entities -> sys_physics_update_for_one
        ;; INPUTS ;;
            ;; BC -> memory position of the function
            
        ld      bc, #sys_physics_update_for_one
        call    _man_entity_for_all

    ret
