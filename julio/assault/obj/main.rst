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
   41F0                      25 _main::
                             26 
                             27    ;; Init systems
   41F0 CD 6A 43      [17]   28    call render_sys_init
   41F3 CD 27 43      [17]   29    call physics_sys_init
   41F6 CD 66 42      [17]   30    call entity_man_init
   41F9 CD EE 42      [17]   31    call input_sys_init
                             32 
   41FC                      33 loop:
                             34 
                             35    ;;;;;;;;;;;;;;;;;;;
                             36    ;; Input
                             37    ;;
   41FC CD E5 42      [17]   38    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   41FF CD EF 42      [17]   39    call input_sys_update
                             40 
                             41    ;;;;;;;;;;;;;;;;;;;
                             42    ;; Physics
                             43    ;;
   4202 CD E5 42      [17]   44    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   4205 CD 28 43      [17]   45    call physics_sys_update
                             46 
                             47    ;;;;;;;;;;;;;;;;;;;
                             48    ;; Render
                             49    ;;
   4208 CD E5 42      [17]   50    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   420B CD 93 43      [17]   51    call render_sys_update
                             52 
                             53    ;; waitNVSyncs 2
   420E CD 13 45      [17]   54    call cpct_waitVSYNC_asm
                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   4211 18 E9         [12]   56    jr   loop
