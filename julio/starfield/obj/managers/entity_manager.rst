ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; Entity Manager
                              3 ;;   Definition of entity structure
                              4 ;; 
                              5 .module Entity_Manager
                              6 
                     000A     7 max_entities == 10
                     0009     8 entity_size  == 9
                              9 
   401A 00                   10 _num_entities:: .db 0
   401B 1D 40                11 _last_elem_ptr:: .dw _entity_array
   401D                      12 _entity_array::
   401D                      13     .ds max_entities*entity_size
                             14 
                             15 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             16 ;; Struct of entity
                             17 ;;
                             18 ;; x , y , vx , vy , w , h , color , ptr_l , ptr_h
                             19 
                     0000    20 e_x         == 0
                     0001    21 e_y         == 1
                     0002    22 e_vx        == 2
                     0003    23 e_vy        == 3
                     0004    24 e_w         == 4
                     0005    25 e_h         == 5
                     0006    26 e_color     == 6
                     0007    27 e_ptr_l     == 7
                     0008    28 e_ptr_h     == 8
                             29 
                             30 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             31 ;; Global Symbols
                             32 ;;
                             33 .globl entity_man_init
                             34 .globl entity_man_create
                             35 
                             36 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             37 ;; Estrellas
                             38 ;;
                             39 ;;;;;;;;;;;;; x , y  , vx , vy , w , h , color , ptr_l , ptr_h
   4077 1E 14 FF 00 01 01    40 estrella:  .db 30 , 20 , -1 , 0  , 1 , 1 , 0xCC  ,  00   , 00
        CC 00 00
   4080 2A 3C FF 00 01 01    41 estrella2: .db 42 , 60 , -1 , 0  , 1 , 1 , 0xF0  ,  00   , 00
        F0 00 00
                             42 
                             43 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             44 ;; Code
                             45 ;;
                             46 .area _CODE
                             47 
   4089                      48 entity_man_init:
                             49     ;; Reset all component vector values
   4089 AF            [ 4]   50     xor a
   408A 32 1A 40      [13]   51     ld  (_num_entities), a
                             52 
   408D 21 1D 40      [10]   53     ld  hl, #_entity_array
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   4090 22 1B 40      [16]   54     ld  (_last_elem_ptr), hl
                             55 
   4093 CD 97 40      [17]   56     call entity_man_create_stars
                             57     
   4096 C9            [10]   58     ret
                             59 
   4097                      60 entity_man_create_stars::
                             61 
   4097 21 77 40      [10]   62     ld   hl, #estrella
   409A CD A4 40      [17]   63     call entity_man_create
   409D 21 80 40      [10]   64     ld   hl, #estrella2
   40A0 CD A4 40      [17]   65     call entity_man_create
                             66 
   40A3 C9            [10]   67     ret
                             68 
                             69 ;; Input
                             70 ;;   HL: pointer to entity initializer
   40A4                      71 entity_man_create:
   40A4 ED 5B 1B 40   [20]   72     ld      de, (_last_elem_ptr)
   40A8 01 09 00      [10]   73     ld      bc, #entity_size
   40AB ED B0         [21]   74     ldir                        ;; Copia desde donde apunta HL en el registro DE, tantos bytes como ponga en el registro BC
                             75 
   40AD 3A 1A 40      [13]   76     ld       a, (_num_entities)
   40B0 3C            [ 4]   77     inc      a
   40B1 32 1A 40      [13]   78     ld       (_num_entities), a  
                             79 
   40B4 2A 1B 40      [16]   80     ld      hl, (_last_elem_ptr)
   40B7 01 09 00      [10]   81     ld      bc, #entity_size  
   40BA 09            [11]   82     add     hl, bc
   40BB 22 1B 40      [16]   83     ld      (_last_elem_ptr), hl
                             84 
   40BE C9            [10]   85     ret
                             86 
                             87 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             88 ;; Getters
                             89 ;;
   40BF                      90 entity_man_getArray::
   40BF DD 21 1D 40   [14]   91     ld      ix, #_entity_array
   40C3 3A 1A 40      [13]   92     ld       a, (_num_entities)
   40C6 C9            [10]   93     ret
