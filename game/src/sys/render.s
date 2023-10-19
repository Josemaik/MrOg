.module System_Render
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

sys_render_draw_solid_box:  
    ;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; draw solid box
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;(2B DE) memory	Video memory pointer to the upper left box corner byte
    ;;(1B A ) colour_pattern	1-byte colour pattern (in screen pixel format) to fill the box with
    ;;(1B C ) width	Box width in bytes [1-64] (Beware!  not in pixels!)
    ;;(1B B ) height	Box height in bytes (>0)
    ;;
    ;;
        ;; de => memory position of entity
        ;;a->colour pattern
            ld a, #0
        ;; hl point width, add de, save in c ,hl
            ld hl,#WIDTH
            add hl,de
            ld c, (hl)
        ;; hl point height, add de, save in b ,hl
            ld hl,#HEIGHT
            add hl,de
            ld b, (hl)

            push de
        ;; load last draw in de
            ld hl, #last_draw
            add hl, de
            ld d, (hl)
            inc hl
            ld e, (hl)
  
        call cpct_drawSolidBox_asm
        pop de
ret
sys_render_draw_one_entity:
    ;; save hl in stck
        push hl
    ;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; draw sprite
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;(2B HL) sprite	Source Sprite Pointer (array with pixel data)
    ;;(2B DE) memory	Destination video memory pointer
    ;;(1B C ) width	Sprite Width in bytes [1-63] (Beware, not in pixels!)
    ;;(1B B ) height	Sprite Height in bytes (>0)
    ;;
    ;;
        ;; de => memory position of entity
        ;; hl point width, add de, save in c ,hl
            ld hl,#WIDTH
            add hl,de
            ld c, (hl)
        ;; hl point height, add de, save in b ,hl
            ld hl,#HEIGHT
            add hl,de
            ld b, (hl)
        ;;hl point sprite,add de and hl-> sprite
            ld hl, #SPRITE
            add hl,de
        ;; save first byte in L
            ld      e, l
            ld      d, h
            ld      a, (de) 
            ld      l, a
        ;; add 1 to de and save second byte in H
            inc     de
            ld      a, (de)
            ld      h, a
         ;; save video memory pointer in DE and in the stack
            pop de
            push    de

        call cpct_drawSprite_asm

    ;; save the pointer to memory of video
        pop    hl
    ret

;;;;;;;;;;;;;;;;;;;;
;; RENDER TILEMAP ;;
;;;;;;;;;;;;;;;;;;;;
sys_render_tilemap:
    ld   bc, #0x1914      ;; height and width
    ld   de, #0x30        ;; tilemap width
    ld   hl, #_tiles_0    ;; pointer to tileset
    call cpct_etm_setDrawTilemap4x8_ag_asm

    ld   hl, #0xC000      ;; pointer memory location
    ld   de, #_tilemap_01 ;; pointer to the upper-left tilemap
    call cpct_etm_drawTilemap4x8_ag_asm

    ret

;;;;;;;;;;;;;;;;;;;;;;;
;; RENDER ONE ENTITY ;;
;;;;;;;;;;;;;;;;;;;;;;;
;; IN => DE -> entity to update
;;
sys_render_update_for_one:
    ;; erase last draw of entity
    call sys_render_draw_solid_box

;;cpct_getScreenPtr_asm
    ;; IN => DE -> screen start
    ;;       C  -> x
    ;;       B  -> y
    ;; OUT =>  HL -> memory direction

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

        ;; load in DE start of the memory
            ld      de, #CPCT_VMEM_START_ASM

            call    cpct_getScreenPtr_asm
            ;; save last draw
            ld 4(ix), h
            ld 5(ix), l
    ;; retrieve entity of the stack
        pop     de
        push hl
        ;; set entity->last draw
        ld hl, #last_draw
        add hl, de
        ld a, 4(ix)
        ld (hl) , a
        inc hl
        ld a , 5(ix)
        ld (hl), a

        ;; go to entity->type
            ld      hl, #TYPE
            add     hl, de

        ;; load in A entity->type and compare with #E_TYPE_DEAD
            ld      a, (hl)
            pop hl
            and     #E_TYPE_DEAD
            cp      #E_TYPE_DEAD
            jr      z, sys_render_dont_draw 
        ;; draw entity -> _sys_render_draw_one_entity
        ;; IN =>  DE -> entity to draw
        ;; OUP => HL
        call    sys_render_draw_one_entity
        jr sys_render_update_for_one_end
    sys_render_dont_draw:
        call    sys_render_draw_solid_box
    sys_render_update_for_one_end:
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAll RENDER FOR ALL ENTITY :;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_sys_render_update::
        ld      bc, #sys_render_update_for_one
        ld      hl, #E_CMP_RENDER
        call    _man_entity_for_all_matching
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
        cpctm_setBorder_asm HW_WHITE
    ;; set the palete -> cpct_setPalette_asm
        ;; INPUTS ;;
            ;; HL -> pointer of the palette
            ;; DE -> size of the palette
        ld       hl, #_main_palette
        ld       de, #16
        call     cpct_setPalette_asm


    ;; cargar mapa
     call sys_render_tilemap

    ret