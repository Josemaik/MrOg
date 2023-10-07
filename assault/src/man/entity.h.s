
        ;;;;;;;;;;;;;;;;;;;;
        ;; DEFINED VALUES ;;
        ;;;;;;;;;;;;;;;;;;;;

    ;; Entity struct                 
        TYPE    = 0     ;;u8            
        X       = 1     ;;u8            
        Y       = 2     ;;u8
        WIDTH   = 3     ;;u8
        HEIGHT  = 4     ;;u8           
        VX      = 5     ;;i8
        VY      = 6     ;;i8            
        SPRITE   = 7     ;;u8                 
                                        
    ;; Entity types                  
        E_TYPE_INVALID  = 0x00   ;; zero-byte to signal invalid entities     
        E_TYPE_RENDER   = 0x01   ;; renderable entity
        E_TYPE_MOVABLE  = 0x02   ;; movable entity
        E_TYPE_INPUT    = 0x04   ;; Entity controlable by input
        E_TYPE_IA       = 0x08   ;; Entity controlable by artificial inteligence
        E_TYPE_DEAD     = 0x80   ;; upper bit signal dead entity
        E_TYPE_DEFAULT  = 0x7F   ;; default entity       
                                        
    ;; OTHERS
        SPACE_4_ONE_ENTITY     = 9      ;; space for one entity
        TOTAL_ENTITIES         = 12      ;; number of entities                          
        TOTAL_SPACE_4_ENTITIES = SPACE_4_ONE_ENTITY*TOTAL_ENTITIES    ;;;Maximum  number of entities ( 210 )
    ;;   SPRITE PROPERTIES
        SPR_MOTHERSHIP_W = 18
        SPR_MOTHERSHIP_H = 18
        SPR_PLAYERSHIP_0_W = 6
        SPR_PLAYERSHIP_0_H = 8
        SPR_PLAYERSHIP_1_W = 6
        SPR_PLAYERSHIP_1_H = 8
        
                                        


    ;;;;;;;;;;;;;;;;;;;;
    ;; GLOBAL SYMBOLS ;;
    ;;;;;;;;;;;;;;;;;;;;
    .globl cpct_memset_asm      
    .globl cpct_memcpy_asm      
