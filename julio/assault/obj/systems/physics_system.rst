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
   4413                      16 physics_sys_init::
   4413 C9            [10]   17     ret
                             18 
                             19 ;; Input
                             20 ;;   IX: Pointer to first entity to render
                             21 ;;    A: Number of entities to render
   4414                      22 physics_sys_update::
   4414 47            [ 4]   23     ld  b, a
                             24 
   4415                      25 _update_loop:
                             26     ;; Update X
   4415 3E 51         [ 7]   27     ld    a, #screen_width + 1
   4417 DD 96 04      [19]   28     sub   e_w(ix)
   441A 4F            [ 4]   29     ld    c, a
                             30 
   441B DD 7E 00      [19]   31     ld    a, e_x(ix)
   441E DD 86 02      [19]   32     add   e_vx(ix)
   4421 B9            [ 4]   33     cp    c             ;; Comprueba con la primera posicion invalida
   4422 30 05         [12]   34     jr   nc, invalid_x
   4424                      35 valid_x:
   4424 DD 77 00      [19]   36     ld   e_x(ix), a
   4427 18 08         [12]   37     jr   endif_x
   4429                      38 invalid_x:
   4429 DD 7E 02      [19]   39     ld   a, e_vx(ix)
   442C ED 44         [ 8]   40     neg
   442E DD 77 02      [19]   41     ld   e_vx(ix), a
                             42     
   4431                      43 endif_x:
                             44 
                             45     ;; Update Y
   4431 3E C9         [ 7]   46     ld    a, #screen_height + 1
   4433 DD 96 05      [19]   47     sub   e_h(ix)
   4436 4F            [ 4]   48     ld    c, a
                             49 
   4437 DD 7E 01      [19]   50     ld    a, e_y(ix)
   443A DD 86 03      [19]   51     add   e_vy(ix)
   443D B9            [ 4]   52     cp    c             ;; Comprueba con la primera posicion invalida
   443E 30 05         [12]   53     jr   nc, invalid_y
   4440                      54 valid_y:
   4440 DD 77 01      [19]   55     ld   e_y(ix), a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   4443 18 07         [12]   56     jr   endif_y
   4445                      57 invalid_y:
                             58     ;; IX
   4445 C5            [11]   59     push bc
   4446 D5            [11]   60     push de
   4447 CD B1 43      [17]   61     call entity_man_destroy  ;; Modify HL, DE, BC
   444A D1            [10]   62     pop de
   444B C1            [10]   63     pop bc
   444C                      64 endif_y:
                             65 
   444C 05            [ 4]   66     dec  b
   444D C8            [11]   67     ret  z
                             68 
   444E 11 0A 00      [10]   69     ld  de, #entity_size
   4451 DD 19         [15]   70     add ix, de
   4453 18 C0         [12]   71     jr _update_loop
                             72 
   4455 C9            [10]   73     ret
