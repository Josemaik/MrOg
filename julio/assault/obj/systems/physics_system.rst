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
   42DD                      16 physics_sys_init::
   42DD C9            [10]   17     ret
                             18 
                             19 ;; Input
                             20 ;;   IX: Pointer to first entity to render
                             21 ;;    A: Number of entities to render
   42DE                      22 physics_sys_update::
   42DE 47            [ 4]   23     ld  b, a
                             24 
   42DF                      25 _update_loop:
                             26     ;; Update X
   42DF 3E 51         [ 7]   27     ld    a, #screen_width + 1
   42E1 DD 96 04      [19]   28     sub   e_w(ix)
   42E4 4F            [ 4]   29     ld    c, a
                             30 
   42E5 DD 7E 00      [19]   31     ld    a, e_x(ix)
   42E8 DD 86 02      [19]   32     add   e_vx(ix)
   42EB B9            [ 4]   33     cp    c             ;; Comprueba con la primera posicion invalida
   42EC 30 05         [12]   34     jr   nc, invalid_x
   42EE                      35 valid_x:
   42EE DD 77 00      [19]   36     ld   e_x(ix), a
   42F1 18 00         [12]   37     jr   endif_x
   42F3                      38 invalid_x:
                             39     
   42F3                      40 endif_x:
                             41 
                             42     ;; Update Y
   42F3 3E C9         [ 7]   43     ld    a, #screen_height + 1
   42F5 DD 96 05      [19]   44     sub   e_h(ix)
   42F8 4F            [ 4]   45     ld    c, a
                             46 
   42F9 DD 7E 01      [19]   47     ld    a, e_y(ix)
   42FC DD 86 03      [19]   48     add   e_vy(ix)
   42FF B9            [ 4]   49     cp    c             ;; Comprueba con la primera posicion invalida
   4300 30 05         [12]   50     jr   nc, invalid_y
   4302                      51 valid_y:
   4302 DD 77 01      [19]   52     ld   e_y(ix), a
   4305 18 07         [12]   53     jr   endif_y
   4307                      54 invalid_y:
                             55     ;; IX
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   4307 C5            [11]   56     push bc
   4308 D5            [11]   57     push de
   4309 CD 85 42      [17]   58     call entity_man_destroy  ;; Modify HL, DE, BC
   430C D1            [10]   59     pop de
   430D C1            [10]   60     pop bc
   430E                      61 endif_y:
                             62 
   430E 05            [ 4]   63     dec  b
   430F C8            [11]   64     ret  z
                             65 
   4310 11 0A 00      [10]   66     ld  de, #entity_size
   4313 DD 19         [15]   67     add ix, de
   4315 18 C8         [12]   68     jr _update_loop
                             69 
   4317 C9            [10]   70     ret
