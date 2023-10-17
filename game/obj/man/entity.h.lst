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
                     0011    21         last_draw = 17
                     0013    22         direction = 19
                             23                                         
                             24     ;; Entity types                  
                     0000    25         E_TYPE_INVALID  = 0x00   ;; zero-byte to signal invalid entities
                     0001    26         E_TYPE_PLAYER   = 0x01 
                     0002    27         E_TYPE_ENEMY   = 0x02 
                     0004    28         E_TYPE_MOTHERSHIP   = 0x04 
                     0008    29         E_TYPE_SHOT   = 0x08 
                     0080    30         E_TYPE_DEAD     = 0x80   ;; upper bit signal dead entity
                     0002    31         E_TYPE_DEFAULT  = E_TYPE_ENEMY
                             32     ;; Components    
                     0001    33         E_CMP_RENDER   = 0x01   ;; renderable entity
                     0002    34         E_CMP_MOVABLE  = 0x02   ;; movable entity
                     0004    35         E_CMP_INPUT    = 0x04   ;; Entity controlable by input
                     0008    36         E_CMP_IA       = 0x08   ;; Entity controlable by artificial inteligence
                     0010    37         E_CMP_ANIMATED = 0x10   ;; Animated Entity
                     0020    38         E_CMP_COLLIDER = 0x20   ;; Entity that can collide
                     007F    39         E_CMP_DEFAULT  = 0x7F   ;; default entity  
                             40             
                             41                                         
                             42     ;; OTHERS
                     0014    43         SPACE_4_ONE_ENTITY     = 20      ;; space for one entity
                     0001    44         TOTAL_ENTITIES         = 1      ;; number of entities                          
                     0014    45         TOTAL_SPACE_4_ENTITIES = SPACE_4_ONE_ENTITY*TOTAL_ENTITIES    ;;;Maximum  number of entities ( 210 )
                     000C    46         MAN_ANIM_ENEMY1_TIME   = 12
                             47     ;; DIRECTIONS
                     0001    48     DIRECT_W == 0x01
                     0002    49     DIRECT_A == 0x02
                     0004    50     DIRECT_S == 0x04
                     0008    51     DIRECT_D == 0x08
                             52       
                             53     ;; PLAYER
                             54        
                             55     ;;   SPRITE PROPERTIES
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                     0008    56        SPR_SPRITE1_S_W = 8
                     0010    57        SPR_SPRITE1_S_H = 16
                             58         
                             59                                         
                             60 
                             61 
                             62     ;;;;;;;;;;;;;;;;;;;;
                             63     ;; GLOBAL SYMBOLS ;;
                             64     ;;;;;;;;;;;;;;;;;;;;
                             65     ;;cpctelera
                             66     .globl cpct_memset_asm      
                             67     .globl cpct_memcpy_asm
                             68     ;;animations      
                             69    
