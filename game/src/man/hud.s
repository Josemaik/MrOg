.module HUD_Manager

.include "cpctelera.h.s"
;; .include "game.h.s"
;; .include "entity.h.s"
.include "hud.h.s"
.area _DATA
sprite_borrar_vida:
   .db 0x00, 0x00, 0x00, 0x00
    .db 0x00, 0x00, 0x00, 0x00
	.db  0x00, 0x00, 0x00, 0x00
	.db 0x00, 0x00, 0x00, 0x00
	.db 0x00, 0x00, 0x00, 0x00
	.db 0x00, 0x00, 0x00, 0x00
	.db 0x00, 0x00, 0x00, 0x00
	.db 0x00, 0x00, 0x00, 0x00
array_vidas::
    .db 0x00        ;; 0 indica vivo y 1 es muerto
    .db 0x05, 0x0a ;; posición x e y
    .dw  _spr_vidas;; sprite
    .db 0x00
    .db 0x0a, 0x0a ;; posición
    .dw  _spr_vidas;; sprite
    .db 0x00
    .db 0x0f, 0x0a ;; posición
    .dw  _spr_vidas;; sprite
array_bombas::
    .db 0x00
    .db 0x39, 0x0a ;; posición
    .dw  _spr_bombahud;; sprite
    .db 0x00
    .db 0x3e, 0x0a ;; posición
    .dw  _spr_bombahud;; sprite
    .db 0x00
    .db 0x43, 0x0a ;; posición
    .dw  _spr_bombahud;; sprite
contador_vidas::
    .db 0x03
contador_bombas::
    .db 0x03
.area _CODE

renderizar_life_and_bombs:
    bucle_vidas:
            ;; check is i render all lifes
            ld a, (hl)
            cp #0
            jr z, bucle_vidas_end
            push hl
            ;; render one life
            call sys_render_life_or_bomb
            ;;decrease lifes counter
            pop hl
            ld a, (hl)
            dec a
            ld (hl), a
            push hl
            ;; go to next sprite
            ld hl, #DISTANCE_BETWEEN_VIDAS
            add hl, de
            ld      e, l              
            ld      d, h
            pop hl
            jr bucle_vidas
    bucle_vidas_end:
    ld a,#3
    ld (hl), a
ret
render_score:
    ;  pvmem = cpctm_screenPtr(CPCT_VMEM_START, 16, 88);  // Calculate video memory address
    ; call sys_render_score
    ; ; (1B L ) fg_pen	Foreground palette colour index (Similar to BASIC’s PEN, 0-15)
    ; ; (1B H ) bg_pen	Background palette colour index (PEN, 0-15)
    ld l, #4
    ld h, #0
    call cpct_setDrawCharM0_asm         
    ; ; (2B IY) string	Pointer to the null terminated string being drawn
    ; ; (2B HL) video_memory	Video memory location where the string will be drawn                // Red over black
    ; ; cpct_drawStringM0("Hello there!", pvmem);  
              ;; HL -> video memory
            ld      de, #0xC000
            ;; add C to SCORE_INIT_X and save in c
                ld      c, #0x22
            ;; add b to SCORE_INIT_Y and save in b
                ld      b, #0x0a
            call    cpct_getScreenPtr_asm
        ;; draw char -> cpct_drawCharM0_asm
            ;; INPUTS
                ;; HL -> video memory
                ;; E -> ascii           
                ;; retrieve ascii and save back
                    ld e, #"3"
                ;; call function
                    call    cpct_drawCharM0_asm  
    ; ld  e, #"H"
    ; ld hl, #0xC400
    ; call cpct_drawStringM0_asm
ret
quitar_vida::
    ld de, #array_vidas + 10
    call quitar_vida_or_bomb
ret
quitar_bomba::
    ld de, #array_bombas + 10
    call quitar_vida_or_bomb
ret
   quitar_vida_or_bomb::
    
    ;; start in the last element
    ; ld de, #array_vidas + 10
    look_last_alive:
        ld a, (de)  ; Carga el valor actual (vivo o muerto)
        cp #0       ; Compara con 0 (vivo)
        jr z, found_last_alive  ; Si está vivo, salta a la etiqueta found_last_alive
        ;; sub distance between elements 
        dec de
        dec de
        dec de
        dec de
        dec de
        jp look_last_alive  ; Salta de nuevo a look_last_alive

    found_last_alive:
        ;; Ahora de apunta al último elemento vivo
        ;; Cambiar el sprite a sprite_borrar_vida
        ;; put the byte as died
        ld a, #1
        ld (de) , a
        ;; save in bc died sprite
        ld bc, #sprite_borrar_vida
        ;; go to arrayvidas->sprite an load bc in this position
        ld hl, #sprite
        add hl, de
        ld (hl), c
        inc hl
        ld (hl), b
ret
create_HUD::
    ;; array de vidas en de
    ld de, #array_vidas
    ;; contador de vidas
    ld hl, #contador_vidas
    ;; render
    call renderizar_life_and_bombs ;; creamos las vidas
    ;; array de bombas en de
    ld de, #array_bombas
    ;; contador de bombas
    ld hl, #contador_bombas
    ;; render
    call renderizar_life_and_bombs ;; creamos bombas
    ;render score
    call render_score
ret
