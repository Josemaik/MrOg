.module Render_System

    .area _CODE

    .include "render_system.inc"

.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm

rendersys_init::
    ret

;; Input
;;   IX: Pointer to first entity to render
;;    A: Number of entities to render
rendersys_update::
    ;; tipo , x , y , vx , color

    ld  de, #0xC000
    ld   c, 1(ix)    ;; X
    ld   b, 2(ix)    ;; Y
    call cpct_getScreenPtr_asm

    ex  de, hl
    ld   a, 4(ix)    ;; Color
    ld   c, #2       ;; Width 
    ld   b, #8       ;; Height 
    call cpct_drawSolidBox_asm

    ret