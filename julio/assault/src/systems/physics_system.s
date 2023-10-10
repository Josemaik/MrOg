;;;;;;;;;;;;;;;;;;;;;;;
;; Physics System
;;   Definition to entities physics
;;
.module Physics_System

screen_width  = 80
screen_height = 200

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code
;;
.area _DATA
.area _CODE

physics_sys_init::
    ret

;; Input
;;   IX: Pointer to first entity to render
;;    A: Number of entities to render
physics_sys_update::
    ld  b, a

_update_loop:
    ;; Update X
    ld    a, #screen_width + 1
    sub   e_w(ix)
    ld    c, a

    ld    a, e_x(ix)
    add   e_vx(ix)
    cp    c             ;; Comprueba con la primera posicion invalida
    jr   nc, invalid_x
valid_x:
    ld   e_x(ix), a
    jr   endif_x
invalid_x:
    ;; IX
    push bc
    push de
    call entity_man_destroy  ;; Modify HL, DE, BC
    pop de
    pop bc
    dec b
    jr _update_loop
endif_x:

    ;; Update Y ;; todo

    dec  b
    ret  z

    ld  de, #entity_size
    add ix, de
    jr _update_loop

    ret