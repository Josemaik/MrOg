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
                             19 .globl input_sys_init
                             20 .globl input_sys_update
                             21 
                             22 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             23 ;; MAIN 
                             24 ;;
   4000                      25 _main::
                             26 
                             27    ;; Init systems
   4000 CD 06 42      [17]   28    call render_sys_init
   4003 CD D2 41      [17]   29    call physics_sys_init
   4006 CD 3D 41      [17]   30    call entity_man_init
   4009 CD 95 41      [17]   31    call input_sys_init
                             32 
   400C                      33 loop:
                             34 
                             35    ;;;;;;;;;;;;;;;;;;;
                             36    ;; Input
                             37    ;;
   400C CD 8D 41      [17]   38    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   400F CD 96 41      [17]   39    call input_sys_update
                             40 
                             41    ;;;;;;;;;;;;;;;;;;;
                             42    ;; Physics
                             43    ;;
   4012 CD 8D 41      [17]   44    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   4015 CD D3 41      [17]   45    call physics_sys_update
                             46 
                             47    ;;;;;;;;;;;;;;;;;;;
                             48    ;; Render
                             49    ;;
   4018 CD 8D 41      [17]   50    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   401B CD 23 42      [17]   51    call render_sys_update
                             52 
                             53    ;; waitNVSyncs 2
   401E CD 00 43      [17]   54    call cpct_waitVSYNC_asm
                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   4021 18 E9         [12]   56    jr   loop
