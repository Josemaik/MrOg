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
   40E7                      15 physics_sys_init::
   40E7 C9            [10]   16     ret
                             17 
                             18 ;; Input
                             19 ;;   IX: Pointer to first entity to render
                             20 ;;    A: Number of entities to render
   40E8                      21 physics_sys_update::
   40E8 47            [ 4]   22     ld  b, a
                             23 
   40E9                      24 _update_loop:
                             25     ;; Update X
   40E9 3E 51         [ 7]   26     ld    a, #screen_width + 1
   40EB DD 96 04      [19]   27     sub   e_w(ix)
   40EE 4F            [ 4]   28     ld    c, a
                             29 
   40EF DD 7E 00      [19]   30     ld    a, e_x(ix)
   40F2 DD 86 02      [19]   31     add   e_vx(ix)
   40F5 B9            [ 4]   32     cp    c             ;; Comprueba con la primera posicion invalida
   40F6 30 05         [12]   33     jr   nc, invalid_x
   40F8                      34 valid_x:
   40F8 DD 77 00      [19]   35     ld   e_x(ix), a
   40FB 18 0A         [12]   36     jr   endif_x
   40FD                      37 invalid_x:
                             38     ;; IX
   40FD C5            [11]   39     push bc
   40FE D5            [11]   40     push de
   40FF CD BF 40      [17]   41     call entity_man_destroy  ;; Modify HL, DE, BC
   4102 D1            [10]   42     pop de
   4103 C1            [10]   43     pop bc
   4104 05            [ 4]   44     dec b
   4105 18 E2         [12]   45     jr _update_loop
   4107                      46 endif_x:
                             47 
                             48     ;; Update Y ;; todo
                             49 
   4107 05            [ 4]   50     dec  b
   4108 C8            [11]   51     ret  z
                             52 
   4109 11 09 00      [10]   53     ld  de, #entity_size
   410C DD 19         [15]   54     add ix, de
   410E 18 D9         [12]   55     jr _update_loop
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 
   4110 C9            [10]   57     ret
