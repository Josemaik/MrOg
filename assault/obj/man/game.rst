ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module Game_Manager
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              2 .include "game.h.s"
                              1 
                              2         ;;;;;;;;;;;;;;;;;;;;
                              3         ;; DEFINED VALUES ;;
                              4         ;;;;;;;;;;;;;;;;;;;;    
                              5                                         
                              6     ;;;;;;;;;;;;;;;;;;;;
                              7     ;; GLOBAL SYMBOLS ;;
                              8     ;;;;;;;;;;;;;;;;;;;;
                              9     .globl cpct_memset_asm      
                             10     .globl cpct_memcpy_asm              
                             11     .globl cpct_waitVSYNC_asm           
                             12     .globl cpct_waitHalts_asm           
                             13                                           
                             14    ;; managers                            
                             15       .globl _man_entity_init             
                             16       .globl _man_entity_update           
                             17                                           
                             18    ;; systems                             
                             19       .globl _sys_physics_update          
                             20       .globl _sys_render_update                  
                             21       .globl _sys_render_init 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              3 
                              4 .area _DATA
                              5 
                              6 .area _CODE
                              7 
                              8 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              9 ;; PUBLIC FUNCTIONS        ;
                             10 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             11 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             12 ; GAME INIT
                             13 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   4159                      14 man_game_init::
                             15     ;; configuramos modo de video, paleta y borde
   4159 CD 68 40      [17]   16       call     _sys_render_init
                             17    ;; inicializamos manager de entidades
   415C CD 9A 40      [17]   18       call     _man_entity_init 
                             19 
                             20 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             21 ;; PLAY
                             22 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   415F                      23 man_game_play::
                             24 ;; Bucle infinito
   415F                      25    loop:
                             26       ;; actualizamos posiciones
   415F CD 20 40      [17]   27          call     _sys_physics_update
                             28       ;; renderizamos
   4162 CD 61 40      [17]   29          call     _sys_render_update
                             30       ;; actualizamos manager
   4165 CD 30 41      [17]   31          call     _man_entity_update
                             32       ;; señal de sincronización
   4168 CD 2E 42      [17]   33          call cpct_waitVSYNC_asm
                             34       ;; saltamos a loop
   416B 18 F2         [12]   35          jr       loop
