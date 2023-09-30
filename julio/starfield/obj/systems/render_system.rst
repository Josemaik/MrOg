ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; Render System
                              3 ;;   Definition to render entities
                              4 ;;
                              5 .module Render_System
                              6 
                              7 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              8 ;; Global Symbols
                              9 ;;
                             10 .globl rendersys_update
                             11 .globl cpct_getScreenPtr_asm
                             12 .globl cpct_drawSolidBox_asm
                             13 
                             14 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             15 ;; Code
                             16 ;;
                             17 .area _CODE
                             18 
   4088                      19 rendersys_init::
   4088 C9            [10]   20     ret
                             21 
                             22 ;; Input
                             23 ;;   IX: Pointer to first entity to render
                             24 ;;    A: Number of entities to render
   4089                      25 rendersys_update::
                             26 
   4089                      27 _renloop:
   4089 F5            [11]   28     push af
                             29 
   408A 11 00 C0      [10]   30     ld  de, #0xC000
   408D DD 4E 01      [19]   31     ld   c, 1(ix)    ;; X
   4090 DD 46 02      [19]   32     ld   b, 2(ix)    ;; Y
   4093 CD 57 41      [17]   33     call cpct_getScreenPtr_asm
                             34 
   4096 EB            [ 4]   35     ex  de, hl
   4097 DD 7E 04      [19]   36     ld   a, 4(ix)    ;; Color
   409A 0E 02         [ 7]   37     ld   c, #2       ;; Width 
   409C 06 08         [ 7]   38     ld   b, #8       ;; Height 
   409E CD B3 40      [17]   39     call cpct_drawSolidBox_asm
                             40 
   40A1 F1            [10]   41     pop af
                             42 
   40A2 3D            [ 4]   43     dec a
   40A3 C8            [11]   44     ret z
                             45 
   40A4 01 05 00      [10]   46     ld  bc, #entity_size
   40A7 DD 09         [15]   47     add ix, bc
   40A9 18 DE         [12]   48     jr _renloop
