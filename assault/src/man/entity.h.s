
        ;;;;;;;;;;;;;;;;;;;;
        ;; DEFINED VALUES ;;
        ;;;;;;;;;;;;;;;;;;;;

    ;; Entity struct                 
        TYPE    = 0     ;;u8
        CMPs    = 1     ;;u8      
        X       = 2     ;;u8            
        Y       = 3     ;;u8
        WIDTH   = 4     ;;u8
        HEIGHT  = 5     ;;u8           
        VX      = 6     ;;i8
        VY      = 7     ;;i8            
        SPRITE  = 8     ;;u8(2)
        IA_behaviour  = 10 ;; u8(2)
        IA_COUNTER = 12
        AnimFrame = 13     ;;u8(2)
        AnimCounter = 15    ;;u8
        COLLIDES_AGAINST = 16    
                                        
    ;; Entity types                  
        E_TYPE_INVALID  = 0x00   ;; zero-byte to signal invalid entities
        E_TYPE_PLAYER   = 0x01 
        E_TYPE_ENEMY   = 0x02 
        E_TYPE_MOTHERSHIP   = 0x04 
        E_TYPE_BOMB   = 0x08 
        E_TYPE_DEAD     = 0x80   ;; upper bit signal dead entity
        E_TYPE_DEFAULT  = E_TYPE_ENEMY
    ;; Components    
        E_CMP_RENDER   = 0x01   ;; renderable entity
        E_CMP_MOVABLE  = 0x02   ;; movable entity
        E_CMP_INPUT    = 0x04   ;; Entity controlable by input
        E_CMP_IA       = 0x08   ;; Entity controlable by artificial inteligence
        E_CMP_ANIMATED = 0x10   ;; Animated Entity
        E_CMP_COLLIDER = 0x20   ;; Entity that can collide
        E_CMP_DEFAULT  = 0x7F   ;; default entity  
            
                                        
    ;; OTHERS
        SPACE_4_ONE_ENTITY     = 17      ;; space for one entity
        TOTAL_ENTITIES         = 12      ;; number of entities                          
        TOTAL_SPACE_4_ENTITIES = SPACE_4_ONE_ENTITY*TOTAL_ENTITIES    ;;;Maximum  number of entities ( 210 )
        MAN_ANIM_PLAYER_TIME   = 12
    ;; LANES
        LANE_0		= 0											;;
		LANE_1		= 1											;;
		LANE_2		= 2	
        LANE_DY = 30
        LANE0_Y = 40
        LANE1_Y = LANE0_Y + LANE_DY
        LANE2_Y = 2*LANE0_Y + LANE_DY
    ;; PLAYER
        PLAYER_Y = 180
        PLAYERSHOT_Y = PLAYER_Y - 8
    ;;   SPRITE PROPERTIES
        SPR_MOTHERSHIP_W = 18
        SPR_MOTHERSHIP_H = 18
        SPR_PLAYERSHIP_0_W = 6
        SPR_PLAYERSHIP_0_H = 8
        SPR_PLAYERSHIP_1_W = 6
        SPR_PLAYERSHIP_1_H = 8
        SPR_ENEMY1_0_W = 10
        SPR_ENEMY1_0_H = 10
        SPR_ENEMY1_1_W = 10
        SPR_ENEMY1_1_H = 10
        SPR_VSHOT_W = 1
        SPR_VSHOT_H = 24
        
                                        


    ;;;;;;;;;;;;;;;;;;;;
    ;; GLOBAL SYMBOLS ;;
    ;;;;;;;;;;;;;;;;;;;;
    ;;cpctelera
    .globl cpct_memset_asm      
    .globl cpct_memcpy_asm
    ;;animations      
    .globl man_anim_enemy1