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
   41B0                      16 physics_sys_init::
   41B0 C9            [10]   17     ret
                             18 
                             19 ;; Input
                             20 ;;   IX: Pointer to first entity to render
                             21 ;;    A: Number of entities to render
   41B1                      22 physics_sys_update::
   41B1 47            [ 4]   23     ld  b, a
                             24 
   41B2                      25 _update_loop:
                             26     ;; Update X
   41B2 3E 51         [ 7]   27     ld    a, #screen_width + 1
   41B4 DD 96 03      [19]   28     sub   e_w(ix)
   41B7 4F            [ 4]   29     ld    c, a
                             30 
   41B8 DD 7E 00      [19]   31     ld    a, e_x(ix)
   41BB DD 86 02      [19]   32     add   e_vx(ix)
   41BE B9            [ 4]   33     cp    c             ;; Comprueba con la primera posicion invalida
   41BF 30 05         [12]   34     jr   nc, invalid_x
   41C1                      35 valid_x:
   41C1 DD 77 00      [19]   36     ld   e_x(ix), a
   41C4 18 0A         [12]   37     jr   endif_x
   41C6                      38 invalid_x:
                             39     ;; IX
   41C6 C5            [11]   40     push bc
   41C7 D5            [11]   41     push de
   41C8 CD 48 41      [17]   42     call entity_man_destroy  ;; Modify HL, DE, BC
   41CB D1            [10]   43     pop de
   41CC C1            [10]   44     pop bc
   41CD 05            [ 4]   45     dec b
   41CE 18 E2         [12]   46     jr _update_loop
   41D0                      47 endif_x:
                             48 
                             49     ;; Update Y ;; todo
                             50 
   41D0 05            [ 4]   51     dec  b
   41D1 C8            [11]   52     ret  z
                             53 
   41D2 11 08 00      [10]   54     ld  de, #entity_size
   41D5 DD 19         [15]   55     add ix, de
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   41D7 18 D9         [12]   56     jr _update_loop
                             57 
   41D9 C9            [10]   58     ret
