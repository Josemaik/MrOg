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
   40D8                      25 _main::
                             26 
                             27    ;; Init systems
   40D8 CD 18 43      [17]   28    call render_sys_init
   40DB CD DD 42      [17]   29    call physics_sys_init
   40DE CD 3E 42      [17]   30    call entity_man_init
   40E1 CD AD 42      [17]   31    call input_sys_init
                             32 
   40E4                      33 loop:
                             34 
                             35    ;;;;;;;;;;;;;;;;;;;
                             36    ;; Input
                             37    ;;
   40E4 CD A5 42      [17]   38    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   40E7 CD AE 42      [17]   39    call input_sys_update
                             40 
                             41    ;;;;;;;;;;;;;;;;;;;
                             42    ;; Physics
                             43    ;;
   40EA CD A5 42      [17]   44    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   40ED CD DE 42      [17]   45    call physics_sys_update
                             46 
                             47    ;;;;;;;;;;;;;;;;;;;
                             48    ;; Render
                             49    ;;
   40F0 CD A5 42      [17]   50    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   40F3 CD 41 43      [17]   51    call render_sys_update
                             52 
                             53    ;; waitNVSyncs 2
   40F6 CD C1 44      [17]   54    call cpct_waitVSYNC_asm
                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   40F9 18 E9         [12]   56    jr   loop
