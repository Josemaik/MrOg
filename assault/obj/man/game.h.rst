ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;  
                              2 ;; GLOBAL SYMBOLS ;;
                              3 ;;;;;;;;;;;;;;;;;;;;
                              4     ;; cpctelera
                              5       .globl cpct_waitVSYNC_asm           
                              6       .globl cpct_waitHalts_asm
                              7       .globl cpct_memcpy_asm           
                              8                                           
                              9    ;; managers                            
                             10       .globl _man_entity_init             
                             11       .globl _man_entity_update           
                             12       .globl _man_entity_create                           
                             13    ;; systems                             
                             14       .globl _sys_physics_update          
                             15       .globl _sys_render_update                   
                             16       .globl _sys_render_init
                             17       .globl _sys_ai_update
                             18    ;; sprites
                             19       .globl _spr_mothership
                             20       .globl _spr_playership_0
                             21       .globl _spr_playership_1
