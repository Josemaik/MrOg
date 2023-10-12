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
   4327                      16 physics_sys_init::
   4327 C9            [10]   17     ret
                             18 
                             19 ;; Input
                             20 ;;   IX: Pointer to first entity to render
                             21 ;;    A: Number of entities to render
   4328                      22 physics_sys_update::
   4328 47            [ 4]   23     ld  b, a
                             24 
   4329                      25 _update_loop:
                             26     ;; Update X
   4329 3E 51         [ 7]   27     ld    a, #screen_width + 1
   432B DD 96 04      [19]   28     sub   e_w(ix)
   432E 4F            [ 4]   29     ld    c, a
                             30 
   432F DD 7E 00      [19]   31     ld    a, e_x(ix)
   4332 DD 86 02      [19]   32     add   e_vx(ix)
   4335 B9            [ 4]   33     cp    c             ;; Comprueba con la primera posicion invalida
   4336 30 05         [12]   34     jr   nc, invalid_x
   4338                      35 valid_x:
   4338 DD 77 00      [19]   36     ld   e_x(ix), a
   433B 18 08         [12]   37     jr   endif_x
   433D                      38 invalid_x:
   433D DD 7E 02      [19]   39     ld   a, e_vx(ix)
   4340 ED 44         [ 8]   40     neg
   4342 DD 77 02      [19]   41     ld   e_vx(ix), a
                             42     
   4345                      43 endif_x:
                             44 
                             45     ;; Update Y
   4345 3E C9         [ 7]   46     ld    a, #screen_height + 1
   4347 DD 96 05      [19]   47     sub   e_h(ix)
   434A 4F            [ 4]   48     ld    c, a
                             49 
   434B DD 7E 01      [19]   50     ld    a, e_y(ix)
   434E DD 86 03      [19]   51     add   e_vy(ix)
   4351 B9            [ 4]   52     cp    c             ;; Comprueba con la primera posicion invalida
   4352 30 05         [12]   53     jr   nc, invalid_y
   4354                      54 valid_y:
   4354 DD 77 01      [19]   55     ld   e_y(ix), a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   4357 18 07         [12]   56     jr   endif_y
   4359                      57 invalid_y:
                             58     ;; IX
   4359 C5            [11]   59     push bc
   435A D5            [11]   60     push de
   435B CD C5 42      [17]   61     call entity_man_destroy  ;; Modify HL, DE, BC
   435E D1            [10]   62     pop de
   435F C1            [10]   63     pop bc
   4360                      64 endif_y:
                             65 
   4360 05            [ 4]   66     dec  b
   4361 C8            [11]   67     ret  z
                             68 
   4362 11 0A 00      [10]   69     ld  de, #entity_size
   4365 DD 19         [15]   70     add ix, de
   4367 18 C0         [12]   71     jr _update_loop
                             72 
   4369 C9            [10]   73     ret
