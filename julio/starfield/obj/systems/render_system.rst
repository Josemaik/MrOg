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
                             10 .globl render_sys_update
                             11 .globl cpct_getScreenPtr_asm
                             12 .globl cpct_drawSolidBox_asm
                             13 
                             14 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             15 ;; Code
                             16 ;;
                             17 .area _CODE
                             18 
   40DC                      19 render_sys_init::
   40DC C9            [10]   20     ret
                             21 
                             22 ;; Input
                             23 ;;   IX: Pointer to first entity to render
                             24 ;;    A: Number of entities to render
   40DD                      25 render_sys_update::
                             26 
   40DD                      27 _render_loop:
   40DD F5            [11]   28     push af
                             29 
   40DE 11 00 C0      [10]   30     ld  de, #0xC000
   40E1 DD 4E 01      [19]   31     ld   c, e_x(ix)    ;; X
   40E4 DD 46 02      [19]   32     ld   b, e_y(ix)    ;; Y
   40E7 CD AD 41      [17]   33     call cpct_getScreenPtr_asm
                             34 
   40EA EB            [ 4]   35     ex  de, hl
   40EB DD 7E 07      [19]   36     ld   a, e_color(ix)    ;; Color
   40EE DD 4E 05      [19]   37     ld   c, e_w(ix)        ;; Width 
   40F1 DD 46 06      [19]   38     ld   b, e_h(ix)        ;; Height 
   40F4 CD 09 41      [17]   39     call cpct_drawSolidBox_asm
                             40 
   40F7 F1            [10]   41     pop af
                             42 
   40F8 3D            [ 4]   43     dec a
   40F9 C8            [11]   44     ret z
                             45 
   40FA 01 08 00      [10]   46     ld  bc, #entity_size
   40FD DD 09         [15]   47     add ix, bc
   40FF 18 DC         [12]   48     jr _render_loop
