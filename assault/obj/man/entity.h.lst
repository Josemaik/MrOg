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
                     0003    10         Width   = 3     ;;u8
                     0004    11         Height  = 4     ;;u8       
                     0005    12         VX      = 5     ;;i8
                     0006    13         VY      = 6     ;;i8             
                     0007    14         sprite  = 7     ;;*u8 (2b)      
                             15                                         
                             16     ;; Entity types                  
                     0000    17         E_TYPE_INVALID  = 0x00          
                     0001    18         E_TYPE_RENDER    = 0x01         
                     0002    19         E_TYPE_MOVABLE    = 0x02 
                     0004    20         E_TYPE_INPUT    = 0x04 
                     0080    21         E_TYPE_DEAD     = 0x80          
                     007F    22         E_TYPE_DEFAULT  = 0x7F          
                             23                                         
                             24     ;; OTHERS                              
                     0009    25         SPACE_4_ONE_ENTITY     = 9      
                     000C    26         TOTAL_ENTITIES         = 12
                     006C    27         MAX_SPACE_4_ENTITIES = SPACE_4_ONE_ENTITY * TOTAL_ENTITIES;      
                             28                                         
                             29 
                             30 
                             31     ;;;;;;;;;;;;;;;;;;;;
                             32     ;; GLOBAL SYMBOLS ;;
                             33     ;;;;;;;;;;;;;;;;;;;;
                             34     .globl cpct_memset_asm      
                             35     .globl cpct_memcpy_asm      
