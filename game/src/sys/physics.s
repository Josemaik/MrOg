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
contador_fisicas_jugador:
    .db #TIME_TO_UPDATE_PHYSICS_X
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
choose_axis_x_player::
    ld a, #1
    ld (choose_axis_player), a
ret
choose_axis_y_player::
    ld a, #0
    ld (choose_axis_player), a
ret
choose_axis_x_enemie::
    ld a, #1
    ld (choose_axis_enemy), a
ret
choose_axis_y_enemie::
    ld a, #0
    ld (choose_axis_enemy), a
ret
setvelocity::

    ld   a, (is_colliding_player)
    cp   #1
    jr   z, siguiente

    ;; check is direction is W
    ld hl , #direction
    add hl, de
    ld a, (hl)
    and #DIRECT_W
    cp #DIRECT_W
    jr z, set_velocity_x_W

    siguiente:
    
    ;; check is direction is A
    ld hl , #direction
    add hl, de
    ld a, (hl)
    and #DIRECT_A
    cp #DIRECT_A
    jr z, set_velocity_x_A
    ;; check is direction is D
    ld hl , #direction
    add hl, de
    ld a, (hl)
    and #DIRECT_D
    cp #DIRECT_D
    jr z, set_velocity_x_D
    ;; check is direction is S
    ld hl , #direction
    add hl, de
    ld a, (hl)
    and #DIRECT_S
    cp #DIRECT_S
    jr z, set_velocity_x_S

    set_velocity_x_A:
        ld      hl, #VX
        add     hl, de
        ld      (hl), #-1
        jr setvelocity_end
    set_velocity_x_D:
        ld      hl, #VX
        add     hl, de
        ld      (hl), #1
        jr setvelocity_end
    set_velocity_x_W:
        ld      hl, #VY
        add     hl, de
        ld      (hl), #-1
        jr setvelocity_end
    set_velocity_x_S:
        ld      hl, #VY
        add     hl, de
        ld      (hl), #1

    setvelocity_end:
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
        ld a, (choose_axis_player)
        cp #1
        jr z, move_x_axis
            jr move_y_axis
        
check_enemy:
    ld a, (choose_axis_enemy)
    cp #1
    jr z, move_x_axis
        jr move_y_axis
move_x_axis:
        ld hl, #contador_fisicas_jugador
        ld a, (hl)
        sub #1
        ld (hl), a
        jr nz, end_movex
        ld (hl),#TIME_TO_UPDATE_PHYSICS_X
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
