.module Main

   .area _DATA
   .area _CODE

.globl man_entity_create
.globl cpct_disableFirmware_asm

prueba: .db 1, 20, 20 , 2 , 0xFF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAIN 
;;
_main::
   call cpct_disableFirmware_asm

   ld hl, #prueba
   call man_entity_create

loop:
   jr    loop