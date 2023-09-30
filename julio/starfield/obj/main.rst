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
                             22 ;;;;;;;;;; tipo , x , y , vx , vy , w , h , color 
   4000 01 1E 14 FE 00 01    23 prueba:  .db 1 , 30 , 20 , -2 , 0 , 1 , 1 , 0xCC
        01 CC
   4008 01 2A 3C FB 00 01    24 prueba2: .db 1 , 42 , 60 , -5 , 0 , 1 , 1 , 0xF0
        01 F0
                             25 
                             26 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             27 ;; MAIN 
                             28 ;;
   4010                      29 _main::
                             30 
                             31    ;; Init systems
   4010 CD DC 40      [17]   32    call render_sys_init
   4013 CD B4 40      [17]   33    call physics_sys_init
                             34 
   4016 21 00 40      [10]   35    ld   hl, #prueba
   4019 CD 91 40      [17]   36    call entity_man_create
   401C 21 08 40      [10]   37    ld   hl, #prueba2
   401F CD 91 40      [17]   38    call entity_man_create
                             39 
   4022                      40 loop:
                             41 
                             42    ;;;;;;;;;;;;;;;;;;;
                             43    ;; Physics
                             44    ;;
   4022 CD AC 40      [17]   45    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
   4025 CD B5 40      [17]   46    call physics_sys_update
                             47 
                             48    ;; waitNVSyncs 2
   4028 CD 01 41      [17]   49    call cpct_waitVSYNC_asm
                             50    ;;;;;;;;;;;;;;;;;;;
                             51    ;; Render
                             52    ;;
   402B CD AC 40      [17]   53    call entity_man_getArray   ;; guarda en IX el _entity_array y en A el _num_entities
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   402E CD DD 40      [17]   54    call render_sys_update
                             55 
   4031 18 EF         [12]   56    jr   loop
