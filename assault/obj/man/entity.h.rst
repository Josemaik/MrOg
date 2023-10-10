ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 
                              2         ;;;;;;;;;;;;;;;;;;;;
                              3         ;; DEFINED VALUES ;;
                              4         ;;;;;;;;;;;;;;;;;;;;
                              5 
                              6     ;; Entity struct                 
                     0000     7         TYPE    = 0     ;;u8            
                     0001     8         X       = 1     ;;u8            
                     0002     9         Y       = 2     ;;u8
                     0003    10         WIDTH   = 3     ;;u8
                     0004    11         HEIGHT  = 4     ;;u8           
                     0005    12         VX      = 5     ;;i8
                     0006    13         VY      = 6     ;;i8            
                     0007    14         SPRITE  = 7     ;;u8(2)
                     0009    15         IA_behaviour  = 9 ;; u8(2)
                     000B    16         AnimFrame = 11     ;;u8(2)
                     000D    17         AnimCounter = 13    ;;u8    
                             18                                         
                             19     ;; Entity types                  
                     0000    20         E_TYPE_INVALID  = 0x00   ;; zero-byte to signal invalid entities     
                     0001    21         E_TYPE_RENDER   = 0x01   ;; renderable entity
                     0002    22         E_TYPE_MOVABLE  = 0x02   ;; movable entity
                     0004    23         E_TYPE_INPUT    = 0x04   ;; Entity controlable by input
                     0008    24         E_TYPE_IA       = 0x08   ;; Entity controlable by artificial inteligence
                     0010    25         E_TYPE_ANIMATED = 0x10   ;; Animated Entity
                     0080    26         E_TYPE_DEAD     = 0x80   ;; upper bit signal dead entity
                     007F    27         E_TYPE_DEFAULT  = 0x7F   ;; default entity       
                             28                                         
                             29     ;; OTHERS
                     000E    30         SPACE_4_ONE_ENTITY     = 14      ;; space for one entity
                     000C    31         TOTAL_ENTITIES         = 12      ;; number of entities                          
                     00A8    32         TOTAL_SPACE_4_ENTITIES = SPACE_4_ONE_ENTITY*TOTAL_ENTITIES    ;;;Maximum  number of entities ( 210 )
                             33     ;;   SPRITE PROPERTIES
                     0012    34         SPR_MOTHERSHIP_W = 18
                     0012    35         SPR_MOTHERSHIP_H = 18
                     0006    36         SPR_PLAYERSHIP_0_W = 6
                     0008    37         SPR_PLAYERSHIP_0_H = 8
                     0006    38         SPR_PLAYERSHIP_1_W = 6
                     0008    39         SPR_PLAYERSHIP_1_H = 8
                     000A    40         SPR_ENEMY1_0_W = 10
                     000A    41         SPR_ENEMY1_0_H = 10
                     000A    42         SPR_ENEMY1_1_W = 10
                     000A    43         SPR_ENEMY1_1_H = 10
                             44         
                             45                                         
                             46 
                             47 
                             48     ;;;;;;;;;;;;;;;;;;;;
                             49     ;; GLOBAL SYMBOLS ;;
                             50     ;;;;;;;;;;;;;;;;;;;;
                             51     ;;cpctelera
                             52     .globl cpct_memset_asm      
                             53     .globl cpct_memcpy_asm
                             54     ;;animations      
                             55     .globl man_anim_enemy1
