.module System_physics
.area _DATA
.area _CODE
.include "man/entity.h.s"
.include "physics.h.s"
.include "cpctelera.h.s"

;; if the value == 1 => X axis
;; if the value == 0 => Y axis
choose_axis_player::
    .db 0x00
choose_axis_enemy::
    .db 0x00
choose_axis_enemy_hunter::
    .db 0x00
choose_axis_enemy_hunter2::
    .db 0x00
choose_axis_enemy_patron_mapa1::
    .db 0x00
contador_fisicas_jugador:
    .db #TIME_TO_UPDATE_PHYSICS_X_PLAYER
;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;
stop_sprite::
;;parar sprite
    ld      hl, #VY
    add     hl, de
    ld      (hl),#0
    ld      hl, #VX
    add     hl, de
    ld      (hl),#0
ret
choose_axis_x::
    ld a, #1
    ld (hl), a
ret
choose_axis_y::
    ld a, #0
    ld (hl), a
ret
move_down_e::
        call choose_axis_y
        ; return_hear0:
        ld hl, #VX
        add hl, de
        ld (hl), #0
        ld hl, #VY
        add hl, de
        ld (hl), #1
ret
move_above_e::
        call choose_axis_y
        ld hl, #VX
        add hl, de
        ld (hl), #0
        ld hl, #VY
        add hl, de
        ld (hl), #-1
ret
move_left_e::
        call choose_axis_x
        ld hl, #VY
        add hl, de
        ld (hl), #0
        ld hl, #VX
        add hl, de
        ld (hl), #-1
ret
move_right_e::
        call choose_axis_x
        ld hl, #VY
        add hl, de
        ld (hl), #0
        ld hl, #VX
        add hl, de
        ld (hl), #1
ret
set_velocity_x_W::
    ld   a, (is_colliding_player)
    cp   #1
    jr   z, set_velocity_x_W_end
    ld hl, #choose_axis_player
    call move_above_e
    set_velocity_x_W_end:
ret
set_velocity_x_A::
    ld   a, (is_colliding_player + 3)
    cp   #1
    jr   z, set_velocity_x_A_end
    ld hl, #choose_axis_player
    call move_left_e
    set_velocity_x_A_end: 
ret
set_velocity_x_S::
    ld   a, (is_colliding_player + 1)
    cp   #1
    jr   z, set_velocity_x_S_end
    ld hl, #choose_axis_player
    call move_down_e
    set_velocity_x_S_end: 
ret
set_velocity_x_D::
    ld   a, (is_colliding_player + 2)
    cp   #1
    jr   z, set_velocity_x_D_end 
    ld hl, #choose_axis_player
    call move_right_e
    set_velocity_x_D_end:
ret
setVelocity:
    ld a, c
    cp #DIRECT_W
        jr z, set_velocity_x_W
   ld a, c
   cp #DIRECT_S
        jr z, set_velocity_x_S
   ld a , c
   cp #DIRECT_A
        jr z, set_velocity_x_A
   ld a , c
   cp #DIRECT_D
        jr z, set_velocity_x_D
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE PHYSICS FOR ONE ENTITY 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IN =>  DE -> entity to update                                      
;;pop de
sys_physics_update_for_one:
        ld hl, #TYPE
        add hl, de
        ld a, (hl)
        cp #E_TYPE_ENEMY
        jr z, check_enemy
        ;; comprobar jugador
        ld a, (hl)
        cp #E_TYPE_PLAYER
        jr z, check_player
        ;; es enemygo hunter vers
        ld a, (hl)
        cp #E_TYPE_ENEMY2
        jr z, check_enemy_2
        ;; es enemigo hunter hor
        ld a, (hl)
        cp #E_TYPE_ENEMY3
        jr z, check_enemy_3
        ;;enemygo patron mapa 1
        ld a, (choose_axis_enemy_patron_mapa1)
         cp #1
         jr z, move_x_axis
            jr move_y_axis
         
check_player:
    ld a , (animation_state_player)
    cp #1
    jr z, goto_setvelocity
    ret
    goto_setvelocity:
    ld  hl, #direction
    add hl, de
    ld a, (hl)
    ld c, a
    call setVelocity
    ld a, (choose_axis_player)
        cp #1
        jr z, move_x_axis
            jr move_y_axis
check_enemy:
    ld a, (choose_axis_enemy)
    cp #1
    jr z, move_x_axis
        jr move_y_axis
check_enemy_2:
         
        ld a, (choose_axis_enemy_hunter)
         cp #1
         jr z, move_x_axis
            jr move_y_axis
check_enemy_3:
ld a, (choose_axis_enemy_hunter2)
         cp #1
         jr z, move_x_axis
            jr move_y_axis
move_x_axis:
        ld hl, #contador_fisicas_jugador
        ld a, (hl)
        sub #1
        ld (hl), a
        jr nz, end_movex
        ld (hl),#TIME_TO_UPDATE_PHYSICS_X_PLAYER
        ld      hl, #VX
        add     hl, de
        ld      a, (hl)    

    ;; go to entity-vx 
        ld      hl, #X
        add     hl, de
    ;; a+hl
        add     (hl)

        ld (hl), a

    end_movex:
        jr end_physics
    ;; y+vy
    move_y_axis:
            ;; go to entity->vy
                ld      hl, #VY
                add     hl, de
                ld      a, (hl)
            ;; go to entity->y and add it to vy
                ld      hl, #Y
                add     hl, de

                add     (hl)
            ;; load it in entity->y
                ld      (hl), a
        

    end_physics:
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAll PHYSICS FOR ALL ENTITY :;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_sys_physics_update::          
        ld      bc, #sys_physics_update_for_one
        ld      hl, #E_CMP_MOVABLE
        call    _man_entity_for_all_matching
ret
