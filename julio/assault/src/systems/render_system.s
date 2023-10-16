;;;;;;;;;;;;;;;;;;;;;;;
;; Render System
;;   Definition to render entities
;;
.module Render_System

.include "cpctelera.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Symbols
;;
.globl cpct_disableFirmware_asm

.globl cpct_setVideoMode_asm
.globl cpct_setPalette_asm
.globl _g_palette

.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm
.globl cpct_drawSprite_asm

.globl cpct_etm_drawTilemap4x8_ag_asm
.globl cpct_etm_setDrawTilemap4x8_ag_asm

.globl _sp_player_ship
.globl _tiles_00
.globl _tilemap_01

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code
;;
.area _DATA
.area _CODE

render_sys_init::

    call cpct_disableFirmware_asm

    ld   c, #0
    call cpct_setVideoMode_asm

    ld  hl, #_g_palette
    ld  de, #16
    call cpct_setPalette_asm

    cpctm_setBorder_asm HW_BLACK

    call render_sys_tilemap

    ret

;; Erase Previous Instance
render_sys_erase_previous_instance::
    ld    e, e_ptr_l(ix)
    ld    d, e_ptr_h(ix)
    xor   a
    ld    c, e_w(ix)
    ld    b, e_h(ix)
    call  cpct_drawSolidBox_asm

    ret

;; Render tilemap
render_sys_tilemap::

    ld  bc, #0x1914      ;; height and width
    ld  de, #0x30        ;; tilemapWidth
    ld  hl, #_tiles_00   ;; pointer to the start of the tileset
    call cpct_etm_setDrawTilemap4x8_ag_asm

    ld  hl, #0xC000      ;; video memory location
    ld  de, #_tilemap_01 ;; pointer to the upper-left of the view
    call cpct_etm_drawTilemap4x8_ag_asm

    ret

;; Input
;;   IX: Pointer to first entity to render
;;    A: Number of entities to render
render_sys_update::
    ld  (_ent_counter), a

_render_loop:
    ;; Erase Previous Instance
    call render_sys_erase_previous_instance

    ;; Calculate new Video Memory Pointer
    ld  de, #0xC000
    ld   c, e_x(ix)    ;; X
    ld   b, e_y(ix)    ;; Y
    call cpct_getScreenPtr_asm

    ;; Store Video Memory Pointer as Last
    ld    e_ptr_l(ix), l
    ld    e_ptr_h(ix), h

    ;; Draw Entity
    ex  de, hl
    ld   l, e_pspr_l(ix)
    ld   h, e_pspr_h(ix)
    ld    c, e_w(ix)
    ld    b, e_h(ix)
    call cpct_drawSprite_asm

_ent_counter = .+1
    ld   a, #0
    dec a
    ret z

    ld  (_ent_counter), a
    ld  bc, #entity_size
    add ix, bc
    jr _render_loop