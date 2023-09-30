;;;;;;;;;;;;;;;;;;;;;;;
;; Render System
;;   Definition to render entities
;;
.module Render_System

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Symbols
;;
.globl render_sys_update
.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code
;;
.area _CODE

render_sys_init::
    ret

;; Input
;;   IX: Pointer to first entity to render
;;    A: Number of entities to render
render_sys_update::

_render_loop:
    push af

    ld  de, #0xC000
    ld   c, e_x(ix)    ;; X
    ld   b, e_y(ix)    ;; Y
    call cpct_getScreenPtr_asm

    ex  de, hl
    ld   a, e_color(ix)    ;; Color
    ld   c, e_w(ix)        ;; Width 
    ld   b, e_h(ix)        ;; Height 
    call cpct_drawSolidBox_asm

    pop af

    dec a
    ret z

    ld  bc, #entity_size
    add ix, bc
    jr _render_loop