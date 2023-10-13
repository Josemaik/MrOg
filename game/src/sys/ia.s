.module System_IA
.area _DATA
.area _CODE
.include "man/entity.h.s"
.include "ia.h.s"
.include "cpctelera.h.s"

;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEHAVIOUR ENEMY
;;
;; IN => DE -> entity to update
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUTODESTROY
;;
;; IN => DE -> entity to autodestroy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEHAVIOUR MOTHERSHIP
;;
;; IN => DE -> entity to update
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEHAVIOUR LEFT-RIGHT
;;
;; IN => DE -> entity to update
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE IA FOR ONE ENTITY 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IN =>  DE -> entity to update                                      
;;
sys_ai_update_for_one:
    
    ;; guardo un checkpoint
    ld      hl, #_return_hear_ia
    push    hl

    push de
    ;; go to entity-> iabehaviour
    ld      hl, #IA_behaviour
    add     hl, de
    ;; de<=>hl and save first byte in L
    ld      e, l
    ld      d, h
    ld      a, (de) 
    ld      l, a
    ;; add 1 to de and save second byte in H
    inc     de
    ld      a, (de)
    ld      h, a
    ;; save in stack memory pointer to call function
    ld      4(ix), l
    ld      5(ix), h

    pop de
    ;; call function
    ld c, 4(ix)
    ld b, 5(ix)
    push bc
    ret
    _return_hear_ia:
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAll PHYSICS FOR ALL ENTITY :;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_sys_ai_update::          
        ld      bc, #sys_ai_update_for_one
        ld      hl, #E_CMP_IA | #E_CMP_MOVABLE
        call    _man_entity_for_all_matching
ret

