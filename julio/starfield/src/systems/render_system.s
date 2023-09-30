;;;;;;;;;;;;;;;;;;;;;;;
;; Render System
;;   Definition to render entities
;;
.module Render_System

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Symbols
;;
.globl rendersys_update
.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code
;;
.area _CODE

rendersys_init::
    ret

;; Input
;;   IX: Pointer to first entity to render
;;    A: Number of entities to render
rendersys_update::

_renloop:
    push af

    ld  de, #0xC000
    ld   c, 1(ix)    ;; X
    ld   b, 2(ix)    ;; Y
    call cpct_getScreenPtr_asm

    ex  de, hl
    ld   a, 4(ix)    ;; Color
    ld   c, #2       ;; Width 
    ld   b, #8       ;; Height 
    call cpct_drawSolidBox_asm

    pop af

    dec a
    ret z

    ld  bc, #entity_size
    add ix, bc
    jr _renloop