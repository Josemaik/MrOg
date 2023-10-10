ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; Physics System
                              3 ;;   Definition to entities physics
                              4 ;;
                              5 .module Physics_System
                              6 
                     0050     7 screen_width  = 80
                     00C8     8 screen_height = 200
                              9 
                             10 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             11 ;; Code
                             12 ;;
                             13 .area _DATA
                             14 .area _CODE
                             15 
   41D2                      16 physics_sys_init::
   41D2 C9            [10]   17     ret
                             18 
                             19 ;; Input
                             20 ;;   IX: Pointer to first entity to render
                             21 ;;    A: Number of entities to render
   41D3                      22 physics_sys_update::
   41D3 47            [ 4]   23     ld  b, a
                             24 
   41D4                      25 _update_loop:
                             26     ;; Update X
   41D4 3E 51         [ 7]   27     ld    a, #screen_width + 1
   41D6 DD 96 04      [19]   28     sub   e_w(ix)
   41D9 4F            [ 4]   29     ld    c, a
                             30 
   41DA DD 7E 00      [19]   31     ld    a, e_x(ix)
   41DD DD 86 02      [19]   32     add   e_vx(ix)
   41E0 B9            [ 4]   33     cp    c             ;; Comprueba con la primera posicion invalida
   41E1 30 05         [12]   34     jr   nc, invalid_x
   41E3                      35 valid_x:
   41E3 DD 77 00      [19]   36     ld   e_x(ix), a
   41E6 18 00         [12]   37     jr   endif_x
   41E8                      38 invalid_x:
                             39     
   41E8                      40 endif_x:
                             41 
                             42     ;; Update Y
   41E8 3E C9         [ 7]   43     ld    a, #screen_height + 1
   41EA DD 96 05      [19]   44     sub   e_h(ix)
   41ED 4F            [ 4]   45     ld    c, a
                             46 
   41EE DD 7E 01      [19]   47     ld    a, e_y(ix)
   41F1 DD 86 03      [19]   48     add   e_vy(ix)
   41F4 B9            [ 4]   49     cp    c             ;; Comprueba con la primera posicion invalida
   41F5 30 05         [12]   50     jr   nc, invalid_y
   41F7                      51 valid_y:
   41F7 DD 77 01      [19]   52     ld   e_y(ix), a
   41FA 18 00         [12]   53     jr   endif_y
   41FC                      54 invalid_y:
                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   41FC                      56 endif_y:
                             57 
   41FC 05            [ 4]   58     dec  b
   41FD C8            [11]   59     ret  z
                             60 
   41FE 11 09 00      [10]   61     ld  de, #entity_size
   4201 DD 19         [15]   62     add ix, de
   4203 18 CF         [12]   63     jr _update_loop
                             64 
   4205 C9            [10]   65     ret
