.module System_Input
.area _DATA
.area _CODE
.include "man/entity.h.s"
.include "cpctelera.h.s"
   ;; cpct
      .globl cpct_scanKeyboard_f_asm
      .globl cpct_isKeyPressed_asm
      .globl stop_sprite
      .globl desactive_animating
      .globl _man_entity_for_all_matching
      .globl active_animation
      .globl choose_axis_x_player
      .globl choose_axis_y_player
      .globl check_animation
      .globl man_game_create_bomb
      .globl set_xy_bomb
      .globl check_bomb_state
      .globl is_bomb_active
    .globl anim_W
   .globl anim_A
   .globl anim_S
   .globl anim_D
sys_input_update_for_one:
    ;; save entity
    push de
     ;; scan keyboard
    call cpct_scanKeyboard_f_asm
    ;; check letter O
    ld      hl, #Key_A
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_A_is_pressed
    ;; check letter P
    ld      hl, #Key_D
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_D_is_pressed
     ld      hl, #Key_W
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_W_is_pressed
     ld      hl, #Key_S
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_S_is_pressed
    ld      hl, #Key_Space
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_Space_is_pressed
    pop de
    ;; no se ha pulsado ninguna tecla
    call stop_sprite
    call desactive_animating
    jr sys_input_update_for_one_end
    sys_physics_A_is_pressed:
        pop de
        call active_animation
        call choose_axis_x_player
        ld bc, #anim_A
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_A
        call check_animation
        jr sys_input_update_for_one_end
    sys_physics_D_is_pressed:
        pop de
        call active_animation
        call choose_axis_x_player
        ld bc, #anim_D
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_D
        call check_animation
        jr sys_input_update_for_one_end
    sys_physics_W_is_pressed:
        pop de
        call active_animation
        call choose_axis_y_player
        ld bc, #anim_W
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_W
        call check_animation
        jr sys_input_update_for_one_end
    sys_physics_S_is_pressed:
        pop de
        call active_animation
        call choose_axis_y_player
        ld bc, #anim_S
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_S
        call check_animation
        jr sys_input_update_for_one_end
    sys_physics_Space_is_pressed:
        pop de
        ;; compruebo si hay bomba activa
        ld a , (is_bomb_active)
        cp #1
        jr z, sys_input_update_for_one_end ;; bomba activa
        ;; no bomba activa
        ;; guardo en pila x e y player
        call check_bomb_state
        ;; me guardo en pila bc 
        push bc
        ;; creo la entidad bomba
        call man_game_create_bomb
        ;; recojo bc de la pila
        pop bc
        ;; le pongo la x e y de la bomba la x e y del player
        call set_xy_bomb
    sys_input_update_for_one_end:
ret
_sys_input_update::          
        ld      bc, #sys_input_update_for_one
        ld      hl, #E_CMP_INPUT 
        call    _man_entity_for_all_matching
ret
