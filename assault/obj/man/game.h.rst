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
                             13       .globl  man_anim_enemy1
                             14       .globl _man_entity_clone
                             15       .globl _man_entity_set_for_destruction
                             16       .globl man_entity_destroy                           
                             17    ;; systems                             
                             18       .globl _sys_physics_update          
                             19       .globl _sys_render_update                   
                             20       .globl _sys_render_init
                             21       .globl _sys_ai_update
                             22       .globl sys_ai_behaviour_left_right
                             23       .globl sys_ai_behaviour_mothership
                             24       .globl sys_ai_behaviour_enemy
                             25       .globl _sys_animations_update
                             26       .globl sys_ai_behaviour_autodestroy
                             27    ;; sprites
                             28       .globl _spr_mothership
                             29       .globl _spr_playership_0
                             30       .globl _spr_playership_1
                             31       .globl _spr_enemy1_0
                             32       .globl _spr_enemy1_1
                             33       .globl _spr_vshot
                             34    ;; templates
                             35    .globl mothership_template_e
                             36    .globl enemy1_template_e
                             37    .globl playership_template1_e
                             38    .globl playership_template0_e
                             39    .globl playershot_template_e
