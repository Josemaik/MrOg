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
   42A9                      16 physics_sys_init::
   42A9 C9            [10]   17     ret
                             18 
                             19 ;; Input
                             20 ;;   IX: Pointer to first entity to render
                             21 ;;    A: Number of entities to render
   42AA                      22 physics_sys_update::
   42AA 47            [ 4]   23     ld  b, a
                             24 
   42AB                      25 _update_loop:
                             26     ;; Update X
   42AB 3E 51         [ 7]   27     ld    a, #screen_width + 1
   42AD DD 96 04      [19]   28     sub   e_w(ix)
   42B0 4F            [ 4]   29     ld    c, a
                             30 
   42B1 DD 7E 00      [19]   31     ld    a, e_x(ix)
   42B4 DD 86 02      [19]   32     add   e_vx(ix)
   42B7 B9            [ 4]   33     cp    c             ;; Comprueba con la primera posicion invalida
   42B8 30 05         [12]   34     jr   nc, invalid_x
   42BA                      35 valid_x:
   42BA DD 77 00      [19]   36     ld   e_x(ix), a
   42BD 18 00         [12]   37     jr   endif_x
   42BF                      38 invalid_x:
                             39     
   42BF                      40 endif_x:
                             41 
                             42     ;; Update Y
   42BF 3E C9         [ 7]   43     ld    a, #screen_height + 1
   42C1 DD 96 05      [19]   44     sub   e_h(ix)
   42C4 4F            [ 4]   45     ld    c, a
                             46 
   42C5 DD 7E 01      [19]   47     ld    a, e_y(ix)
   42C8 DD 86 03      [19]   48     add   e_vy(ix)
   42CB B9            [ 4]   49     cp    c             ;; Comprueba con la primera posicion invalida
   42CC 30 05         [12]   50     jr   nc, invalid_y
   42CE                      51 valid_y:
   42CE DD 77 01      [19]   52     ld   e_y(ix), a
   42D1 18 00         [12]   53     jr   endif_y
   42D3                      54 invalid_y:
                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   42D3                      56 endif_y:
                             57 
   42D3 05            [ 4]   58     dec  b
   42D4 C8            [11]   59     ret  z
                             60 
   42D5 11 0A 00      [10]   61     ld  de, #entity_size
   42D8 DD 19         [15]   62     add ix, de
   42DA 18 CF         [12]   63     jr _update_loop
                             64 
   42DC C9            [10]   65     ret
