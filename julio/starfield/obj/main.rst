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
                             11 .globl entity_man_init
                             12 
                             13 .globl render_sys_init
                             14 .globl render_sys_update
                             15 
                             16 .globl physics_sys_init
                             17 .globl physics_sys_update
                             18 
                             19 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             20 ;; MAIN 
                             21 ;;
   4000                      22 _main::
                             23 
                             24    ;; Init systems
   4000 CD 11 41      [17]   25    call render_sys_init
   4003 CD E7 40      [17]   26    call physics_sys_init
   4006 CD 89 40      [17]   27    call entity_man_init
                             28 
   4009                      29 loop:
                             30 
                             31    ;;;;;;;;;;;;;;;;;;;
                             32    ;; Physics
                             33    ;;
   4009 CD DF 40      [17]   34    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   400C CD E8 40      [17]   35    call physics_sys_update
                             36 
                             37    ;; waitNVSyncs 2
   400F CD 8B 41      [17]   38    call cpct_waitVSYNC_asm
                             39 
                             40    ;;;;;;;;;;;;;;;;;;;
                             41    ;; Render
                             42    ;;
   4012 CD DF 40      [17]   43    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   4015 CD 2E 41      [17]   44    call render_sys_update
                             45 
   4018 18 EF         [12]   46    jr   loop
