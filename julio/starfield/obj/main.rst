ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module Main
                              2 
                              3    .area _DATA
                              4    .area _CODE
                              5 
                              6 .globl man_entity_create
                              7 .globl cpct_disableFirmware_asm
                              8 
   4000 01 14 14 02 FF        9 prueba: .db 1, 20, 20 , 2 , 0xFF
                             10 
                             11 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             12 ;; MAIN 
                             13 ;;
   4005                      14 _main::
   4005 CD 64 40      [17]   15    call cpct_disableFirmware_asm
                             16 
   4008 21 00 40      [10]   17    ld hl, #prueba
   400B CD 49 40      [17]   18    call man_entity_create
                             19 
   400E                      20 loop:
   400E 18 FE         [12]   21    jr    loop
