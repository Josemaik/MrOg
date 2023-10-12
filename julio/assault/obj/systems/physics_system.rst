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
   4490                      16 physics_sys_init::
   4490 C9            [10]   17     ret
                             18 
                             19 ;; Input
                             20 ;;   IX: Pointer to first entity to render
                             21 ;;    A: Number of entities to render
   4491                      22 physics_sys_update::
   4491 47            [ 4]   23     ld  b, a
                             24 
   4492                      25 _update_loop:
                             26     ;; Update X
   4492 3E 51         [ 7]   27     ld    a, #screen_width + 1
   4494 DD 96 04      [19]   28     sub   e_w(ix)
   4497 4F            [ 4]   29     ld    c, a
                             30 
   4498 DD 7E 00      [19]   31     ld    a, e_x(ix)
   449B DD 86 02      [19]   32     add   e_vx(ix)
   449E B9            [ 4]   33     cp    c             ;; Comprueba con la primera posicion invalida
   449F 30 05         [12]   34     jr   nc, invalid_x
   44A1                      35 valid_x:
   44A1 DD 77 00      [19]   36     ld   e_x(ix), a
   44A4 18 08         [12]   37     jr   endif_x
   44A6                      38 invalid_x:
   44A6 DD 7E 02      [19]   39     ld   a, e_vx(ix)
   44A9 ED 44         [ 8]   40     neg
   44AB DD 77 02      [19]   41     ld   e_vx(ix), a
                             42     
   44AE                      43 endif_x:
                             44 
                             45     ;; Update Y
   44AE 3E C9         [ 7]   46     ld    a, #screen_height + 1
   44B0 DD 96 05      [19]   47     sub   e_h(ix)
   44B3 4F            [ 4]   48     ld    c, a
                             49 
   44B4 DD 7E 01      [19]   50     ld    a, e_y(ix)
   44B7 DD 86 03      [19]   51     add   e_vy(ix)
   44BA B9            [ 4]   52     cp    c             ;; Comprueba con la primera posicion invalida
   44BB 30 05         [12]   53     jr   nc, invalid_y
   44BD                      54 valid_y:
   44BD DD 77 01      [19]   55     ld   e_y(ix), a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   44C0 18 07         [12]   56     jr   endif_y
   44C2                      57 invalid_y:
                             58     ;; IX
   44C2 C5            [11]   59     push bc
   44C3 D5            [11]   60     push de
   44C4 CD 2E 44      [17]   61     call entity_man_destroy  ;; Modify HL, DE, BC
   44C7 D1            [10]   62     pop de
   44C8 C1            [10]   63     pop bc
   44C9                      64 endif_y:
                             65 
   44C9 05            [ 4]   66     dec  b
   44CA C8            [11]   67     ret  z
                             68 
   44CB 11 0A 00      [10]   69     ld  de, #entity_size
   44CE DD 19         [15]   70     add ix, de
   44D0 18 C0         [12]   71     jr _update_loop
                             72 
   44D2 C9            [10]   73     ret
