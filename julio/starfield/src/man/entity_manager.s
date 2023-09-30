.module Entity_Manager

    .area _CODE

    .include "entity_manager.inc"
    .include "cpctelera.h.s"

man_entity_init:
    ;; call man_own_place
    call man_entity_create
    ret

;; Input
;;   HL: pointer to entity initializer
man_entity_create:
    ld      de, (_last_elem_ptr)
    ld      bc, #entity_size
    ldir                        ;; Copia desde donde apunta HL hasta el registro DE, tantos bytes como ponga en el registro BC

    ld       a, (_num_entities)
    inc      a
    ld       (_num_entities), a  

    ld      hl, (_last_elem_ptr)
    ld      bc, #entity_size  
    add     hl, bc
    ld      (_last_elem_ptr), hl

    ret

;; man_own_place:
;;     .ds 50
;;     ret