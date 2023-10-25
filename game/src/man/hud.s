.module HUD_Manager

.include "cpctelera.h.s"
;; .include "game.h.s"
;; .include "entity.h.s"
.include "hud.h.s"
.area _DATA

array_vidas::
    .db 0x05, 0x0a ;; posición x e y
    .dw  _spr_vidas;; sprite
    .db 0x0a, 0x0a ;; posición
    .dw  _spr_vidas;; sprite
    .db 0x0f, 0x0a ;; posición
    .dw  _spr_vidas;; sprite
array_bombas::
    .db 0x39, 0x0a ;; posición
    .dw  _spr_bombahud;; sprite
    .db 0x3e, 0x0a ;; posición
    .dw  _spr_bombahud;; sprite
    .db 0x43, 0x0a ;; posición
    .dw  _spr_bombahud;; sprite
contador_vidas:
    .db 0x03
.area _CODE

crear_vidas:
    bucle_vidas:
            ;; check is i render all lifes
            ld a, (contador_vidas)
            cp #0
            jr z, bucle_vidas_end
            ;; render one life
            call sys_render_vida
            ;;decrease lifes counter
            ld a, (contador_vidas)
            dec a
            ld (contador_vidas), a
            ;; go to next sprite
            ld hl, #DISTANCE_BETWEEN_VIDAS
            add hl, de
            ld      e, l              
            ld      d, h
            jr bucle_vidas
    bucle_vidas_end:
ret
; crear_bombas:
;     ld de, #array_bombas
;     bucle_vidas1:
;             ;; check is i render all lifes
;             ld a, (contador_vidas)
;             cp #0
;             jr z, bucle_vidas_end1
;             ;; render one life
;             call sys_render_vida
;             ;;decrease lifes counter
;             ld a, (contador_vidas)
;             dec a
;             ld (contador_vidas), a
;             ;; go to next sprite
;             ld hl, #DISTANCE_BETWEEN_VIDAS
;             add hl, de
;             ld      e, l              
;             ld      d, h
;             jr bucle_vidas1
;     bucle_vidas_end1:
; ret
create_HUD::
    ld de, #array_vidas
    call crear_vidas ;; creamos las vidas
    ld a, #3
    ld (contador_vidas), a
    ld de, #array_bombas
    call crear_vidas ;; creamos bombas
ret
