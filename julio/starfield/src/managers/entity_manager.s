;;;;;;;;;;;;;;;;;;;;;;;
;; Entity Manager
;;   Definition of entity structure
;; 
.module Entity_Manager

max_entities == 10
entity_size  == 5

_num_entities:: .db 0
_last_elem_ptr:: .dw _entity_array
_entity_array::
    .ds max_entities*entity_size

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Struct of entity
;;
;; tipo , x , y , vx , color

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Symbols
;;
.globl man_entity_init
.globl man_entity_create

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code
;;
.area _CODE

man_entity_init:
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Getters
;;
man_entity_getArray::
    ld      ix, #_entity_array
    ld       a, (_num_entities)
    ret