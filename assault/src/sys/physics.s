.module System_physics
.area _DATA
.area _CODE
.include "man/entity.h.s"
.include "physics.h.s"
.include "cpctelera.h.s"

;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;
sys_physics_check_keyboard:
    ;; save entity
    push de
    ;; scan keyboard
    call cpct_scanKeyboard_f_asm
    ;; check letter O
    ld      hl, #Key_O
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_o_is_pressed
    ;; check letter P
    ld      hl, #Key_P
    call cpct_isKeyPressed_asm
    jr nz, sys_physics_P_is_pressed

    pop de
    jr sys_physics_check_keyboard_end
    ;; O is pressed
    sys_physics_o_is_pressed:
        ;; retrieve entity
        pop de
        ;; vx = 1
        ld      hl, #VX
        add     hl, de
        ld      (hl), #-1

        jr      sys_physics_check_keyboard_end

    sys_physics_P_is_pressed:
        ;; retrieve entity
        pop de
        ;; vx = 1
        ld      hl, #VX
        add     hl, de
        ld      (hl), #1

        jr      sys_physics_check_keyboard_end

        sys_physics_check_keyboard_end:
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE PHYSICS FOR ONE ENTITY 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IN =>  DE -> entity to update                                      
;;pop de
sys_physics_update_for_one:
    ;; if entity have input
        ld      hl, #TYPE
        add     hl, de
        ld      a, (hl)

        and #E_TYPE_INPUT
        cp  #E_TYPE_INPUT
        jr z, sys_physics_check_kb
            jr sys_physics_no_check_kb
        sys_physics_check_kb:
            call sys_physics_check_keyboard
        sys_physics_no_check_kb:
    ;;x+vx
    ;; go to entity->x and load in a
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
    ;; y+vy
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
        ld      hl, #E_TYPE_MOVABLE
        call    _man_entity_for_all_matching
ret
