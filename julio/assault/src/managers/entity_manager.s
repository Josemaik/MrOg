;;;;;;;;;;;;;;;;;;;;;;;
;; Entity Manager
;;   Definition of entity structure
;; 
.module Entity_Manager

.include "cpctelera.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Symbols
;;
.globl entity_man_init
.globl entity_man_create

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Plantilla de Estrella
;;
;;;;;;;;;;;;;;;;;;;;;;;;;  x , y , vx , vy , w , h , color , ptr_l , ptr_h
plantilla_estrella:: .db   0 , 20 , 1 , 0  , 1 , 1 , 0xC0 ,  00   ,  00  
    entity_size == .-plantilla_estrella

    e_x         == 0
    e_y         == 1
    e_vx        == 2
    e_vy        == 3
    e_w         == 4
    e_h         == 5
    e_color     == 6
    e_ptr_l     == 7
    e_ptr_h     == 8

    max_entities == 30

    _num_entities::  .db 0
    _last_elem_ptr:: .dw _entity_array
    _entity_array::
        .ds max_entities*entity_size

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code
;;
.area _DATA
.area _CODE

entity_man_init:
    ;; Reset all component vector values
    xor a
    ld  (_num_entities), a

    ld  hl, #_entity_array
    ld  (_last_elem_ptr), hl

    call entity_man_create_star
    
    ret

entity_man_create_star::

    ld   hl, #plantilla_estrella
    call entity_man_create

    ret

;; Input
;;   HL: pointer to entity initializer
entity_man_create:
    ld      de, (_last_elem_ptr)
    ld      bc, #entity_size
    ldir                        ;; Copia desde donde apunta HL en el registro DE, tantos bytes como ponga en el registro BC

    ld       a, (_num_entities)
    inc      a
    ld       (_num_entities), a  

    ld      hl, (_last_elem_ptr)
    ld      bc, #entity_size  
    add     hl, bc
    ld      (_last_elem_ptr), hl

    ret

;; Input
;;   IX: Pointer to entity
entity_man_destroy::
    ;; Borrar la entidad de pantalla
    call render_sys_erase_previous_instance
    
    ;; Reposicionar el _last_elem_ptr
    ld       a, (_last_elem_ptr)
    ld       b, #entity_size  
    sub      b
    ld      (_last_elem_ptr), a

    ;; Copiar la ultima entidad 
    ld__de_ix
    ld      hl, (_last_elem_ptr)
    ld      bc, #entity_size
    ldir

    ;; Restar el numero de entidades actuales
    ld       a, (_num_entities)
    dec      a
    ld       (_num_entities), a

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Getters
;;
entity_man_getArray::
    ld      ix, #_entity_array
    ld       a, (_num_entities)
    ret