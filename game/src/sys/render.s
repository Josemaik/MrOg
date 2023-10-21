.module System_Render
.include "cpctelera.h.s"

.area _DATA

    _m_palette::
        .ds 16
    spritefromscreen::
        .ds 128
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

    ;; retrieve the pointer to memory of video
        pop    hl
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RENDER BLENDED ENTITY ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
draw_blending_entity:
;     (2B DE) memory	Destination video memory pointer
; (1B C ) height	Sprite Height in bytes (>0)
; (1B B ) width	Sprite Width in bytes (>0) (Beware, not in pixels!)
; (2B HL) sprite	Source Sprite Pointer (array with pixel data)
;; hl point width, add de, save in c ,hl
            ;; save in stack screen pointer
            push hl
            ld hl,#WIDTH
            add hl,de
            ld b, (hl)
        ;; hl point height, add de, save in b ,hl
            ld hl,#HEIGHT
            add hl,de
            ld c, (hl)
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

        call cpct_drawSpriteBlended_asm
        pop hl
ret
;;;;;;;;;;;;;;;;;;;;
;; RENDER TILEMAP ;;
;;;;;;;;;;;;;;;;;;;;
sys_render_tilemap:
    ld   bc, #0x1914      ;; height and width - 25x20 en decimal
    ld   de, #0x30        ;; tilemap width    -    48 en decimal
    ld   hl, #_tiles_00   ;; pointer to tileset
    call cpct_etm_setDrawTilemap4x8_ag_asm

    ld   hl, #0xC000      ;; pointer memory location
    ld   de, #_tilemap_01 ;; pointer to the upper-left tilemap
    call cpct_etm_drawTilemap4x8_ag_asm

    ret
sys_get_screen_ptr:
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

        ;; load in DE start of the memory
            ld      de, #CPCT_VMEM_START_ASM
            ; back_buffer = .+2
            ;  ld      de, #0xC400

            call    cpct_getScreenPtr_asm
ret
;;;;;;;;;;;;;;;;;;;;;;;
;; RENDER ONE ENTITY ;;
;;;;;;;;;;;;;;;;;;;;;;;
;; IN => DE -> entity to update
;;
sys_render_update_for_one:

            ld hl, #TYPE
            add hl, de
            ld a, (hl)
            cp #E_TYPE_ENEMY
            jr z, render_blending_enemie ;; si es enemigo que rodea mapa, render con blending
            ;; el resto de entidades
    ;; erase last draw of entity
    call sys_render_draw_solid_box
    ;; save entity to update
            push    de
    call sys_get_screen_ptr
            ;; save last draw
            ld 4(ix), h
            ld 5(ix), l
    ;; retrieve entity of the stack
        pop     de
        push hl
        ;; copy lastdraw en lastdraw2
        ; ld hl, #last_draw
        ; add hl, de
        ; ld a, (hl)
        ; ld b, a
        ; inc hl
        ; ld a, (hl)
        ; ld c, a
        ; ld hl, #last_draw2
        ; add hl, de
        ; ld (hl), b
        ; inc hl
        ; ld (hl), c
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
            jr      z, sys_render_update_for_one_end 
        ;; draw entity -> _sys_render_draw_one_entity
        ;; IN =>  DE -> entity to draw
        ;; OUP => HL
        call    sys_render_draw_one_entity
        jr sys_render_update_for_one_end
    ;  sys_render_dont_draw:
    ;     call    sys_render_draw_solid_box
    render_blending_enemie:
        ;; dibujar en lastdraw el sprite de pantalla sacado antes de renderizar para borrar estela
            ld hl,#WIDTH
            add hl,de
            ld c, (hl)
        ;; hl point height, add de, save in b ,hl
            ld hl,#HEIGHT
            add hl,de
            ld b, (hl)
        ;;hl point sprite,add de and hl-> sprite
            ld hl, #spritefromscreen
         ;; save video memory pointer in DE and in the stack
            ld hl, #last_draw
            add hl, de
            ld d, (hl)
            inc hl
            ld e, (hl)
            push    de
            call cpct_drawSprite_asm
        pop de
        ; set blending mode
        ld l, #0xAE
        call cpct_setBlendMode_asm
        ;; save entity pointer
        push de
        ;; get screen pointer
        call sys_get_screen_ptr
        
        ;;;;;;;;;;;;;;;;;;;;;;;;
        ;; me creo un sprite de la pantalla antes de renderizar
        ld de, #spritefromscreen
        pop de
        push hl
        ld hl,#WIDTH
            add hl,de
            ld c, (hl)
        ;; hl point height, add de, save in b ,hl
            ld hl,#HEIGHT
            add hl,de
            ld b, (hl)
            pop hl
            push hl
        call cpct_getScreenToSprite_asm
        pop hl
        ;; retrieve entity pointer
        pop de
        ld 4(ix), h
        ld 5(ix), l
        push hl
        ld hl, #last_draw
        add hl, de
        ld a, 4(ix)
        ld (hl) , a
        inc hl
        ld a , 5(ix)
        ld (hl), a
        pop hl
        ;;;;;;;;;;;;;
        ;; render entity
        call draw_blending_entity
        
    sys_render_update_for_one_end:
ret
; change_screen:
; f_change_screen = . + 1
;     jp change_screen_to_C400
; change_screen_to_C400:
;     ld c, #0xC0
;     ld b, #0x32
;     call cpct_setCRTCReg_asm
;     ld a, #0xC0
;     ld (back_buffer), a
;     ld hl, #change_screen_to_C000
;     ld (f_change_screen), hl
; ret
; change_screen_to_C000:
;     ld c, #0x0C
;     ld b ,#0x30
;     call cpct_setCRTCReg_asm
;     ld a, #0xC4
;     ld (back_buffer), a
;     ld hl, #change_screen_to_C400
;     ld (f_change_screen), hl
; ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAll RENDER FOR ALL ENTITY :;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_sys_render_update::
        ld      bc, #sys_render_update_for_one
        ld      hl, #E_CMP_RENDER
        call    _man_entity_for_all_matching
        ; call change_screen
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