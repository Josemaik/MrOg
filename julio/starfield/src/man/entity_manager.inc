;;;;;;;;;;;;;;;;;;;;;;;
;; Entity Manager
;;   Definition of entity structure

max_entities = 10
entity_size = 5

_num_entities:: .db 0
_last_elem_ptr:: .dw _entity_array
_entity_array::
    .ds max_entities*entity_size

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Struct of entity
;;
;; tipo , x , y , vx , color


;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Symbols

.globl man_entity_init
.globl man_entity_create
;; .globl man_own_place