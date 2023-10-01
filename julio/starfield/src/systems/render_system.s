;;;;;;;;;;;;;;;;;;;;;;;
;; Render System
;;   Definition to render entities
;;
.module Render_System

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Symbols
;;
.globl cpct_setVideoMode_asm
.globl cpct_setPalette_asm

.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code
;;
.area _CODE

render_sys_init::
    ld   c, #0
    call cpct_setVideoMode_asm

    ;; ld  hl, #_pal_main
    ;; ld  de, #16
    ;; call cpct_setPalette_asm

    ;; todo - cpctm_setBorder_asm HW_WHITE

    ret

;; Input
;;   IX: Pointer to first entity to render
;;    A: Number of entities to render
render_sys_update::
    ld  (_ent_counter), a

_render_loop:
    ;; Erase Previous Instance
    ld    e, e_ptr_l(ix)
    ld    d, e_ptr_h(ix)
    xor   a
    ld    c, e_w(ix)
    ld    b, e_h(ix)
    push bc
    call  cpct_drawSolidBox_asm

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
    ld   a, e_color(ix)   
    pop bc
    call cpct_drawSolidBox_asm

_ent_counter = .+1
    ld   a, #0
    dec a
    ret z

    ld  (_ent_counter), a
    ld  bc, #entity_size
    add ix, bc
    jr _render_loop