
        ;;;;;;;;;;;;;;;;;;;;
        ;; DEFINED VALUES ;;
        ;;;;;;;;;;;;;;;;;;;;    
                                        
    ;;;;;;;;;;;;;;;;;;;;
    ;; GLOBAL SYMBOLS ;;
    ;;;;;;;;;;;;;;;;;;;;
    .globl cpct_memset_asm      
    .globl cpct_memcpy_asm              
    .globl cpct_waitVSYNC_asm           
    .globl cpct_waitHalts_asm           
                                          
   ;; managers                            
      .globl _man_entity_init             
      .globl _man_entity_update           
                                          
   ;; systems                             
      .globl _sys_physics_update          
      .globl _sys_render_update                  
      .globl _sys_render_init 