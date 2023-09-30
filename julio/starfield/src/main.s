.module Main

   .area _DATA
   .area _CODE

.globl cpct_disableFirmware_asm

.globl man_entity_create
.globl rendersys_update
.globl _num_entities
.globl _entity_array

;; tipo , x , y , vx , color
prueba: .db 1, 20, 20 , 2 , 0xFF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAIN 
;;
_main::
   call cpct_disableFirmware_asm

   ld   hl, #prueba
   call man_entity_create

   ld   ix, #_entity_array
   ld    a, (_num_entities)
   call rendersys_update

loop:
   jr    loop