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
   41BA                      16 physics_sys_init::
   41BA C9            [10]   17     ret
                             18 
                             19 ;; Input
                             20 ;;   IX: Pointer to first entity to render
                             21 ;;    A: Number of entities to render
   41BB                      22 physics_sys_update::
   41BB 47            [ 4]   23     ld  b, a
                             24 
   41BC                      25 _update_loop:
                             26     ;; Update X
   41BC 3E 51         [ 7]   27     ld    a, #screen_width + 1
   41BE DD 96 04      [19]   28     sub   e_w(ix)
   41C1 4F            [ 4]   29     ld    c, a
                             30 
   41C2 DD 7E 00      [19]   31     ld    a, e_x(ix)
   41C5 DD 86 02      [19]   32     add   e_vx(ix)
   41C8 B9            [ 4]   33     cp    c             ;; Comprueba con la primera posicion invalida
   41C9 30 05         [12]   34     jr   nc, invalid_x
   41CB                      35 valid_x:
   41CB DD 77 00      [19]   36     ld   e_x(ix), a
   41CE 18 0A         [12]   37     jr   endif_x
   41D0                      38 invalid_x:
                             39     ;; IX
   41D0 C5            [11]   40     push bc
   41D1 D5            [11]   41     push de
   41D2 CD 6D 41      [17]   42     call entity_man_destroy  ;; Modify HL, DE, BC
   41D5 D1            [10]   43     pop de
   41D6 C1            [10]   44     pop bc
   41D7 05            [ 4]   45     dec b
   41D8 18 E2         [12]   46     jr _update_loop
   41DA                      47 endif_x:
                             48 
                             49     ;; Update Y ;; todo
                             50 
   41DA 05            [ 4]   51     dec  b
   41DB C8            [11]   52     ret  z
                             53 
   41DC 11 09 00      [10]   54     ld  de, #entity_size
   41DF DD 19         [15]   55     add ix, de
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   41E1 18 D9         [12]   56     jr _update_loop
                             57 
   41E3 C9            [10]   58     ret
