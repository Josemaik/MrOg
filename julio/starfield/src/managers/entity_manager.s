;;;;;;;;;;;;;;;;;;;;;;;
;; Entity Manager
;;   Definition of entity structure
;; 
.module Entity_Manager

max_entities == 10
entity_size  == 9

_num_entities:: .db 0
_last_elem_ptr:: .dw _entity_array
_entity_array::
    .ds max_entities*entity_size

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Struct of entity
;;
;; x , y , vx , vy , w , h , color , ptr_l , ptr_h

e_x         == 0
e_y         == 1
e_vx        == 2
e_vy        == 3
e_w         == 4
e_h         == 5
e_color     == 6
e_ptr_l     == 7
e_ptr_h     == 8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Symbols
;;
.globl entity_man_init
.globl entity_man_create

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code
;;
.area _CODE

entity_man_init:
    ;; Reset all component vector values
    xor a
    ld  (_num_entities), a

    ld  hl, #_entity_array
    ld  (_last_elem_ptr), hl
    
    ret

;; Input
;;   HL: pointer to entity initializer
entity_man_create:
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Getters
;;
entity_man_getArray::
    ld      ix, #_entity_array
    ld       a, (_num_entities)
    ret