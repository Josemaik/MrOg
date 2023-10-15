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
   46CB                      25 _main::
                             26 
                             27    ;; Init systems
   46CB CD 53 49      [17]   28    call render_sys_init
   46CE CD 10 49      [17]   29    call physics_sys_init
   46D1 CD 45 48      [17]   30    call entity_man_init
   46D4 CD D7 48      [17]   31    call input_sys_init
                             32 
   46D7                      33 loop:
                             34 
                             35    ;;;;;;;;;;;;;;;;;;;
                             36    ;; Input
                             37    ;;
   46D7 CD CE 48      [17]   38    call entity_man_getArray
   46DA CD D8 48      [17]   39    call input_sys_update
                             40 
                             41    ;;;;;;;;;;;;;;;;;;;
                             42    ;; Physics
                             43    ;;
   46DD CD CE 48      [17]   44    call entity_man_getArray
   46E0 CD 11 49      [17]   45    call physics_sys_update
                             46 
                             47    ;;;;;;;;;;;;;;;;;;;
                             48    ;; Render
                             49    ;;
   46E3 CD CE 48      [17]   50    call entity_man_getArray
   46E6 CD 7C 49      [17]   51    call render_sys_update
                             52 
                             53    ;; waitNVSyncs 2
   46E9 CD FC 4A      [17]   54    call cpct_waitVSYNC_asm
                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   46EC 18 E9         [12]   56    jr   loop
