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
                              9 .globl _num_entities
                             10 .globl _entity_array
                             11 .globl man_entity_create
                             12 
                             13 .globl rendersys_init
                             14 .globl rendersys_update
                             15 
                             16 ;; tipo , x , y , vx , color
   4000 01 14 14 02 FF       17 prueba:  .db 1, 20, 20 , 2 , 0xFF
   4005 01 0C 1E 02 F0       18 prueba2: .db 1, 12, 30 , 2 , 0xF0
                             19 
                             20 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             21 ;; MAIN 
                             22 ;;
   400A                      23 _main::
                             24 
                             25    ;; Init systems
   400A CD 81 40      [17]   26    call rendersys_init
                             27 
   400D 21 00 40      [10]   28    ld   hl, #prueba
   4010 CD 5D 40      [17]   29    call man_entity_create
   4013 21 05 40      [10]   30    ld   hl, #prueba2
   4016 CD 5D 40      [17]   31    call man_entity_create
                             32 
   4019                      33 loop:
   4019 CD 78 40      [17]   34    call man_entity_getEntityArray_IX   ;; guarda en IX el _entity_array
   401C CD 7D 40      [17]   35    call man_entity_getNumEntities_A    ;; guarda en  A el _num_entities
   401F CD 82 40      [17]   36    call rendersys_update
                             37 
   4022 18 F5         [12]   38    jr    loop
