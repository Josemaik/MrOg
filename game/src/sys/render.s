.module System_Render
.include "cpctelera.h.s"

.area _DATA

    _m_palette::
        .ds 16
    spritefromscreen::
        .ds 128
    contador_draw_map::
        .db #CONTADOR_MAPA
.area _CODE
.include "man/entity.h.s"
.include "render.h.s"

;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;
sys_render_life_or_bomb::
            ;; load in c the width
            ld c, #0x04
            ;; load in b the height
            ld b, #0x08
            ;; load in hl the sprite
            ld hl, #sprite_vida
            add hl,de
            ;; save array vidas
            push de
        ;; save first byte in L
            ld      e, l
            ld      d, h
            ld      a, (de)
            ld      l, a
        ;; add 1 to de and save second byte in H
            inc     de
            ld      a, (de)
            ld      h, a
             ;; retrieve array de vidas
            pop de
            ;; save array de vidas
            push de
            ;; save sprite
            push hl
        ;; save all register that are eliminated in fuction
            ; push de
            push bc
        ;; obtener posicion de memoria in hl
            call sys_get_screen_ptr_life_or_bomb
        ;; load memory pointer in de
            ld e , l
            ld d, h
            ;; retrieve with and height
            pop bc
            ;; retrive sprite
            pop hl
            call cpct_drawSprite_asm
            pop de
ret
sys_get_screen_ptr_life_or_bomb:
            ld      hl, #x_vida
            add     hl, de
            ld      c, (hl)
        ;; get to entity->y and save to B
            ld      hl, #y_vida
            add     hl, de
            ld      b, (hl)
        ;; load in DE start of the memory
            ld      de, #CPCT_VMEM_START_ASM

            call    cpct_getScreenPtr_asm
ret

sys_render_char::
                ;; save value of char
                push de
                ;; save  x y position
                push bc
                ;; l -> foreground
                ;; h -> background
                ld l, #4
                ld h, #0
                call cpct_setDrawCharM0_asm         
              ;; HL -> video memory
                ld      de, #0xC000
            ;; retrieve x y position
                pop bc
                call    cpct_getScreenPtr_asm
            ;; retrieve value of char
                pop de 
                call    cpct_drawCharM0_asm  
ret
sys_render_draw_solid_box:
    push hl
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
            pop hl
            push de
        ;; load last draw in de
            ; ld hl, #last_draw
            ; add hl, de
            ; ld d, (hl)
            ; inc hl
            ; ld e, (hl)
            ld e , l
            ld d, h

        call cpct_drawSolidBox_asm
        pop de
    ret

sys_render_draw_solid_box_player::
        ;; get to entity->x and save to C
            ld      c, X(ix)

        ;; get to entity->y and save to B
            ld      b, Y(ix)

        ;; load in DE start of the memory
            ld      de, #CPCT_VMEM_START_ASM

            call    cpct_getScreenPtr_asm ;; --> hl
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
        
            ld c, WIDTH(ix)
            ld b, HEIGHT(ix)

        ;; load last draw in de
            ex de, hl

        call cpct_drawSolidBox_asm
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
            ;; save entity
            push de
            ;; save screen pointer
            ; push hl
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
         ;; load in DE , the screen pointer
            ; pop de
            ld d, 4(ix)
            ld e, 5(ix)
            call cpct_drawSpriteBlended_asm
            ;; retrieve entity
            pop de
ret
;;;;;;;;;;;;;;;;;;;;
;; RENDER TILEMAP ;;
;;;;;;;;;;;;;;;;;;;;
sys_render_tilemap::
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
            cp #E_TYPE_BOMB
            jr z, render_blending_enemie ;; si es enemigo que rodea mapa, render con blending
            ;; save entity to update
            push    de
            ;; get screen pointer
            call sys_get_screen_ptr
            ;; retrieve entity of the stack
            pop     de
            ;; load in the stack screen pointer
            push hl

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
            jr sys_render_update_for_one_end
        render_blending_enemie:
                ; ld a , (contador_draw_map)
                ; dec a
                ; ld (contador_draw_map), a
                ; jr nz, continue
                ; call sys_render_tilemap
                ; ld a, #CONTADOR_MAPA
                ; ld (contador_draw_map), a
                ; continue:
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; dibujar en lastdraw el sprite de pantalla sacado antes de renderizar para borrar estela
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ; save entity
            ;     push de
            ;     ld hl,#WIDTH
            ;     add hl,de
            ;     ld c, (hl)
            ; ; hl point height, add de, save in b ,hl
            ;     ld hl,#HEIGHT
            ;     add hl,de
            ;     ld b, (hl)
            ; ;hl point sprite,add de and hl-> sprite
            ;     ld hl, #spritefromscreen
            ; ; save video memory pointer in DE and in the stack
            ;     ld hl, #last_draw
            ;     add hl, de
            ;     ld d, (hl)
            ;     inc hl
            ;     ld e, (hl)
            ;     call cpct_drawSprite_asm
            ;     pop de
            ;     ; ;;load entity
            ;     ; pop de
            ;     ; save netity
                push de
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ;;; OBTENEMOS PUNTERO DE PANTALLA
                ;;;;;;;;;;;;;;;;;;;;;;;;;;,
                ;; get screen pointer
                call sys_get_screen_ptr
                ;; retrieve entity
                pop de
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ;;; CARGAMOS EN LASTDRAW EL PUNTERO DE PANTALLA
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ;;  save in stack screen pointer
                ld 4(ix), h
                ld 5(ix), l
                ; ;; save in stack screen pointer
                ; push hl
                ; ; ;; load in last draw the screen pointer
                ; ld hl, #last_draw
                ; add hl, de
                ; ld a, 4(ix)
                ; ld (hl) , a
                ; inc hl
                ; ld a , 5(ix)
                ; ld (hl), a
                ;; retrieve screen pointer
                ; pop hl
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ;;;; HACEMOS UN SPRITE DE LA POSICION DE PANTALLA ANTES DE RENDERIZAR
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ;;save entity pointer
                ; push de
                ; ; push hl
                ; ld hl,#WIDTH
                ; add hl,de
                ; ld c,(hl)
                ; ;; hl point height, add de, save in b ,hl
                ; ld hl,#HEIGHT
                ; add hl,de
                ; ld b, (hl)
                ; ;; sprite array
                ; ld de, #spritefromscreen
                ; ;; screen pointer
                ; ; pop hl
                ; ; push hl
                ; ld l , 4(ix)
                ; ld h,  5(ix)
                ; call cpct_getScreenToSprite_asm
                ; ; retrieve screen pointer
                ; ; pop hl
                ; ;; retrieve entity
                ; pop de
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ;;; RENDER WITH BLENDING MODE
                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                ; set blending mode
                ld l, #0xB6 ;; OR
                ;; save screen pointer
                ; push hl
                call cpct_setBlendMode_asm
                ;; render enemie
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
        ; ld a , (contador_draw_map)
        ; dec a
        ; ld (contador_draw_map), a
        ; jr nz, continue
        ; call sys_render_tilemap
        ; ld a, #CONTADOR_MAPA
        ; ld (contador_draw_map), a
        ; continue:
        ;;call change_screen
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