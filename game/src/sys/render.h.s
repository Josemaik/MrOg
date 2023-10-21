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
        .globl cpct_drawSpriteBlended_asm  
        .globl cpct_setBlendMode_asm 
        .globl cpct_setCRTCReg_asm   
        .globl cpct_getScreenToSprite_asm   
    ;; managers                          
        .globl _man_entity_for_all
        .globl _man_entity_for_all_matching
        .globl _main_palette  

    ;; tilemap
        .globl _tiles_00  
        .globl _tilemap_01
        .globl cpct_etm_setDrawTilemap4x8_ag_asm 
        .globl cpct_etm_drawTilemap4x8_ag_asm
