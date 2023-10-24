.module System_Animation

.include "cpctelera.h.s"
.include "animations.h.s"
.include "man/entity.h.s"
.area _DATA

animation_state::
    .db 0x00
.area _CODE

desactive_animating::
    ld a, #0
    ld (animation_state), a
ret
active_animation::
    ld a, #1
    ld (animation_state), a
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; CHECK THE ANIMATION ACTIVE AND SET VELOCITY
;; IN -> bc => direction of entity
;;       4(ix) and 5(ix) => the array of the animation
check_animation::
        ld hl, #direction
        add hl, de
        ld a , (hl)
        and c
        cp c
        jr z, check_animation_end ;; si la animacion ya estaba en A
        ;; save duirection
        push bc
        ;;set animation array
        ;; retrieve animation here in hl
        ld l, 4(ix)
        ld h, 5(ix)
        push hl
        ;; go to entity-> animframe
        ld hl, #AnimFrame
        add hl, de
        ;; retrieve in bc the animation and load in animframe
        pop bc
        ld (hl),c
        inc hl
        ld (hl),b
        ;; retrieve direction
        pop bc
        ;; set direction
        ld hl, #direction
        add hl, de
        ld (hl), c
        
       check_animation_end:
ret
sys_animations_update_one_entity:
    ld hl, #TYPE
    add hl, de
    ld a, (hl)
    cp #E_TYPE_BOMB
    jr z, change_sprite;; si es bomba, va directamente a pasar al siguiente frame
    ld a , (animation_state)
    cp #1
    jr z, start_animating
        jr sys_animations_update_one_entity_end
    start_animating:
    ;; save in a the entity->animcounter
    ld hl, #AnimCounter
    add hl, de
    ld a, (hl)
    sub #1
    ld (hl), a
    ; if (a == 0)
    jr z, change_sprite
        jr sys_animations_update_one_entity_end
    change_sprite:

        ;; go to entity->animframe
        ld hl, #AnimFrame
        add hl, de
        ;; save memory pointer of frameanimation in bc
        ld c, (hl)
        inc hl
        ld b, (hl)
        ;; load memory pointer of frameanimation in hl and add space
        ld hl, #SPACE_OF_AIMATION
        add hl, bc
        ;; save new animation in bc
        ld c, l
        ld b, h
        ;; put the value of bc in hl
        ld hl, #AnimFrame
        add hl, de
        ld (hl) , c
        inc hl
        ld (hl), b

        ;; save the memory pointer of animframe
        ; push hl
        ;; save in a the time of animation
        ld		hl, #TIME
		add		hl, bc
		ld		a, (hl)
        ;; if (time == 0) gotostart else goto_next_sprite
        cp #0
        jr z, goto_start
            jr goto_next_sprite
        goto_start:
            ;; save in bc the value of next frame
            ld hl, #VAL_NEXT_FRAME
            add hl, bc
            ld c, (hl)
            inc hl
            ld b, (hl)
            ;; copy in entity->animframe the value of next frame(entity->animation->next)
            ld hl, #AnimFrame
            add hl, de
            ld (hl), c
            inc hl
            ld (hl), b
        goto_next_sprite:
            ld hl, #AnimFrame
            add hl, de

            ld c, (hl)
            inc hl
            ld b , (hl)

            push bc

            ld hl, #VAL_NEXT_FRAME
            add hl, bc

            ld c, (hl)
            inc hl
            ld b, (hl)
        
            ;;;load next sprite for animation
            ld hl, #SPRITE
            add hl, de
            ld (hl), c
            inc hl
            ld (hl), b

            pop bc
            ;; put the counter to 12
            ld hl, #TIME
            add hl, bc
            ld a, (hl)

            ld hl, #AnimCounter
            add hl, de
            ld (hl), a
    sys_animations_update_one_entity_end:
ret
_sys_animations_update::
        ld      bc, #sys_animations_update_one_entity
        ld      hl, #E_CMP_ANIMATED
        call    _man_entity_for_all_matching
ret
