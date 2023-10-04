;;;;;;;;;;;;;;;;;;;;;;;
;; Main
;;   
.module Main

   .area _DATA
   .area _CODE

.globl cpct_waitVSYNC_asm

.globl entity_man_init

.globl generate_sys_newStar

.globl render_sys_init
.globl render_sys_update

.globl physics_sys_init
.globl physics_sys_update

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAIN 
;;
_main::

   ;; Init systems
   call render_sys_init
   call physics_sys_init
   call entity_man_init

loop:

   ;;;;;;;;;;;;;;;;;;;
   ;; Generate Stars 
   ;;
   ;; call generate_sys_newStar

   ;;;;;;;;;;;;;;;;;;;
   ;; Physics
   ;;
   call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   call physics_sys_update

   ;; waitNVSyncs 2
   call cpct_waitVSYNC_asm

   ;;;;;;;;;;;;;;;;;;;
   ;; Render
   ;;
   call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   call render_sys_update

   jr   loop