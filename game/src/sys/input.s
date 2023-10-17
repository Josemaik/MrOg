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
      .globl choose_axis_x
      .globl choose_axis_y
      .globl check_animation
        .globl anim_W
   .globl anim_A
   .globl anim_S
   .globl anim_D
sys_input_update_for_one:
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

    ;; no se ha pulsado ninguna tecla
    call stop_sprite
    call desactive_animating
    jr sys_input_update_for_one_end
    sys_physics_A_is_pressed:
        call active_animation
        call choose_axis_x
        ld bc, #anim_A
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_A
        call check_animation
        jr sys_input_update_for_one_end
    sys_physics_D_is_pressed:
        call active_animation
        call choose_axis_x
        ld bc, #anim_D
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_D
        call check_animation
        jr sys_input_update_for_one_end
    sys_physics_W_is_pressed:
        call active_animation
        call choose_axis_y
        ld bc, #anim_W
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_W
        call check_animation
        jr sys_input_update_for_one_end
    sys_physics_S_is_pressed:
        call active_animation
        call choose_axis_y
        ld bc, #anim_S
        ld 4(ix), c
        ld 5(ix), b
        ld bc, #DIRECT_S
        call check_animation
        jr sys_input_update_for_one_end
    sys_input_update_for_one_end:
ret


    ; ;; save entity
    ; push de
    ; ;; scan keyboard
    ; call cpct_scanKeyboard_f_asm
    ; ;; check letter O
    ; ld      hl, #Key_A
    ; call cpct_isKeyPressed_asm
    ; jr nz, sys_physics_A_is_pressed
    ; ;; check letter P
    ; ld      hl, #Key_D
    ; call cpct_isKeyPressed_asm
    ; jr nz, sys_physics_D_is_pressed
    ;  ld      hl, #Key_W
    ; call cpct_isKeyPressed_asm
    ; jr nz, sys_physics_W_is_pressed
    ;  ld      hl, #Key_S
    ; call cpct_isKeyPressed_asm
    ; jr nz, sys_physics_S_is_pressed

    ; pop de
    ; ;; nothing key is pressed
    
    ; ;; parar animacion
   
    ; jr sys_physics_check_keyboard_end
    ; ;; O is pressed
    ; sys_physics_A_is_pressed:
    ;     ;; set movement active
    ;     ld a, #1
    ;     ld (move_active), a
    ;     ;; set 1 to put the axis x active
    ;     ld a, #1
    ;     ld (choose_axis), a
    ;      ;; retrieve entity
    ;     pop de
    ;     ;;check animations
    ;     ld hl, #direction
    ;     add hl, de
    ;     ld a , (hl)
    ;     and #DIRECT_A
    ;     cp #DIRECT_A
    ;     jr z, goto_velocity1 ;; si la animacion ya estaba en A
    ;     ;;set animation array
    ;     ld hl, #anim_A
    ;     push hl
    ;     ld hl, #AnimFrame
    ;     add hl, de
    ;     pop bc
    ;     ld (hl),c
    ;     inc hl
    ;     ld (hl),b
    ;     ;; set direction
    ;     ld hl, #direction
    ;     add hl, de
    ;     ld (hl), #DIRECT_A
        
    ;    goto_velocity1:
    ;     ;; vx = 1
    ;     ld      hl, #VX
    ;     add     hl, de
    ;     ld      (hl), #-1

    ;     jr      sys_physics_check_keyboard_end

    ; sys_physics_D_is_pressed:
    ; ;; set movement active
    ;     ld a, #1
    ;     ld (move_active), a
    ;     ;; set 1 to put the axis x active
    ;     ld a, #1
    ;     ld (choose_axis), a
    ;     ;; retrieve entity
    ;     pop de
    ;     ;;check animations
    ;     ld hl, #direction
    ;     add hl, de
    ;     ld a , (hl)
    ;     and #DIRECT_D
    ;     cp #DIRECT_D
    ;     jr z, goto_velocity ;; si la animacion ya estaba en A
    ;     ; ;;set animation array
    ;     ld hl, #anim_D
    ;     push hl
    ;     ld hl, #AnimFrame
    ;     add hl, de
    ;     pop bc
    ;     ld (hl),c
    ;     inc hl
    ;     ld (hl),b
    ;     ; set direction
    ;     ld hl, #direction
    ;     add hl, de
    ;     ld (hl), #DIRECT_D
        
    ;    goto_velocity:
    ;     ;; vx = 1
    ;     ld      hl, #VX
    ;     add     hl, de
    ;     ld      (hl), #1

    ;     jr      sys_physics_check_keyboard_end
    ; sys_physics_W_is_pressed:
    ; ;; set movement active
    ;     ld a, #1
    ;     ld (move_active), a
    ; ;; set 0 to put the axis y active
    ;     ld a, #0
    ;     ld (choose_axis), a
    ;     ;; retrieve entity
    ;     pop de
    ;     ; ld hl, #direction
    ;     ; add hl, de
    ;     ; ld a , (hl)
    ;     ; and #DIRECT_D
    ;     ; cp #DIRECT_D
    ;     ; jr z, goto_velocity ;; si la animacion ya estaba en A
    ;     ; ; ;;set animation array
    ;     ; ld hl, #anim_D
    ;     ; push hl
    ;     ; ld hl, #AnimFrame
    ;     ; add hl, de
    ;     ; pop bc
    ;     ; ld (hl),c
    ;     ; inc hl
    ;     ; ld (hl),b
    ;     ; ; set direction
    ;     ; ld hl, #direction
    ;     ; add hl, de
    ;     ; ld (hl), #DIRECT_D
        
    ;     ; goto_velocity2:
        
        
    ;     ;; vx = 1
    ;     ; ld      hl, #VY
    ;     ; add     hl, de
    ;     ; ld      (hl), #-2

    ;     ; jr      sys_physics_check_keyboard_end
    ; sys_physics_S_is_pressed:
    ;  ;; set movement active
    ; ;     ld a, #1
    ; ;     ld (move_active), a
    ; ; ;; set 0 to put the axis y active
    ; ;     ld a, #0
    ; ;     ld (choose_axis), a
    ; ;     ;; retrieve entity
    ; ;     pop de
    ; ;     ;;check animations
    ;     ; ld hl, #direction
    ;     ; add hl, de
    ;     ; ld a , (hl)
    ;     ; and #DIRECT_S
    ;     ; cp #DIRECT_S
    ;     ; jr z, goto_velocity3 ;; si la animacion ya estaba en A
    ;     ; ;;set animation array
    ;     ; ld hl, #anim_S
    ;     ; push hl
    ;     ; ld hl, #AnimFrame
    ;     ; add hl, de
    ;     ; pop bc
    ;     ; ld (hl),c
    ;     ; inc hl
    ;     ; ld (hl),b
    ;     ; ;; set direction
    ;     ; ld hl, #direction
    ;     ; add hl, de
    ;     ; ld (hl), #DIRECT_S
        
    ;     ; goto_velocity3:
        
        
    ;     ;; vx = 1
    ;     ; ld      hl, #VY
    ;     ; add     hl, de
    ;     ; ld      (hl), #2

    ;     ; jr      sys_physics_check_keyboard_end
_sys_input_update::          
        ld      bc, #sys_input_update_for_one
        ld      hl, #E_CMP_INPUT 
        call    _man_entity_for_all_matching
ret
