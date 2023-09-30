ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; Main
                              3 ;;   
                              4 .module Main
                              5 
                              6    .area _DATA
                              7    .area _CODE
                              8 
                              9 .globl cpct_waitVSYNC_asm
                             10 
                             11 .globl _num_entities
                             12 .globl _entity_array
                             13 .globl man_entity_create
                             14 
                             15 .globl rendersys_init
                             16 .globl rendersys_update
                             17 
                             18 .globl physicssys_init
                             19 .globl physicssys_update
                             20 
                             21 ;; tipo , x , y , vx , color
   4000 01 14 14 02 FF       22 prueba:  .db 1, 20, 20 , 2 , 0xFF
   4005 01 0C 1E 02 F0       23 prueba2: .db 1, 12, 30 , 2 , 0xF0
                             24 
                             25 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             26 ;; MAIN 
                             27 ;;
   400A                      28 _main::
                             29 
                             30    ;; Init systems
   400A CD 88 40      [17]   31    call rendersys_init
   400D CD 86 40      [17]   32    call physicssys_init
                             33 
   4010 21 00 40      [10]   34    ld   hl, #prueba
   4013 CD 63 40      [17]   35    call man_entity_create
   4016 21 05 40      [10]   36    ld   hl, #prueba2
   4019 CD 63 40      [17]   37    call man_entity_create
                             38 
   401C                      39 loop:
                             40 
                             41    ;;;;;;;;;;;;;;;;;;;
                             42    ;; Physics
                             43    ;;
   401C CD 87 40      [17]   44    call physicssys_update
                             45 
                             46    ;; waitNVSyncs 2
   401F CD AB 40      [17]   47    call cpct_waitVSYNC_asm
                             48    ;;;;;;;;;;;;;;;;;;;
                             49    ;; Render
                             50    ;;
   4022 CD 7E 40      [17]   51    call man_entity_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   4025 CD 89 40      [17]   52    call rendersys_update
                             53 
   4028 18 F2         [12]   54    jr   loop
