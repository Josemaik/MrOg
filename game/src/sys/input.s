.module System_Input
.area _DATA
.area _CODE

.include "input.h.s"
.include "man/entity.h.s"
.include "cpctelera.h.s"

   
sys_input_update_for_one:
    ;; save entity
    push de
    ;; check is player is died or alive
    ld a , (player_state)
    cp #1
    jp z, stop_sprite_player ;; si esta muerto no puedo moverme
    ld a , (player_reaparition_state)
    cp #1
    jp z, stop_sprite_player ;; si esta reapareciendo no puede moverse
     ;; scan keyboard
    call cpct_scanKeyboard_f_asm
    ;; check left
    ld      hl, #Key_O
    call cpct_isKeyPressed_asm
    jp nz, sys_physics_left_is_pressed

    ld      hl, #Joy0_Left
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_left_is_pressed

    ld      hl, #Joy1_Left
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_left_is_pressed

    ld      hl, #Key_CursorLeft
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_left_is_pressed

    ;; check right
    ld      hl, #Key_P
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_right_is_pressed
    ld      hl, #Key_CursorRight
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_right_is_pressed
    ld      hl, #Joy0_Right
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_right_is_pressed
    ld      hl, #Joy1_Right
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_right_is_pressed
    ;; check up
    ld      hl, #Key_Q
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_up_is_pressed
    ld      hl, #Key_CursorUp
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_up_is_pressed
    ld      hl, #Joy0_Up
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_up_is_pressed
    ld      hl, #Joy1_Up
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_up_is_pressed
    ;; check down
    ld      hl, #Key_A
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_down_is_pressed
    ld      hl, #Key_CursorDown
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_down_is_pressed
    ld      hl, #Joy0_Down
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_down_is_pressed
    ld      hl, #Joy1_Down
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_down_is_pressed
    ;; no se ha pulsado ninguna tecla
    stop_sprite_player:
    pop de
    call stop_sprite
    call desactive_animating
    jp sys_input_update_for_one_end
    sys_physics_left_is_pressed:
        pop de
        call active_animation_player
        ; call choose_axis_x_player
        ld bc, #anim_A
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_A
        call check_animation
        jr sys_input_update_for_one_end
    sys_physics_right_is_pressed:
        pop de
        call active_animation_player
        ; call choose_axis_x_player
        ld bc, #anim_D
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_D
        call check_animation
        jr sys_input_update_for_one_end
    sys_physics_up_is_pressed:
        pop de
        call active_animation_player
        ; call choose_axis_y_player
        ld bc, #anim_W
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_W
        call check_animation
        jr sys_input_update_for_one_end
    sys_physics_down_is_pressed:
        pop de
        call active_animation_player
        ; call choose_axis_y_player
        ld bc, #anim_S
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_S
        call check_animation
        jr sys_input_update_for_one_end
    sys_input_update_for_one_end:
ret
_sys_input_update::          
    ld de, #m_entities
    call sys_input_update_for_one

ret
