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
; call move_down
;         call choose_axis_y_enemie
;         ld hl, #VX
;         add hl, de
;         ld (hl), #0
;         ld hl, #VY
;         add hl, de
;         ld (hl), #1
; ret
; call move_above
;         call choose_axis_y_enemie
;         ld hl, #VX
;         add hl, de
;         ld (hl), #0
;         ld hl, #VY
;         add hl, de
;         ld (hl), #-1
; ret
; call move_left
;         call choose_axis_x_enemie
;         ld hl, #VY
;         add hl, de
;         ld (hl), #0
;         ld hl, #VY
;         add hl, de
;         ld (hl), #-1
; ret
; call move_right
;         call choose_axis_x_enemie
;         ld hl, #VY
;         add hl, de
;         ld (hl), #0
;         ld hl, #VY
;         add hl, de
;         ld (hl), #1
; ret
; check_above_left_corner:
;     ld hl, #X
;     add hl, de
;     ld a, (hl)
;     cp #70
;     jr z, checky
;     checky:
;         ld hl, #Y
;         add hl, de
;         ld a, (hl)
;         cp #20
;         jr z, mover_abajo
;         mover_abajo:
;         call move_down
; ret
; check_buttom_left_corner:
; ld hl, #X
;     add hl, de
;     ld a, (hl)
;     cp #20
;     jr z, checky
;     checky:
;         ld hl, #Y
;         add hl, de
;         ld a, (hl)
;         cp #20
;         jr z, mover_abajo
;         mover_abajo:
;         call move_down
; ret
; check_buttom_right_corner:
; ld hl, #X
;     add hl, de
;     ld a, (hl)
;     cp #20
;     jr z, checky
;     checky:
;         ld hl, #Y
;         add hl, de
;         ld a, (hl)
;         cp #150
;         jr z, mover_abajo
;         mover_abajo:
;         call move_down
; ret
; check_above_right_corner:
;     ld hl, #X
;     add hl, de
;     ld a, (hl)
;     cp #20
;     jr z, checky
;     checky:
;         ld hl, #Y
;         add hl, de
;         ld a, (hl)
;         cp #20
;         jr z, mover_abajo
;         mover_abajo:
;         call move_down
; ret
sys_ai_surround_map::
; call check_above_left_corner
;     call choose_axis_x_enemie
;     ld hl, #X
;     add hl, de
;     ld a, (hl)
;     cp #20
;     jr z, comprobary ;; si x === 20
;         jr comprobarx ;; si x != 20
;     ;; compruebo mover derecha
;   comprobary:
;     ld hl, #Y
;     add hl, de
;     ld a, (hl)
;     cp #150
;     jr z, mover_derecha ;; si x == 20 e y == 150
;         jr mover_abajo ;; si x == 20 e y != 150
; comprobarx:
;     ld hl, #X
;     add hl, de
;     ld a, (hl)
;     cp #70
;     jr z, comprobary2 ;; si x == 70
; comprobary2:
;     ld hl, #Y
;     add hl, de
;     ld a, (hl)
;     cp #20
;     jr z, mover_arriba ;; y === 150 x == 70
;         ; jr mover_izquierda
;     mover_abajo:
;         call choose_axis_y_enemie
;         ld hl, #VX
;         add hl, de
;         ld (hl), #0
;         ld hl, #VY
;         add hl, de
;         ld (hl), #1
;         jr sys_ai_surround_map_end
;     mover_derecha:
;         call choose_axis_x_enemie
;         ld hl, #VY
;         add hl, de
;         ld (hl), #0
;         ld hl, #VX
;         add hl, de
;         ld (hl), #1
;         jr sys_ai_surround_map_end
;     mover_arriba:
;         call choose_axis_y_enemie
;         ld hl, #VX
;         add hl, de
;         ld (hl), #0
;         ld hl, #VY
;         add hl, de
;         ld (hl), #-1
;         jr sys_ai_surround_map_end
;     mover_izquierda:
;         call choose_axis_x_enemie
;         ld hl, #VY
;         add hl, de
;         ld (hl), #0
;         ld hl, #VX
;         add hl, de
;         ld (hl), #-1
;         sys_ai_surround_map_end:
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

