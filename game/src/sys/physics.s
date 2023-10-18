.module System_physics
.area _DATA
.area _CODE
.include "man/entity.h.s"
.include "physics.h.s"
.include "cpctelera.h.s"

;; if the value == 1 => X axis
;; if the value == 0 => Y axis
choose_axis::
    .db 0x00

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
    ld (choose_axis), a
ret
choose_axis_y::
    ld a, #0
    ld (choose_axis), a
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
        ld      (hl), #-2
        jr setvelocity_end
    set_velocity_x_S:
        ld      hl, #VY
        add     hl, de
        ld      (hl), #2

    setvelocity_end:
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE PHYSICS FOR ONE ENTITY 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IN =>  DE -> entity to update                                      
;;pop de
sys_physics_update_for_one:
    ;; if entity have input
        ; ld      hl, #CMPs
        ; add     hl, de
        ; ld      a, (hl)

        ; and #E_CMP_INPUT
        ; cp  #E_CMP_INPUT
        ; jr z, sys_physics_check_kb
        ;     jr sys_physics_no_check_kb
        ; sys_physics_check_kb:
        ;     call sys_physics_check_keyboard
        ; sys_physics_no_check_kb:
    ;;x+vx
    ;; go to entity->x and load in a
        ld a, (choose_axis)
        cp #1
        jr z, move_x_axis
            jr move_y_axis
move_x_axis:
        ld      hl, #X
        add     hl, de
        ld      a, (hl)    

    ;; go to entity-vx 
        ld      hl, #VX
        add     hl, de
    ;; a+hl
        add     (hl)

    ;; if in the end
        ; jr      c, sys_destroy_entity 
    ;; x > 0        
        ; jr      sys_save_vx
    ;; x < 0
    ; sys_destroy_entity:
    ;     call    _man_entity_set_for_destruction
    ;     jr end_physics
    ; sys_save_x:    
        ld      hl, #X
        add     hl, de
        ld      (hl), a

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
