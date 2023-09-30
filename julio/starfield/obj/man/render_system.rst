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
                              9 .globl man_entity_getEntitySize
                             10 
   4087                      11 rendersys_init::
   4087 C9            [10]   12     ret
                             13 
                             14 ;; Input
                             15 ;;   IX: Pointer to first entity to render
                             16 ;;    A: Number of entities to render
   4088                      17 rendersys_update::
                             18 
   4088                      19 _renloop:
   4088 F5            [11]   20     push af
                             21 
   4089 11 00 C0      [10]   22     ld  de, #0xC000
   408C DD 4E 01      [19]   23     ld   c, 1(ix)    ;; X
   408F DD 46 02      [19]   24     ld   b, 2(ix)    ;; Y
   4092 CD 5D 41      [17]   25     call cpct_getScreenPtr_asm
                             26 
   4095 EB            [ 4]   27     ex  de, hl
   4096 DD 7E 04      [19]   28     ld   a, 4(ix)    ;; Color
   4099 0E 02         [ 7]   29     ld   c, #2       ;; Width 
   409B 06 08         [ 7]   30     ld   b, #8       ;; Height 
   409D CD BA 40      [17]   31     call cpct_drawSolidBox_asm
                             32 
   40A0 F1            [10]   33     pop af
                             34 
   40A1 3D            [ 4]   35     dec a
   40A2 C8            [11]   36     ret z
                             37 
   40A3 CD 00 00      [17]   38     call man_entity_getEntitySize
   40A6 DD 09         [15]   39     add ix, bc
   40A8 18 DE         [12]   40     jr _renloop
