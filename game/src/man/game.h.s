;;;;;;;;;;;;;;;;;;;;  
;; GLOBAL SYMBOLS ;;
;;;;;;;;;;;;;;;;;;;;
    ;; cpctelera
      .globl cpct_waitVSYNC_asm           
      .globl cpct_waitHalts_asm
      .globl cpct_memcpy_asm 
      .globl cpct_akp_musicInit_asm          
      .globl cpct_akp_musicPlay_asm           
   ;; managers                            
      .globl _man_entity_init             
      .globl _man_entity_update           
      .globl _man_entity_create
      .globl _man_entity_clone
      .globl _man_entity_set_for_destruction
      .globl man_entity_destroy                           
   ;; systems                             
      .globl _sys_physics_update          
      .globl _sys_render_update                   
      .globl _sys_render_init
      .globl _sys_animations_update
      .globl _sys_input_update
   ;; sprites

   ;; templates
   .globl player_entity

   ;;music
   .globl _song_prueba
   ;; ia
   .globl sys_ai_surround_map
