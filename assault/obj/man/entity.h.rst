ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 
                              2         ;;;;;;;;;;;;;;;;;;;;
                              3         ;; DEFINED VALUES ;;
                              4         ;;;;;;;;;;;;;;;;;;;;
                              5 
                              6     ;; Entity struct                 
                     0000     7         TYPE    = 0     ;;u8
                     0001     8         CMPs    = 1     ;;u8      
                     0002     9         X       = 2     ;;u8            
                     0003    10         Y       = 3     ;;u8
                     0004    11         WIDTH   = 4     ;;u8
                     0005    12         HEIGHT  = 5     ;;u8           
                     0006    13         VX      = 6     ;;i8
                     0007    14         VY      = 7     ;;i8            
                     0008    15         SPRITE  = 8     ;;u8(2)
                     000A    16         IA_behaviour  = 10 ;; u8(2)
                     000C    17         IA_COUNTER = 12
                     000D    18         AnimFrame = 13     ;;u8(2)
                     000F    19         AnimCounter = 15    ;;u8
                     0010    20         COLLIDES_AGAINST = 16    
                             21                                         
                             22     ;; Entity types                  
                     0000    23         E_TYPE_INVALID  = 0x00   ;; zero-byte to signal invalid entities
                     0001    24         E_TYPE_PLAYER   = 0x01 
                     0002    25         E_TYPE_ENEMY   = 0x02 
                     0004    26         E_TYPE_MOTHERSHIP   = 0x04 
                     0008    27         E_TYPE_SHOT   = 0x08 
                     0080    28         E_TYPE_DEAD     = 0x80   ;; upper bit signal dead entity
                     0002    29         E_TYPE_DEFAULT  = E_TYPE_ENEMY
                             30     ;; Components    
                     0001    31         E_CMP_RENDER   = 0x01   ;; renderable entity
                     0002    32         E_CMP_MOVABLE  = 0x02   ;; movable entity
                     0004    33         E_CMP_INPUT    = 0x04   ;; Entity controlable by input
                     0008    34         E_CMP_IA       = 0x08   ;; Entity controlable by artificial inteligence
                     0010    35         E_CMP_ANIMATED = 0x10   ;; Animated Entity
                     0020    36         E_CMP_COLLIDER = 0x20   ;; Entity that can collide
                     007F    37         E_CMP_DEFAULT  = 0x7F   ;; default entity  
                             38             
                             39                                         
                             40     ;; OTHERS
                     0011    41         SPACE_4_ONE_ENTITY     = 17      ;; space for one entity
                     000C    42         TOTAL_ENTITIES         = 12      ;; number of entities                          
                     00CC    43         TOTAL_SPACE_4_ENTITIES = SPACE_4_ONE_ENTITY*TOTAL_ENTITIES    ;;;Maximum  number of entities ( 210 )
                     000C    44         MAN_ANIM_ENEMY1_TIME   = 12
                             45     ;; LANES
                     0000    46         LANE_0		= 0											;;
                     0001    47 		LANE_1		= 1											;;
                     0002    48 		LANE_2		= 2	
                     001E    49         LANE_DY = 30
                     0028    50         LANE0_Y = 40
                     0046    51         LANE1_Y = LANE0_Y + LANE_DY
                     006E    52         LANE2_Y = 2*LANE0_Y + LANE_DY
                             53     ;; PLAYER
                     00B4    54         PLAYER_Y = 180
                     00AC    55         PLAYERSHOT_Y = PLAYER_Y - 8
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56     ;;   SPRITE PROPERTIES
                     0012    57         SPR_MOTHERSHIP_W = 18
                     0012    58         SPR_MOTHERSHIP_H = 18
                     0006    59         SPR_PLAYERSHIP_0_W = 6
                     0008    60         SPR_PLAYERSHIP_0_H = 8
                     0006    61         SPR_PLAYERSHIP_1_W = 6
                     0008    62         SPR_PLAYERSHIP_1_H = 8
                     000A    63         SPR_ENEMY1_0_W = 10
                     000A    64         SPR_ENEMY1_0_H = 10
                     000A    65         SPR_ENEMY1_1_W = 10
                     000A    66         SPR_ENEMY1_1_H = 10
                     0001    67         SPR_VSHOT_W = 1
                     0018    68         SPR_VSHOT_H = 24
                             69         
                             70                                         
                             71 
                             72 
                             73     ;;;;;;;;;;;;;;;;;;;;
                             74     ;; GLOBAL SYMBOLS ;;
                             75     ;;;;;;;;;;;;;;;;;;;;
                             76     ;;cpctelera
                             77     .globl cpct_memset_asm      
                             78     .globl cpct_memcpy_asm
                             79     ;;animations      
                             80     .globl man_anim_enemy1
