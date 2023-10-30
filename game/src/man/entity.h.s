
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
        last_draw = 17
        ; last_draw2 = 19
        direction = 19

                                        
    ;; Entity types                  
        E_TYPE_INVALID  = 0x00   ;; zero-byte to signal invalid entities
        E_TYPE_PLAYER   = 0x01 
        E_TYPE_ENEMY   = 0x02 
        E_TYPE_ENEMY2   = 0x04 
        E_TYPE_ENEMY3 = 0x10
        E_TYPE_ENEMY4 = 0x12
        E_TYPE_FOOD   = 0x16
        E_TYPE_DOOR   = 0x24
        E_TYPE_KEY   = 0x28
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
        SPACE_4_ONE_ENTITY     = 20    ;; space for one entity
        TOTAL_ENTITIES         = 11     ;; number of entities                          
        TOTAL_SPACE_4_ENTITIES = SPACE_4_ONE_ENTITY*TOTAL_ENTITIES    ;;;Maximum  number of entities ( 210 )
        TIME_TO_UPDATE_PHYSICS_X_PLAYER = 3
        TIME_TO_UPDATE_PHYSICS_X_ENEMIE = 6
        MAN_ANIM_PLAYER_TIME   = 3
        MAN_ANIM_PLAYER_ENEMY = 5
        MAN_ANIM_PLAYER_KEY = 10
        MAN_ANIM_PLAYER_HIT_ENEMY == 35
        MAN_ANIM_PLAYER_HIT_ENEMY_TIME = 20
        MAN_ANIM_PLAYER_EAT == 5
    ;; DIRECTIONS
    DIRECT_W == 0x01
    DIRECT_A == 0x02
    DIRECT_S == 0x04
    DIRECT_D == 0x08
      
    ;; PLAYER
       
    ;;   SPRITE PROPERTIES
       SPR_SPRITE1_S_W = 8
       SPR_SPRITE1_S_H = 16
       SPR_ENEMIE_FLOBIER_W = 8
       SPR_ENEMIE_FLOBIER_H = 16
       SPR_HELADO_W = 8
       SPR_HELADO_H = 16
	   SPR_PUERTA_HORIZONTAL_W = 8 
	   SPR_PUERTA_HORIZONTAL_H = 8 
       SPR_PUERTA_VERTICAL_W = 4
       SPR_PUERTA_VERTICAL_H = 16
       SPR_LLAVE_W = 8
       SPR_LLAVE_H = 16
                                        

    ;;;;;;;;;;;;;;;;;;;;
    ;; GLOBAL SYMBOLS ;;
    ;;;;;;;;;;;;;;;;;;;;
    ;;cpctelera
    .globl cpct_memset_asm      
    .globl cpct_memcpy_asm
    ;;sys     
    .globl anim_enemy_down
    .globl anim_enemy_left
    .globl anim_llave
    ;;man
    .globl player_state
    .globl time_anim_died
    .globl player_reaparition
    .globl food_state
    .globl time_anim_eat
    .globl consumibles_actuales
    .globl cambio_de_mapa
   