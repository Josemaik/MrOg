.module System_IA
.area _DATA

valid_directions::
    .ds 4
indice::
    .db 0x01
.area _CODE
.include "man/entity.h.s"
.include "ia.h.s"
.include "cpctelera.h.s"

;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;

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
        ld bc, #choose_axis_y_enemie
        call move_down_e
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
        ld bc, #choose_axis_x_enemie
        call move_right_e
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
        ld bc, #choose_axis_y_enemie
        call move_above_e
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
        ld bc, #choose_axis_x_enemie
        call move_left_e
    check_above_right_corner_end:
ret
sys_ai_surround_map::
    call check_above_right_corner
    call check_above_left_corner
    call check_buttom_left_corner
    call check_buttom_right_corner
ret
sys_ai_vertical_enemie::
   call choose_axis_x_enemie2
   ;; check colsiion izquieda y muevo derecha
   ld a, (is_colliding_enemie + 3)
   cp #1
   jr nz, check_der
   ld bc, #choose_axis_x_enemie2
   call move_right_e
   jr sys_ai_vertical_player_end
   ;; cheeck colision derecha y muevo izquierda
   check_der:
   ld a, (is_colliding_enemie + 2)
   cp #1
   jr nz , sys_ai_vertical_player_end
   ld bc, #choose_axis_x_enemie2
   call move_left_e
   sys_ai_vertical_player_end:
ret
sys_ai_horizontal_enemie::
 call choose_axis_y_enemie3
 ;; check colsiion izquieda y muevo derecha
   ld a, (is_colliding_enemie2)
   cp #1
   jr nz, check_down
   ld bc, #choose_axis_y_enemie3
   call move_down_e
   jr sys_ai_horizontal_player_end
   ;; cheeck colision derecha y muevo izquierda
   check_down:
   ld a, (is_colliding_enemie2 + 1)
   cp #1
   jr nz , sys_ai_horizontal_player_end
   ld bc, #choose_axis_y_enemie3
   call move_above_e
   sys_ai_horizontal_player_end:
ret
sys_ai_random_enemie::
;; sacar un random
    call cpct_getRandom_xsp40_u8_asm
    and #3 ;; me saca un 0 , 1 , 2 o 3
    ;; si saca 0 -> muevo izquierda
            ;; compruebo si colison sino salto al siguiente
    ;; si saca 1 -> muevo abajo
             ;; compruebo si colison sino salto al siguiente
    ;; si saca 2 -> muevo derecha
             ;; compruebo si colison sino salto al siguiente
    ;; si saca 3 -> muevo arriba
             ;; compruebo si colison sino salto al siguiente
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

