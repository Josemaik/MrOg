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
move_active::
    .db 0x00
;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;
sys_physics_check_keyboard:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; LEFT-RIGHT MOVEMEMENT     ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

    pop de
    jr sys_physics_check_keyboard_end
    ;; O is pressed
    sys_physics_A_is_pressed:
        ;; set movement active
        ld a, #1
        ld (move_active), a
        ;; set 1 to put the axis x active
        ld a, #1
        ld (choose_axis), a
         ;; retrieve entity
        pop de
        ;;set animation array
        ld hl, #anim_A
        push hl
        ld hl, #AnimFrame
        add hl, de
        pop bc
        ld (hl),c
        inc hl
        ld (hl),b
       
        ;; vx = 1
        ld      hl, #VX
        add     hl, de
        ld      (hl), #-1

        jr      sys_physics_check_keyboard_end

    sys_physics_D_is_pressed:
    ;; set movement active
        ld a, #1
        ld (move_active), a
        ;; set 1 to put the axis x active
        ld a, #1
        ld (choose_axis), a
        ;; retrieve entity
        pop de
        ;;set animation array
        ld hl, #anim_D
        push hl
        ld hl, #AnimFrame
        add hl, de
        pop bc
        ld (hl),c
        inc hl
        ld (hl),b
        
        ;; vx = 1
        ld      hl, #VX
        add     hl, de
        ld      (hl), #1

        jr      sys_physics_check_keyboard_end
    sys_physics_W_is_pressed:
    ;; set movement active
        ld a, #1
        ld (move_active), a
    ;; set 0 to put the axis y active
        ld a, #0
        ld (choose_axis), a
        ;; retrieve entity
        pop de
        ;;set animation array
        ld hl, #anim_W
        push hl
        ld hl, #AnimFrame
        add hl, de
        pop bc
        ld (hl),c
        inc hl
        ld (hl),b
        
        ;; vx = 1
        ld      hl, #VY
        add     hl, de
        ld      (hl), #-2

        jr      sys_physics_check_keyboard_end
    sys_physics_S_is_pressed:
     ;; set movement active
        ld a, #1
        ld (move_active), a
    ;; set 0 to put the axis y active
        ld a, #0
        ld (choose_axis), a
        ;; retrieve entity
        pop de
        ;;set animation array
        ld hl, #anim_S
        push hl
        ld hl, #AnimFrame
        add hl, de
        pop bc
        ld (hl),c
        inc hl
        ld (hl),b
        
        ;; vx = 1
        ld      hl, #VY
        add     hl, de
        ld      (hl), #2

        jr      sys_physics_check_keyboard_end
    jr sys_physics_check_keyboard_end

    sys_physics_check_keyboard_end:
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE PHYSICS FOR ONE ENTITY 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IN =>  DE -> entity to update                                      
;;pop de
sys_physics_update_for_one:
    ;; if entity have input
        ld      hl, #CMPs
        add     hl, de
        ld      a, (hl)

        and #E_CMP_INPUT
        cp  #E_CMP_INPUT
        jr z, sys_physics_check_kb
            jr sys_physics_no_check_kb
        sys_physics_check_kb:
            call sys_physics_check_keyboard
        sys_physics_no_check_kb:
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
