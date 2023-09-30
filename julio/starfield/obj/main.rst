ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module Main
                              2 
                              3    .area _DATA
                              4    .area _CODE
                              5 
                              6 .globl cpct_disableFirmware_asm
                              7 
                              8 .globl man_entity_create
                              9 .globl rendersys_update
                             10 .globl _num_entities
                             11 .globl _entity_array
                             12 
                             13 ;; tipo , x , y , vx , color
   4000 01 14 14 02 FF       14 prueba: .db 1, 20, 20 , 2 , 0xFF
                             15 
                             16 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             17 ;; MAIN 
                             18 ;;
   4005                      19 _main::
   4005 CD 87 40      [17]   20    call cpct_disableFirmware_asm
                             21 
   4008 21 00 40      [10]   22    ld   hl, #prueba
   400B CD 53 40      [17]   23    call man_entity_create
                             24 
   400E DD 21 1D 40   [14]   25    ld   ix, #_entity_array
   4012 3A 1A 40      [13]   26    ld    a, (_num_entities)
   4015 CD 6F 40      [17]   27    call rendersys_update
                             28 
   4018                      29 loop:
   4018 18 FE         [12]   30    jr    loop
