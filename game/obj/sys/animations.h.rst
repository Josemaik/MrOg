ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1         ;;;;;;;;;;;;;;;;;;;;
                              2         ;; DEFINED VALUES ;;
                              3         ;;;;;;;;;;;;;;;;;;;;
                              4           ;; cpctelera
                     0003     5     SPACE_OF_AIMATION = 3
                              6 
                              7     ;; Animation struct                              		
                     0000     8         TIME            = 0  ;; u8            
                     0001     9         VAL_NEXT_FRAME  = 1  ;; u8 (2b)  
                             10                                           
                             11    ;; managers                            
                             12       .globl _man_entity_for_all_matching                  
                             13    ;; systems                             
                             14 
                             15    ;; sprites
