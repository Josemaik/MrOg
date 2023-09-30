ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module Render_System
                              2 
                              3     .area _CODE
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5     .include "render_system.inc"
                              1 ;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; Render System
                              3 
                              4 
                              5 ;;;;;;;;;;;;;;;;;;;;;;;;
                              6 ;; Global Symbols
                              7 .globl rendersys_update
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 
                              7 .globl cpct_getScreenPtr_asm
                              8 .globl cpct_drawSolidBox_asm
                              9 
   406E                      10 rendersys_init::
   406E C9            [10]   11     ret
                             12 
                             13 ;; Input
                             14 ;;   IX: Pointer to first entity to render
                             15 ;;    A: Number of entities to render
   406F                      16 rendersys_update::
                             17     ;; tipo , x , y , vx , color
                             18 
   406F 11 00 C0      [10]   19     ld  de, #0xC000
   4072 DD 4E 01      [19]   20     ld   c, 1(ix)    ;; X
   4075 DD 46 02      [19]   21     ld   b, 2(ix)    ;; Y
   4078 CD 3A 41      [17]   22     call cpct_getScreenPtr_asm
                             23 
   407B EB            [ 4]   24     ex  de, hl
   407C DD 7E 04      [19]   25     ld   a, 4(ix)    ;; Color
   407F 0E 02         [ 7]   26     ld   c, #2       ;; Width 
   4081 06 08         [ 7]   27     ld   b, #8       ;; Height 
   4083 CD 97 40      [17]   28     call cpct_drawSolidBox_asm
                             29 
   4086 C9            [10]   30     ret
