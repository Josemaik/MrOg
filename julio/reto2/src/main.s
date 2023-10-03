.include "cpctelera.h.s"

.area _DATA
.area _CODE

;;
;; Plantilla de datos iniciales de un copo
;;
copos_actuales: 
   .db 0

plantilla_copo:
   .db 25,    0   ;; ( X,   Y  ) Coordenadas de pantalla
   .db  1, 0xF0   ;; (VY, Color) Velocidad en Y, Color del copo
copo_size = .-plantilla_copo
max_copos = 10

tam_array = max_copos*copo_size

.db 0xBE, 0xEF
copos_array::
    .ds tam_array
.db 0xBE, 0xEF

;;@@@@@@@@@@@@@@

;;---------------------------------------------------------------
;; MAIN
;;---------------------------------------------------------------
_main::
   call init_copos_array

   call new_copo
   call new_copo
   call new_copo
   call new_copo
   call new_copo

_loop:

   jr _loop

;;;;;;;;;;;;;;;;;;;;;
;;      COPOS      ;;
;;;;;;;;;;;;;;;;;;;;;
;;
new_copo:
   ld   hl, (copos_actuales)
   call init_copo

   ;; Sumar uno a copos
   ld    a, (copos_actuales)
   inc   a
   ld    (copos_actuales), a

   ret
;;
;; Input: HL --> index of new copo  
;;
init_copo:
   add   hl, hl
   add   hl, hl
   ld    de, #copos_array
   add   hl, de
   ex    de, hl
   call create_copo

   ret
;;
;; Input: DE
;;
create_copo:
   ld    hl, #plantilla_copo
   ld    bc, #copo_size
   ldir

   ret

init_copos_array:
   ld    hl, #copos_array
   ld  (hl), #0x00
   ld    de, #copos_array
   ld    bc, #tam_array
   ldir

   ret