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
   424B                      25 _main::
                             26 
                             27    ;; Init systems
   424B CD D3 44      [17]   28    call render_sys_init
   424E CD 90 44      [17]   29    call physics_sys_init
   4251 CD C5 43      [17]   30    call entity_man_init
   4254 CD 57 44      [17]   31    call input_sys_init
                             32 
   4257                      33 loop:
                             34 
                             35    ;;;;;;;;;;;;;;;;;;;
                             36    ;; Input
                             37    ;;
   4257 CD 4E 44      [17]   38    call entity_man_getArray
   425A CD 58 44      [17]   39    call input_sys_update
                             40 
                             41    ;;;;;;;;;;;;;;;;;;;
                             42    ;; Physics
                             43    ;;
   425D CD 4E 44      [17]   44    call entity_man_getArray
   4260 CD 91 44      [17]   45    call physics_sys_update
                             46 
                             47    ;;;;;;;;;;;;;;;;;;;
                             48    ;; Render
                             49    ;;
   4263 CD 4E 44      [17]   50    call entity_man_getArray
   4266 CD FC 44      [17]   51    call render_sys_update
                             52 
                             53    ;; waitNVSyncs 2
   4269 CD 7C 46      [17]   54    call cpct_waitVSYNC_asm
                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   426C 18 E9         [12]   56    jr   loop
