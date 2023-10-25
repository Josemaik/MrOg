.module HUD_Manager

.include "cpctelera.h.s"
;; .include "game.h.s"
;; .include "entity.h.s"
.include "hud.h.s"
.area _DATA

array_vidas::
    .db 0x14, 0x0a ;; posición x e y
    .dw  _spr_vidas;; sprite
    .db 0x16, 0x0a ;; posición
    .dw  _spr_vidas;; sprite
    .db 0x18, 0x0a ;; posición
    .dw  _spr_vidas;; sprite
array_bombas::
    .db 0x00, 0x00 ;; posición
    .dw  _spr_bombahud;; sprite
    .db 0x00, 0x00 ;; posición
    .dw  _spr_bombahud;; sprite
    .db 0x00, 0x00 ;; posición
    .dw  _spr_bombahud;; sprite
contador_vidas:
    .db 0x03
.area _CODE

crear_vidas:
    ld de, #array_vidas
    bucle_vidas:
            ;; check is i render all lifes
            ld a, (contador_vidas)
            cp #1
            jr z, bucle_vidas_end
            ;; render one life
            call sys_render_vida
            ;;decrease lifes counter
            ld a, (contador_vidas)
            dec a
            ld (contador_vidas), a
    bucle_vidas_end:
ret
create_HUD::
    push de

    call crear_vidas ;; creamos las vidas

    pop de
ret
