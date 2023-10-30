.module System_IA
.area _DATA

valid_directions::
    .ds 4
indice::
    .db 0x01
indicador_patron:: ;; 0 -> viene de izq // 1 -> viene de abajo
    .db 0x00
array_coordinates_vertical::
   .db 0x00 ;; X
   .db 0x00 ;; Y
   .db 0x00 ;; X2
.area _CODE
.include "man/entity.h.s"
.include "ia.h.s"
.include "cpctelera.h.s"

;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;

sys_ai_horizontal_enemie_mapa_prueba::
     ld hl, #X
     add hl, de
     ld a, (hl)
     cp #32
     jr z, check_axis_y
        jr sys_ai_horizontal_enemie_end
    check_axis_y:
        ld hl, #Y
        add hl, de
        ld a, (hl)
        cp #167
        jr z, mover_arriba2
        ;;mover abajo
        ld hl, #Y
        add hl, de
        ld a, (hl)
        cp #57
        jr z, mover_abajo2
        jr sys_ai_horizontal_enemie_end
        mover_abajo2:
            ld bc, #anim_enemy_down
            ld 4(ix), c
            ld 5(ix), b
            ld bc, #DIRECT_S
            call check_animation
            ld hl, #choose_axis_enemy_hunter2
            call move_down_e
        jr sys_ai_horizontal_enemie_end
        mover_arriba2:
            ld bc, #anim_enemy_up
            ld 4(ix), c
            ld 5(ix), b
            ld bc, #DIRECT_W
            call check_animation
            ld hl, #choose_axis_enemy_hunter2
            call move_above_e
        sys_ai_horizontal_enemie_end:
ret

sys_ai_vertical_enemie::
    ld a, (mapa_actual)
    cp #0
    jr z, load_XY_mapa_prueba
    ld a, (mapa_actual)
    cp #1
    jr z, load_XY_mapa_1
    ld a, (mapa_actual)
    cp #2
    jr z, load_XY_mapa_2
    load_XY_mapa_prueba:
        ld a, #64
        ld (array_coordinates_vertical), a
        ld a, #33
        ld (array_coordinates_vertical + 1), a
        ld a, #20
        ld (array_coordinates_vertical + 2), a
        jr lets_check
    load_XY_mapa_1:
        ld a, #68
        ld (array_coordinates_vertical), a
        ld a, #80
        ld (array_coordinates_vertical + 1), a
        ld a, #4
        ld (array_coordinates_vertical + 2), a
        jr lets_check
    load_XY_mapa_2:
        ld a, #68
        ld (array_coordinates_vertical), a
        ld a, #104
        ld (array_coordinates_vertical + 1), a
        ld a, #20
        ld (array_coordinates_vertical + 2), a
        jr lets_check
    lets_check:
    ld hl, #Y
     add hl, de
     ld a, (hl)
     ld hl, #array_coordinates_vertical + 1
     cp (hl)
     jr z, check_axis_x_m2
        jr sys_ai_vertical_enemie_end
    check_axis_x_m2:
        ld hl, #X
        add hl, de
        ld a, (hl)
        ld hl, #array_coordinates_vertical
        cp (hl)
        jr z, mover_izquierda
        ;;mover abajo
        ld hl, #X
        add hl, de
        ld a, (hl)
        ld hl, #array_coordinates_vertical + 2
        cp (hl)
        jr z, mover_derecha
        jr sys_ai_vertical_enemie_end
        mover_izquierda:
            ld bc, #anim_enemy_left
            ld 4(ix), c
            ld 5(ix), b
            ld bc, #DIRECT_A
            call check_animation
            ld hl, #choose_axis_enemy_hunter
            call move_left_e
        jr sys_ai_vertical_enemie_end
        mover_derecha:
            ld bc, #anim_enemy_right
            ld 4(ix), c
            ld 5(ix), b
            ld bc, #DIRECT_D
            call check_animation
            ld hl, #choose_axis_enemy_hunter
            call move_right_e
        sys_ai_vertical_enemie_end:
ret
sys_ai_patron_enemie_mapa_prueba::
     ld hl, #X
    add hl, de
    ld a, (hl)
    cp #56
    jr z, checky4
        jr check_above_next_corner1
    checky4:
        ld hl, #Y
        add hl, de
        ld a, (hl)
        cp #72
        jr z, mover_derecha1
            jr check_above_next_corner1
        mover_derecha1:
        ld a, #0
         ld (indicador_patron) , a
        ld hl, #choose_axis_enemy_patron_mapa1
        call move_right_e
        jp sys_ai_patron_enemie_mapa1_end
    check_above_next_corner1:
      ld hl, #X
    add hl, de
    ld a, (hl)
    cp #64
    jr z, checky5
        jr check_above_next_corner2
    checky5:
        ld hl, #Y
        add hl, de
        ld a, (hl)
        cp #72
        jr z, check_when
            jr check_above_next_corner2
        check_when:
            ld a, (indicador_patron)
            cp #1
            jr z, mover_izquierda1
                jr mover_abajo1
        mover_izquierda1:
        ld hl, #choose_axis_enemy_patron_mapa1
        call move_left_e
        jp sys_ai_patron_enemie_mapa1_end
        mover_abajo1:
        ld hl, #choose_axis_enemy_patron_mapa1
        call move_down_e
        jp sys_ai_patron_enemie_mapa1_end
    check_above_next_corner2:
      ld hl, #X
    add hl, de
    ld a, (hl)
    cp #64
    jr z, checky6
        jr sys_ai_patron_enemie_mapa1_end
    checky6:
        ld hl, #Y
        add hl, de
        ld a, (hl)
        cp #115
        jr z, mover_arriba1
            jr sys_ai_patron_enemie_mapa1_end
        mover_arriba1:
        ld a, #1
         ld (indicador_patron) , a
        ld hl, #choose_axis_enemy_patron_mapa1
        call move_above_e
;; 56 72
;; 64 72
;; 64 101
sys_ai_patron_enemie_mapa1_end:
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

