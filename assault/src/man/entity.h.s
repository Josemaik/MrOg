
        ;;;;;;;;;;;;;;;;;;;;
        ;; DEFINED VALUES ;;
        ;;;;;;;;;;;;;;;;;;;;

    ;; Entity struct                 
        TYPE    = 0     ;;u8            
        X       = 1     ;;u8            
        Y       = 2     ;;u8
        Width   = 3     ;;u8
        Height  = 4     ;;u8       
        VX      = 5     ;;i8
        VY      = 6     ;;i8             
        sprite  = 7     ;;*u8 (2b)      
                                        
    ;; Entity types                  
        E_TYPE_INVALID  = 0x00          
        E_TYPE_RENDER    = 0x01         
        E_TYPE_MOVABLE    = 0x02 
        E_TYPE_INPUT    = 0x04 
        E_TYPE_DEAD     = 0x80          
        E_TYPE_DEFAULT  = 0x7F          
                                        
    ;; OTHERS                              
        SPACE_4_ONE_ENTITY     = 9      
        TOTAL_ENTITIES         = 12
        MAX_SPACE_4_ENTITIES = SPACE_4_ONE_ENTITY * TOTAL_ENTITIES;      
                                        


    ;;;;;;;;;;;;;;;;;;;;
    ;; GLOBAL SYMBOLS ;;
    ;;;;;;;;;;;;;;;;;;;;
    .globl cpct_memset_asm      
    .globl cpct_memcpy_asm      
