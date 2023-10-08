.module Manager_IA
.area _DATA
.area _CODE
.include "man/entity.h.s"
.include "ia.h.s"
.include "cpctelera.h.s"

;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEHAVIOUR MOTHERSHIP
;;
;; IN => DE -> entity to update
;;
sys_ai_behaviour_mothership::
    ld      hl, #X
    add     hl, de
    ld      a, (hl)
    ld c, a
    ld a, #20
    cp c
    jr z, create_enemy
    jr goto_behaviour
    create_enemy:
        call man_game_create_enemy
        jr sys_ai_behaviour_mothership_end
    goto_behaviour:
    call sys_ai_behaviour_left_right
    sys_ai_behaviour_mothership_end:
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BEHAVIOUR LEFT-RIGHT
;;
;; IN => DE -> entity to update
;;
sys_ai_behaviour_left_right::
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
        ld      hl, #E_TYPE_IA | #E_TYPE_MOVABLE
        call    _man_entity_for_all_matching
ret

