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
                             11 .globl _num_entities
                             12 .globl _entity_array
                             13 .globl entity_man_init
                             14 .globl entity_man_create
                             15 
                             16 .globl render_sys_init
                             17 .globl render_sys_update
                             18 
                             19 .globl physics_sys_init
                             20 .globl physics_sys_update
                             21 
                             22 ;;;;;;;;;;;;; x , y  , vx , vy , w , h , color , ptr_l , ptr_h
   4000 1E 14 FF 00 01 01    23 estrella:  .db 30 , 20 , -1 , 0  , 1 , 1 , 0xCC  ,  00   , 00
        CC 00 00
   4009 2A 3C FF 00 01 01    24 estrella2: .db 42 , 60 , -1 , 0  , 1 , 1 , 0xF0  ,  00   , 00
        F0 00 00
                             25 
                             26 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             27 ;; MAIN 
                             28 ;;
   4012                      29 _main::
                             30 
                             31    ;; Init systems
   4012 CD E8 40      [17]   32    call render_sys_init
   4015 CD C0 40      [17]   33    call physics_sys_init
                             34 
   4018 21 00 40      [10]   35    ld   hl, #estrella
   401B CD 9D 40      [17]   36    call entity_man_create
   401E 21 09 40      [10]   37    ld   hl, #estrella2
   4021 CD 9D 40      [17]   38    call entity_man_create
                             39 
   4024                      40 loop:
                             41 
                             42    ;;;;;;;;;;;;;;;;;;;
                             43    ;; Physics
                             44    ;;
   4024 CD B8 40      [17]   45    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   4027 CD C1 40      [17]   46    call physics_sys_update
                             47 
                             48    ;; waitNVSyncs 2
   402A CD 4A 41      [17]   49    call cpct_waitVSYNC_asm
                             50 
                             51    ;;;;;;;;;;;;;;;;;;;
                             52    ;; Render
                             53    ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   402D CD B8 40      [17]   54    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   4030 CD EE 40      [17]   55    call render_sys_update
                             56 
   4033 18 EF         [12]   57    jr   loop
