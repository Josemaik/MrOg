ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;
                              2 ;; GLOBAL SYMBOLS ;;
                              3 ;;;;;;;;;;;;;;;;;;;;
                     0002     4    E_TYPE_MOVABLE    = 0x02
                              5    ;; managers                                   
                              6       .globl _man_entity_for_all
                              7       .globl _man_entity_for_all_matching                 
                              8       .globl _man_entity_set_for_destruction     
                              9    ;; cpct
                             10       .globl cpct_scanKeyboard_f_asm
                             11       .globl cpct_isKeyPressed_asm
