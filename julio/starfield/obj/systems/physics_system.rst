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
   40E8                      16 physics_sys_init::
   40E8 C9            [10]   17     ret
                             18 
                             19 ;; Input
                             20 ;;   IX: Pointer to first entity to render
                             21 ;;    A: Number of entities to render
   40E9                      22 physics_sys_update::
   40E9 47            [ 4]   23     ld  b, a
                             24 
   40EA                      25 _update_loop:
                             26     ;; Update X
   40EA 3E 51         [ 7]   27     ld    a, #screen_width + 1
   40EC DD 96 04      [19]   28     sub   e_w(ix)
   40EF 4F            [ 4]   29     ld    c, a
                             30 
   40F0 DD 7E 00      [19]   31     ld    a, e_x(ix)
   40F3 DD 86 02      [19]   32     add   e_vx(ix)
   40F6 B9            [ 4]   33     cp    c             ;; Comprueba con la primera posicion invalida
   40F7 30 05         [12]   34     jr   nc, invalid_x
   40F9                      35 valid_x:
   40F9 DD 77 00      [19]   36     ld   e_x(ix), a
   40FC 18 0A         [12]   37     jr   endif_x
   40FE                      38 invalid_x:
                             39     ;; IX
   40FE C5            [11]   40     push bc
   40FF D5            [11]   41     push de
   4100 CD BF 40      [17]   42     call entity_man_destroy  ;; Modify HL, DE, BC
   4103 D1            [10]   43     pop de
   4104 C1            [10]   44     pop bc
   4105 05            [ 4]   45     dec b
   4106 18 E2         [12]   46     jr _update_loop
   4108                      47 endif_x:
                             48 
                             49     ;; Update Y ;; todo
                             50 
   4108 05            [ 4]   51     dec  b
   4109 C8            [11]   52     ret  z
                             53 
   410A 11 09 00      [10]   54     ld  de, #entity_size
   410D DD 19         [15]   55     add ix, de
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   410F 18 D9         [12]   56     jr _update_loop
                             57 
   4111 C9            [10]   58     ret
