.module Manager_IA
.area _DATA
.area _CODE
.include "man/entity.h.s"
.include "ia.h.s"
.include "cpctelera.h.s"

;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE IA FOR ONE ENTITY 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IN =>  DE -> entity to update                                      
;;pop de
sys_ai_update_for_one:
        ;; go to entity->x
        ld      hl, #X
        add     hl, de
        ld      a, (hl)
        ;; if (x == 0) go right
        cp #0
        jr z, move_right
        ;; go to entity->width
        ld      hl, #WIDTH
        add     hl, de
        ;; save in a width of screen and sub to entity->width
        ld a, #80
        sub (hl)
        ;; save in c the result of operation
        ld c,a
        ;; go to entity->x
        ld      hl, #X
        add     hl, de
        ld      a, (hl)
        ;; if (x == 80-width) go left
        cp c
        jr z, move_left
        jr sys_ai_update_for_one_end

        move_right:
            ld      hl, #VX
            add     hl, de
            ld      (hl),#1
            jr sys_ai_update_for_one_end
        move_left:
            ld      hl, #VX
            add     hl, de
            ld      (hl),#-1
    sys_ai_update_for_one_end:
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAll PHYSICS FOR ALL ENTITY :;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_sys_ai_update::          
        ld      bc, #sys_ai_update_for_one
        ld      hl, #E_TYPE_IA | #E_TYPE_MOVABLE
        call    _man_entity_for_all_matching
ret

