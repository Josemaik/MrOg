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
                             13 .area _CODE
                             14 
   40C0                      15 physics_sys_init::
   40C0 C9            [10]   16     ret
                             17 
                             18 ;; Input
                             19 ;;   IX: Pointer to first entity to render
                             20 ;;    A: Number of entities to render
   40C1                      21 physics_sys_update::
   40C1 47            [ 4]   22     ld  b, a
                             23 
   40C2                      24 _update_loop:
                             25     ;; Update X
   40C2 3E 51         [ 7]   26     ld    a, #screen_width + 1
   40C4 DD 96 04      [19]   27     sub   e_w(ix)
   40C7 4F            [ 4]   28     ld    c, a
                             29 
   40C8 DD 7E 00      [19]   30     ld    a, e_x(ix)
   40CB DD 86 02      [19]   31     add   e_vx(ix)
   40CE B9            [ 4]   32     cp    c             ;; Comprueba con la primera posicion invalida
   40CF 30 05         [12]   33     jr   nc, invalid_x
   40D1                      34 valid_x:
   40D1 DD 77 00      [19]   35     ld   e_x(ix), a
   40D4 18 08         [12]   36     jr   endif_x
   40D6                      37 invalid_x:
   40D6 DD 7E 02      [19]   38     ld   a, e_vx(ix)
   40D9 ED 44         [ 8]   39     neg
   40DB DD 77 02      [19]   40     ld   e_vx(ix), a
   40DE                      41 endif_x:
                             42 
                             43     ;; Update Y ;; todo
                             44 
   40DE 05            [ 4]   45     dec  b
   40DF C8            [11]   46     ret  z
                             47 
   40E0 11 09 00      [10]   48     ld  de, #entity_size
   40E3 DD 19         [15]   49     add ix, de
   40E5 18 DB         [12]   50     jr _update_loop
                             51 
   40E7 C9            [10]   52     ret
