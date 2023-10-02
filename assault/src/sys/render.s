.module Render_Stars
.include "cpctelera.h.s"

.area _DATA

    _m_palette::
        .ds 16

.area _CODE
.include "man/entity.h.s"
.include "render.h.s"

;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;; ERASE ENTITY ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; INPUTS ;;                                    ;;
        ;; DE -> entity to erase                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; NOTES                                        ;;
        ;; to erase an entity we draw a 0 in x+vx   ;;    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;
;; DRAW ENTITY ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; INPUTS ;;                            ;;
        ;; DE -> entity to draw             ;;
    ;; OUPUTS ;;                            ;;
        ;; HL -> prevptr            ;;      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sys_render_draw_one_entity:

    ;; get the memory that makes reference to an x,y position -> cpct_getScreenPtr_asm        
        ;; INPUTS
            ;; DE -> screen start
            ;; C  -> x
            ;; B  -> y
        ;; OUTPUTS
            ;; HL -> memory direction    

        ;; get to entity->x and save to C
            ld      hl, #X
            add     hl, de
            ld      c, (hl)

        ;; get to entity->y and save to B
            ld      hl, #Y
            add     hl, de
            ld      b, (hl)

        ;; save entity to update
            push    de

        ;; load in DE the start of the memory
            ld      de, #CPCT_VMEM_START_ASM

        ;;call function
            call    cpct_getScreenPtr_asm

    ;; retrieve the saved entity
        pop     de      

    ;; save the pointer to memory of video
        push    hl     

    ;; get to entity->width and save in c
        ld      hl, #Width
        add     hl, de
        ld      c, (hl)
    ;; get to entity->height and save in b
        ld      hl, #Height
        add     hl, de
        ld      b, (hl)
    ;; ;; get to entity->sprite and save in de ;; de == pvmem
        ld      hl, #sprite
        add     hl, de
        ex de, hl
    ;;  load in hl source sprite pointer
        ld hl, #sprite
    ;; draw sprite
        call cpct_drawSprite_asm
    ;; retrieve the pointer to video memory and set it to the color of entity
        ; pop     hl     
        ; ld      (hl), a
    ret


;;;;;;;;;;;;;;;;;;;;;;;
;; RENDER ONE ENTITY ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; INPUTS ;;                            ;;
        ;; DE -> entity to update           ;;    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sys_render_update_for_one:

    ;; save the pointer
        push    de

    ;;erase entity -> _sys_render_erase_one_entity
        ;; INPUTS ;;
            ;; DE -> entity to erase
    

    ;; retrieve the pointer
        pop     de

    ;; if entity set for destruction dont draw
        ;; go to entity->type
            ld      hl, #TYPE
            add     hl, de

        ;; load in A entity->type and compare with #deadtype
            ld      a, (hl)
            and     #E_TYPE_DEAD
            cp      #E_TYPE_DEAD
            jr      z, sys_render_dont_draw    ;; entity was set 4 destrcution

        ;; draw entity -> _sys_render_draw_one_entity
            ;; INPUTS ;;
                ;; DE -> entity to draw
            ;; OUPUTS ;;
                ;; HL -> prevptr
        call    sys_render_draw_one_entity

    sys_render_dont_draw:

    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAll RENDER FOR ALL ENTITY :;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_sys_render_update::

    ;; for all entities -> sys_physics_update_for_one
        ;; INPUTS ;;
            ;; BC -> memory position of the function

        ld      bc, #sys_render_update_for_one
        call    _man_entity_for_all

    ret



;;;;;;;;;;;;;;;;;;;;;;
;; CAll RENDER INIT :;
;;;;;;;;;;;;;;;;;;;;;;
_sys_render_init::

    ;; set the video mode to 0 to draw pixels -> cpct_setVideoMode_asm
        ;; INPUTS ;;
            ;; C -> mode value
        ld       c, #0
        call     cpct_setVideoMode_asm

    ;; paint border black 
        cpctm_setBorder_asm HW_BLACK

    ;; load values into plalette
        ld      hl, #HW_BLACK        
        ld      (_m_palette), hl

        ;; for to load 15 white colors
            ld      a, #15
            ld      hl, #_m_palette

            render_init_for:

                ;; add 1 to last mem and save white                    
                    inc     hl
                    ld      (hl), #HW_BRIGHT_WHITE

                ;; decrement a and compare with 0
                    sub     #1
                    jr      z, render_end_for

                ;; redo for
                    jr      render_init_for

            render_end_for:

        ;; palette [2] = normal white
            ld      hl, #_m_palette
            ld      de, #2
            add     hl, de
            ld      (hl), #HW_WHITE

    ;; set the palete -> cpct_setPalette_asm
        ;; INPUTS ;;
            ;; HL -> pointer of the palette
            ;; DE -> size of the palette
        ld       hl, #_m_palette
        ld       de, #16
        call     cpct_setPalette_asm

    ret