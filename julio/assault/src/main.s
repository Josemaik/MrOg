;;;;;;;;;;;;;;;;;;;;;;;
;; Main
;;   
.module Main

   .area _DATA
   .area _CODE

.globl cpct_waitVSYNC_asm

.globl entity_man_init

.globl render_sys_init
.globl render_sys_update

.globl physics_sys_init
.globl physics_sys_update

.globl input_sys_init
.globl input_sys_update

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAIN 
;;
_main::

   ;; Init systems
   call render_sys_init
   call physics_sys_init
   call entity_man_init
   call input_sys_init

loop:

   ;;;;;;;;;;;;;;;;;;;
   ;; Input
   ;;
   call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   call input_sys_update

   ;;;;;;;;;;;;;;;;;;;
   ;; Physics
   ;;
   call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   call physics_sys_update

   ;;;;;;;;;;;;;;;;;;;
   ;; Render
   ;;
   call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   call render_sys_update

   ;; waitNVSyncs 2
   call cpct_waitVSYNC_asm

   jr   loop