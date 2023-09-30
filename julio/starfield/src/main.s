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

;;;;;;;;;; tipo , x , y , vx , vy , w , h , color 
prueba:  .db 1 , 30 , 20 , -2 , 0 , 1 , 1 , 0xCC
prueba2: .db 1 , 42 , 60 , -5 , 0 , 1 , 1 , 0xF0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAIN 
;;
_main::

   ;; Init systems
   call render_sys_init
   call physics_sys_init

   ld   hl, #prueba
   call entity_man_create
   ld   hl, #prueba2
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