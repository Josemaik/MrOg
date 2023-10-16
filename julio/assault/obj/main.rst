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
   487B                      25 _main::
                             26 
                             27    ;; Init systems
   487B CD FD 4A      [17]   28    call render_sys_init
   487E CD BA 4A      [17]   29    call physics_sys_init
   4881 CD F5 49      [17]   30    call entity_man_init
   4884 CD 81 4A      [17]   31    call input_sys_init
                             32 
   4887                      33 loop:
                             34 
                             35    ;;;;;;;;;;;;;;;;;;;
                             36    ;; Input
                             37    ;;
   4887 CD 78 4A      [17]   38    call entity_man_getArray
   488A CD 82 4A      [17]   39    call input_sys_update
                             40 
                             41    ;;;;;;;;;;;;;;;;;;;
                             42    ;; Physics
                             43    ;;
   488D CD 78 4A      [17]   44    call entity_man_getArray
   4890 CD BB 4A      [17]   45    call physics_sys_update
                             46 
                             47    ;;;;;;;;;;;;;;;;;;;
                             48    ;; Render
                             49    ;;
   4893 CD 78 4A      [17]   50    call entity_man_getArray
   4896 CD 29 4B      [17]   51    call render_sys_tilemap
                             52    ;;call render_sys_update
                             53 
                             54    ;; waitNVSyncs 2
   4899 CD 58 4D      [17]   55    call cpct_waitVSYNC_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 
   489C 18 E9         [12]   57    jr   loop
