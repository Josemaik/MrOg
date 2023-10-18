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
;; BEHAVIOUR SURROUND MAP
;;
;; IN => DE -> entity to update
;;
 move_down:
        call choose_axis_y_enemie
        ld hl, #VX
        add hl, de
        ld (hl), #0
        ld hl, #VY
        add hl, de
        ld (hl), #1
ret
move_above:
        call choose_axis_y_enemie
        ld hl, #VX
        add hl, de
        ld (hl), #0
        ld hl, #VY
        add hl, de
        ld (hl), #-1
ret
move_left:
        call choose_axis_x_enemie
        ld hl, #VY
        add hl, de
        ld (hl), #0
        ld hl, #VX
        add hl, de
        ld (hl), #-1
ret
move_right:
        call choose_axis_x_enemie
        ld hl, #VY
        add hl, de
        ld (hl), #0
        ld hl, #VX
        add hl, de
        ld (hl), #1
ret
check_above_left_corner:
    ld hl, #X
    add hl, de
    ld a, (hl)
    cp #10
    jr z, checky
        jr check_above_left_corner_end
    checky:
        ld hl, #Y
        add hl, de
        ld a, (hl)
        cp #20
        jr z, mover_abajo
            jr check_above_left_corner_end
        mover_abajo:
        call move_down
        check_above_left_corner_end:
ret
check_buttom_left_corner:
    ld hl, #X
    add hl, de
    ld a, (hl)
    cp #10
    jr z, checky1
        jr check_buttom_left_corner_end
    checky1:
        ld hl, #Y
        add hl, de
        ld a, (hl)
        cp #150
        jr z, mover_der
            jr check_buttom_left_corner_end
        mover_der:
        call move_right
        check_buttom_left_corner_end:
ret
check_buttom_right_corner:
    ld hl, #X
    add hl, de
    ld a, (hl)
    cp #70
    jr z, checky2
        jr check_buttom_right_corner_end
    checky2:
        ld hl, #Y
        add hl, de
        ld a, (hl)
        cp #150
        jr z, mover_arriba
            jr check_buttom_right_corner_end
        mover_arriba:
        call move_above
        check_buttom_right_corner_end:
ret
check_above_right_corner:
    ld hl, #X
    add hl, de
    ld a, (hl)
    cp #70
    jr z, checky3
        jr check_above_right_corner_end
    checky3:
        ld hl, #Y
        add hl, de
        ld a, (hl)
        cp #20
        jr z, mover_izq
            jr check_above_right_corner_end
        mover_izq:
        call move_left
    check_above_right_corner_end:
ret
sys_ai_surround_map::
    call check_above_right_corner
    call check_above_left_corner
    call check_buttom_left_corner
    call check_buttom_right_corner
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
        ld      hl, #E_CMP_IA | #E_CMP_MOVABLE
        call    _man_entity_for_all_matching
ret

