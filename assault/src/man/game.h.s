;;;;;;;;;;;;;;;;;;;;  
;; GLOBAL SYMBOLS ;;
;;;;;;;;;;;;;;;;;;;;
    ;; cpctelera
      .globl cpct_waitVSYNC_asm           
      .globl cpct_waitHalts_asm
      .globl cpct_memcpy_asm           
                                          
   ;; managers                            
      .globl _man_entity_init             
      .globl _man_entity_update           
      .globl _man_entity_create
      .globl  man_anim_enemy1                           
   ;; systems                             
      .globl _sys_physics_update          
      .globl _sys_render_update                   
      .globl _sys_render_init
      .globl _sys_ai_update
      .globl sys_ai_behaviour_left_right
      .globl sys_ai_behaviour_mothership
      .globl _sys_animations_update
   ;; sprites
      .globl _spr_mothership
      .globl _spr_playership_0
      .globl _spr_playership_1
      .globl _spr_enemy1_0
      .globl _spr_enemy1_1