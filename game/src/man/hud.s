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
array_key::
    .db 0x43, 0x0a ;; posicion x e y
    .dw _spr_llave_hud_gris
contador_vidas::
    .db 0x03
contador_score::
    .db #TIME_UPDATE_SCORE;;0x3c ;; Cada cuanto tiempo se decrementa contador (60=1seg)
stop_score::
    .db 0x00
id_second_digit::
    .db 0x09
dec_to_acii_second_digit::
    .db '9', '8', '7', '6', '5', '4', '3', '2', '1', '0'

dec_to_acii_first_digit::
    .db '6', '5', '4', '3', '2', '1', '0'
id_first_digit::
    .db 0x00
.area _CODE

renderizar_life:
    bucle_vidas:
            ;; check is i render all lifes
            ld a, (hl)
            cp #0
            jr z, bucle_vidas_end
            push hl
            ;; render one life
            call sys_render_life
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
render_first_digit:
;; renderizar firs digit
    ld de, #dec_to_acii_first_digit
    ld hl, (id_first_digit)
    ld h, #0x00
    add hl , de
    ld a, (hl)
    ld e, a
    ld b, #0x0a
    ld c, #0x22
    call sys_render_char
ret
render_second_digit:
;; renderizar second digit
    ld bc, #dec_to_acii_second_digit
    ld hl, (id_second_digit)
    ld h, #0x00
    add hl, bc
    ld a, (hl)
    ld e, a
    ld b, #0x0a
    ld c, #0x27
    call sys_render_char
ret
render_third_digit:
;; renderizar tercer digito
    ld de, #"0"
    ld b, #0x0a
    ld c, #0x2c
    call sys_render_char
ret
render_score::
    call render_first_digit
    call render_second_digit
    call render_third_digit
    ;; compruebo si digito 1 y 2 estan a 0 => paro contador
    ld a, (id_first_digit)
    cp #6
    jr z, check_dig2
    jr update
    check_dig2:
    ld a, (id_second_digit)
    cp #9
    jr z, stop_counter
    jr update
    stop_counter:
    ld a, #1
    ld (stop_score), a
    ret
    ;; actualizo valores de los digitos
    update:
    ;; aumento digito 2
    ld a , (id_second_digit)
    inc a
    ld (id_second_digit), a
    ;; cuando segundo digito sea 10, me he pasado incremento digito 1
    cp #0x0a
    jr z, inc_dig_1
    ret
    inc_dig_1:
    ;; incremento digio 1
    ld a , (id_first_digit)
    inc a
    ld (id_first_digit), a
    ;; vuelvo el segundo digito a 0
    ld a, #0
    ld (id_second_digit), a
ret

   quitar_vida::
    
    ;; start in the last element
    ld de, #array_vidas + 10
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
render_key:
    call sys_render_key
ret
borrar_llave::
    ld de, #array_key
    ld bc, #_spr_llave_hud_gris
    ;; go to arraykey->sprite an load bc in this position
    ld hl, #sprite_key
    add hl, de
    ld (hl), c
    inc hl
    ld (hl), b
    call render_key
ret
set_llave::
    ld de, #array_key
    ld bc, #_spr_llave_hud
    ;; go to arraykey->sprite an load bc in this position
    ld hl, #sprite_key
    add hl, de
    ld (hl), c
    inc hl
    ld (hl), b
    call render_key
ret
create_HUD::
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; RENDER LIFES
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; array de vidas en de
    ld de, #array_vidas
    ;; contador de vidas
    ld hl, #contador_vidas
    ;; compruebo vidas disponibles
    ld a, (lifes_available)
    cp #0
    jr z, no_render_lifes
    ;; render
    call renderizar_life ;; creamos las vidas

    no_render_lifes:
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; RENDER SCORE
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;; 600 => 1 minuto
    ld a, (contador_score)
    dec a
    ld (contador_score), a
    cp #0
    jr z , go_to_render_score
    ret
    go_to_render_score:
    ld a, (stop_score)
    cp #1
    jr z, no_render_score
    call render_score
    no_render_score:
    ld a , #TIME_UPDATE_SCORE
    ld (contador_score), a
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; RENDER KEY
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ld de, #array_key
    ld a, (tengo_llave)
    cp #1
    jr nz, no_tengo_llave
    call set_llave
    ret
    no_tengo_llave:
    call borrar_llave
ret
