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
      .globl _man_entity_clone
      .globl _man_entity_set_for_destruction
      .globl man_entity_destroy                           
   ;; systems                             
      .globl _sys_physics_update          
      .globl _sys_render_update                   
      .globl _sys_render_init
      .globl _sys_ai_update
      .globl sys_ai_behaviour_left_right
      .globl sys_ai_behaviour_mothership
      .globl sys_ai_behaviour_enemy
      .globl _sys_animations_update
      .globl sys_ai_behaviour_autodestroy
   ;; sprites
      .globl _spr_mothership
      .globl _spr_playership_0
      .globl _spr_playership_1
      .globl _spr_enemy1_0
      .globl _spr_enemy1_1
      .globl _spr_vshot
   ;; templates
   .globl mothership_template_e
   .globl enemy1_template_e
   .globl playership_template1_e
   .globl playership_template0_e
   .globl playershot_template_e