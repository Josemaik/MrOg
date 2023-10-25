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
    ; .db 0x00        ;; 0 indica vivo y 1 es muerto
    .db 0x05, 0x0a ;; posición x e y
    .dw  _spr_vidas;; sprite
    ; .db 0x00
    .db 0x0a, 0x0a ;; posición
    .dw  _spr_vidas;; sprite
    ; .db 0x00
    .db 0x0f, 0x0a ;; posición
    .dw  _spr_vidas;; sprite
array_bombas::
    .db 0x39, 0x0a ;; posición
    .dw  _spr_bombahud;; sprite
    .db 0x3e, 0x0a ;; posición
    .dw  _spr_bombahud;; sprite
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
ret
quitar_vida::
    ;; coger ultima posicion array, empezar a contar desde la ultima posicion
    ;; draw solid box
    ;; reducir contador vidas
    ; ld de, #array_vidas + 11
    ; bucle:
    ;     ld hl, #

    ; ld a, (contador_vidas)
    ; dec a
    ; ld (contador_vidas), a
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
ret
