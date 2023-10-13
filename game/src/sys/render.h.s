;;;;;;;;;;;;;;;;;;;;
;; GLOBAL SYMBOLS ;;
;;;;;;;;;;;;;;;;;;;;
    E_CMP_RENDER    = 0x01
    ;; cpct                             
        .globl cpct_setVideoMode_asm    
        .globl cpct_getScreenPtr_asm    
        .globl cpct_setPalette_asm
        .globl cpct_drawSprite_asm
        .globl cpct_drawSolidBox_asm      
                                        
   ;; managers                          
        .globl _man_entity_for_all
        .globl _man_entity_for_all_matching
        .globl _main_palette      
