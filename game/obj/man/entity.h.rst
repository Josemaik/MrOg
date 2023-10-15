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
                             22                                         
                             23     ;; Entity types                  
                     0000    24         E_TYPE_INVALID  = 0x00   ;; zero-byte to signal invalid entities
                     0001    25         E_TYPE_PLAYER   = 0x01 
                     0002    26         E_TYPE_ENEMY   = 0x02 
                     0004    27         E_TYPE_MOTHERSHIP   = 0x04 
                     0008    28         E_TYPE_SHOT   = 0x08 
                     0080    29         E_TYPE_DEAD     = 0x80   ;; upper bit signal dead entity
                     0002    30         E_TYPE_DEFAULT  = E_TYPE_ENEMY
                             31     ;; Components    
                     0001    32         E_CMP_RENDER   = 0x01   ;; renderable entity
                     0002    33         E_CMP_MOVABLE  = 0x02   ;; movable entity
                     0004    34         E_CMP_INPUT    = 0x04   ;; Entity controlable by input
                     0008    35         E_CMP_IA       = 0x08   ;; Entity controlable by artificial inteligence
                     0010    36         E_CMP_ANIMATED = 0x10   ;; Animated Entity
                     0020    37         E_CMP_COLLIDER = 0x20   ;; Entity that can collide
                     007F    38         E_CMP_DEFAULT  = 0x7F   ;; default entity  
                             39             
                             40                                         
                             41     ;; OTHERS
                     0013    42         SPACE_4_ONE_ENTITY     = 19      ;; space for one entity
                     0001    43         TOTAL_ENTITIES         = 1      ;; number of entities                          
                     0013    44         TOTAL_SPACE_4_ENTITIES = SPACE_4_ONE_ENTITY*TOTAL_ENTITIES    ;;;Maximum  number of entities ( 210 )
                     000C    45         MAN_ANIM_ENEMY1_TIME   = 12
                             46     ;; LANES
                             47       
                             48     ;; PLAYER
                             49        
                             50     ;;   SPRITE PROPERTIES
                     0008    51        SPR_SPRITE1_S_W = 8
                     0010    52        SPR_SPRITE1_S_H = 16
                             53         
                             54                                         
                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 
                             57     ;;;;;;;;;;;;;;;;;;;;
                             58     ;; GLOBAL SYMBOLS ;;
                             59     ;;;;;;;;;;;;;;;;;;;;
                             60     ;;cpctelera
                             61     .globl cpct_memset_asm      
                             62     .globl cpct_memcpy_asm
                             63     ;;animations      
                             64    
