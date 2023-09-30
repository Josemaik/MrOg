ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module Main
                              2 
                              3    .area _DATA
                              4    .area _CODE
                              5 
                              6 .globl cpct_disableFirmware_asm
                              7 
                              8 .globl _num_entities
                              9 .globl _entity_array
                             10 .globl man_entity_create
                             11 .globl man_entity_getEntityArray_IX
                             12 .globl man_entity_getNumEntities
                             13 
                             14 .globl rendersys_init
                             15 .globl rendersys_update
                             16 
                             17 ;; tipo , x , y , vx , color
   4000 01 14 14 02 FF       18 prueba:  .db 1, 20, 20 , 2 , 0xFF
   4005 01 0C 1E 02 F0       19 prueba2: .db 1, 12, 30 , 2 , 0xF0
                             20 
                             21 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             22 ;; MAIN 
                             23 ;;
   400A                      24 _main::
   400A CD AA 40      [17]   25    call cpct_disableFirmware_asm
                             26 
                             27    ;; Init systems
   400D CD 87 40      [17]   28    call rendersys_init
                             29 
   4010 21 00 40      [10]   30    ld   hl, #prueba
   4013 CD 60 40      [17]   31    call man_entity_create
   4016 21 05 40      [10]   32    ld   hl, #prueba2
   4019 CD 60 40      [17]   33    call man_entity_create
                             34 
   401C                      35 loop:
   401C CD 00 00      [17]   36    call man_entity_getEntityArray_IX   ;; guarda en IX el _entity_array
   401F CD 00 00      [17]   37    call man_entity_getNumEntities      ;; guarda en  A el _num_entities
   4022 CD 88 40      [17]   38    call rendersys_update
                             39 
   4025 18 F5         [12]   40    jr    loop
