;;;;;;;;;;;;;;;;;;;;;;;
;; Generator System
;;   Generator of new entities(stars)
;;
.module Generator_System

.include "cpctelera.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code
;;
.area _DATA
.area _CODE

generate_sys_newStar::

    ;; Comprobar si hay espacio libre (max_entities - _num_entities)
    ld    a, #max_entities
    ld   hl, #_num_entities
    ld    d, (hl)
    sub   d  

    jr z, fin_generate

    ;; Crear aleatoriamente un valor de x, vx (modificando plantilla_estrella)
    ld        ix, #plantilla_estrella

    ;; Posicion Y
    call cpct_getRandom_mxor_u8_asm ;; Output --> L (Random value)
    ld     h, #0
    ld     e, #200
    call   divide
    ld     a, l
    ld   e_y(ix), a

    ;; Velocidad X
    call cpct_getRandom_mxor_u8_asm ;; Output --> L (Random value)
    ld     h, #0
    ld     e, #2
    call   divide
    ld     a, l
    add    a, #1
    neg    
    ld  e_vx(ix), a

    ;; Llamar a entity_man_create_star
    call entity_man_create_star

    fin_generate:

    ret

;;;;;;;;;;;;;;;;;;;
;; DIVIDE 8 BITS ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; INPUTS ;;
      ;; HL
      ;; E
   ;; OUTPUTS ;;
      ;; BC -> result
      ;; HL -> rest
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; NOTE ;;
      ;; Reference code: http://www.massmind.org/techref/zilog/z80/part4.htm
      ;; BC = HL / E
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
divide:

   ;; load E in A
      ld a, e

   ;; conditional if A = 0 -> finish
      or a
      ret z

   ;; load -1 in BC and prepare D to operate
      ld bc, #-1
      ld d, #0

   ;; init for
      divide_for:

         ;; subtract DE from HL (uses the a register)
            sbc hl, de

         ;;increment BC by 1
            inc bc
         
         ;; conditional to repeat for
            jr nc, divide_for

   ;; take the rest into hl
            add hl, de

   ret