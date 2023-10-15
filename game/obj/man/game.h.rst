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
                             13       .globl _man_entity_clone
                             14       .globl _man_entity_set_for_destruction
                             15       .globl man_entity_destroy                           
                             16    ;; systems                             
                             17       .globl _sys_physics_update          
                             18       .globl _sys_render_update                   
                             19       .globl _sys_render_init
                             20       .globl _sys_animations_update
                             21    ;; sprites
                             22 
                             23    ;; templates
                             24    .globl playership_template0_e
