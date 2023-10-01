;;;;;;;;;;;;;;;;;;;;;;;
;; Main
;;   
.module Main

   .area _DATA
   .area _CODE

.globl cpct_waitVSYNC_asm

.globl _num_entities
.globl _entity_array
.globl entity_man_init
.globl entity_man_create

.globl render_sys_init
.globl render_sys_update

.globl physics_sys_init
.globl physics_sys_update

;;;;;;;;;;;;; x , y  , vx , vy , w , h , color , ptr_l , ptr_h
estrella:  .db 30 , 20 , -1 , 0  , 1 , 1 , 0xCC  ,  00   , 00
estrella2: .db 42 , 60 , -1 , 0  , 1 , 1 , 0xF0  ,  00   , 00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAIN 
;;
_main::

   ;; Init systems
   call render_sys_init
   call physics_sys_init

   ld   hl, #estrella
   call entity_man_create
   ld   hl, #estrella2
   call entity_man_create

loop:

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