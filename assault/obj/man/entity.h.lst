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
                             16                                         
                             17     ;; Entity types                  
                     0000    18         E_TYPE_INVALID  = 0x00   ;; zero-byte to signal invalid entities     
                     0001    19         E_TYPE_RENDER   = 0x01   ;; renderable entity
                     0002    20         E_TYPE_MOVABLE  = 0x02   ;; movable entity
                     0004    21         E_TYPE_INPUT    = 0x04   ;; Entity controlable by input
                     0008    22         E_TYPE_IA       = 0x08   ;; Entity controlable by artificial inteligence
                     0080    23         E_TYPE_DEAD     = 0x80   ;; upper bit signal dead entity
                     007F    24         E_TYPE_DEFAULT  = 0x7F   ;; default entity       
                             25                                         
                             26     ;; OTHERS
                     000B    27         SPACE_4_ONE_ENTITY     = 11      ;; space for one entity
                     000C    28         TOTAL_ENTITIES         = 12      ;; number of entities                          
                     0084    29         TOTAL_SPACE_4_ENTITIES = SPACE_4_ONE_ENTITY*TOTAL_ENTITIES    ;;;Maximum  number of entities ( 210 )
                             30     ;;   SPRITE PROPERTIES
                     0012    31         SPR_MOTHERSHIP_W = 18
                     0012    32         SPR_MOTHERSHIP_H = 18
                     0006    33         SPR_PLAYERSHIP_0_W = 6
                     0008    34         SPR_PLAYERSHIP_0_H = 8
                     0006    35         SPR_PLAYERSHIP_1_W = 6
                     0008    36         SPR_PLAYERSHIP_1_H = 8
                     000A    37         SPR_ENEMY1_0_W = 10
                     000A    38         SPR_ENEMY1_0_H = 10
                     000A    39         SPR_ENEMY1_1_W = 10
                     000A    40         SPR_ENEMY1_1_H = 10
                             41         
                             42                                         
                             43 
                             44 
                             45     ;;;;;;;;;;;;;;;;;;;;
                             46     ;; GLOBAL SYMBOLS ;;
                             47     ;;;;;;;;;;;;;;;;;;;;
                             48     .globl cpct_memset_asm      
                             49     .globl cpct_memcpy_asm      
