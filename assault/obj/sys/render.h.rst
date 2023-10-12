ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;
                              2 ;; GLOBAL SYMBOLS ;;
                              3 ;;;;;;;;;;;;;;;;;;;;
                     0001     4     E_CMP_RENDER    = 0x01
                              5     ;; cpct                             
                              6         .globl cpct_setVideoMode_asm    
                              7         .globl cpct_getScreenPtr_asm    
                              8         .globl cpct_setPalette_asm
                              9         .globl cpct_drawSprite_asm
                             10         .globl cpct_drawSolidBox_asm      
                             11                                         
                             12    ;; managers                          
                             13         .globl _man_entity_for_all
                             14         .globl _man_entity_for_all_matching
                             15         .globl _main_palette      
