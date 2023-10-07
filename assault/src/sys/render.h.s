;;;;;;;;;;;;;;;;;;;;
;; GLOBAL SYMBOLS ;;
;;;;;;;;;;;;;;;;;;;;
    E_TYPE_RENDER    = 0x01
    ;; cpct                             
        .globl cpct_setVideoMode_asm    
        .globl cpct_getScreenPtr_asm    
        .globl cpct_setPalette_asm
        .globl cpct_drawSprite_asm      
                                        
   ;; managers                          
        .globl _man_entity_for_all
        .globl _man_entity_for_all_matching
        .globl _main_palette      
