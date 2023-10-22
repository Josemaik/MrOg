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
move_down_e:
        call choose_axis_y_enemie2
        ld hl, #VX
        add hl, de
        ld (hl), #0
        ld hl, #VY
        add hl, de
        ld (hl), #1
ret
move_above_e:
        call choose_axis_y_enemie2
        ld hl, #VX
        add hl, de
        ld (hl), #0
        ld hl, #VY
        add hl, de
        ld (hl), #-1
ret
move_left_e:
        call choose_axis_x_enemie2
        ld hl, #VY
        add hl, de
        ld (hl), #0
        ld hl, #VX
        add hl, de
        ld (hl), #-1
ret
move_right_e:
        call choose_axis_x_enemie2
        ld hl, #VY
        add hl, de
        ld (hl), #0
        ld hl, #VX
        add hl, de
        ld (hl), #1
ret
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
sys_ai_hunt_player::
    ;; save entity
    push de
    ;; recorremos array de coliding enemy y copiamos en otro array las que son válidas(libres)
    ld de, #valid_directions       ;;; 2 4
    ld hl, #is_colliding_enemie    ;;; 1 0 1 0 
    ld b, #4 ;; longitud array
    ld c, #0 ;; direcciones libres
   bucle_dir_collided:
        ld a, b
        cp #1
        jr z, bucle_dir_collided_end
        ld a, (hl)
        cp #0
        jr z, save_direction ;; salvo las direcciones libres
        inc hl
        ld a, (indice)
        inc a
        ld (indice), a
        dec b
       jr bucle_dir_collided
    save_direction:
        inc c
        ld a, (indice)
        ld (de), a
        inc de
        ld a, (indice)
        inc a
        ld (indice), a
        inc hl
        dec b
        jr bucle_dir_collided
    bucle_dir_collided_end:
    push de
    ;; hacemos un random entre las que esten lbres
    call cpct_getRandom_xsp40_u8_asm
    and c ;; obtengo valor random en a de el numero de direcciones libres
    ;; save in c random number
    ld c , a
    pop de
    ld b, #4
    bucle_know_libre:
            ld a, b
            cp #1
            jr z, bucle_know_libre_end
            ld h, e
            ld l, d
            ld a , (hl)
            cp c
            jr z, move_enemy
            inc hl
            dec b
            jr bucle_know_libre
    move_enemy:
        ld b , a
        ld a, b
        cp #1
        jr z, move_above_e
        ld a, b
        cp #2
        jr z, move_down_e
        ld a, b
        cp #3
        jr z, move_right_e
        ld a, b
        cp #4
        jr z, move_left_e
    bucle_know_libre_end:
    ;; retrieve entity
    pop de
    ;; nos movemos en esa dirección
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

