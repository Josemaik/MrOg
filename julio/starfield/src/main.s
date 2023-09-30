;;;;;;;;;;;;;;;;;;;;;;;
;; Main
;;   
.module Main

   .area _DATA
   .area _CODE

.globl _num_entities
.globl _entity_array
.globl man_entity_create

.globl rendersys_init
.globl rendersys_update

;; tipo , x , y , vx , color
prueba:  .db 1, 20, 20 , 2 , 0xFF
prueba2: .db 1, 12, 30 , 2 , 0xF0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAIN 
;;
_main::

   ;; Init systems
   call rendersys_init

   ld   hl, #prueba
   call man_entity_create
   ld   hl, #prueba2
   call man_entity_create

loop:
   call man_entity_getEntityArray_IX   ;; guarda en IX el _entity_array
   call man_entity_getNumEntities_A    ;; guarda en  A el _num_entities
   call rendersys_update

   jr   loop