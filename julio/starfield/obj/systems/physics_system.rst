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
   40E4                      15 physics_sys_init::
   40E4 C9            [10]   16     ret
                             17 
                             18 ;; Input
                             19 ;;   IX: Pointer to first entity to render
                             20 ;;    A: Number of entities to render
   40E5                      21 physics_sys_update::
   40E5 47            [ 4]   22     ld  b, a
                             23 
   40E6                      24 _update_loop:
                             25     ;; Update X
   40E6 3E 51         [ 7]   26     ld    a, #screen_width + 1
   40E8 DD 96 04      [19]   27     sub   e_w(ix)
   40EB 4F            [ 4]   28     ld    c, a
                             29 
   40EC DD 7E 00      [19]   30     ld    a, e_x(ix)
   40EF DD 86 02      [19]   31     add   e_vx(ix)
   40F2 B9            [ 4]   32     cp    c             ;; Comprueba con la primera posicion invalida
   40F3 30 05         [12]   33     jr   nc, invalid_x
   40F5                      34 valid_x:
   40F5 DD 77 00      [19]   35     ld   e_x(ix), a
   40F8 18 0A         [12]   36     jr   endif_x
   40FA                      37 invalid_x:
                             38     ;; ld   a, e_vx(ix)
                             39     ;; neg
                             40     ;; ld   e_vx(ix), a
                             41     ;; IX
   40FA C5            [11]   42     push bc
   40FB D5            [11]   43     push de
   40FC CD BF 40      [17]   44     call entity_man_destroy  ;; Modify HL, DE, BC
   40FF D1            [10]   45     pop de
   4100 C1            [10]   46     pop bc
   4101 05            [ 4]   47     dec b
   4102 18 E2         [12]   48     jr _update_loop
   4104                      49 endif_x:
                             50 
                             51     ;; Update Y ;; todo
                             52 
   4104 05            [ 4]   53     dec  b
   4105 C8            [11]   54     ret  z
                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   4106 11 09 00      [10]   56     ld  de, #entity_size
   4109 DD 19         [15]   57     add ix, de
   410B 18 D9         [12]   58     jr _update_loop
                             59 
   410D C9            [10]   60     ret
