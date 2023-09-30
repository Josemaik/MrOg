ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; Entity Manager
                              3 ;;   Definition of entity structure
                              4 ;; 
                              5 .module Entity_Manager
                              6 
                     000A     7 max_entities == 10
                     0008     8 entity_size  == 8
                              9 
   4033 00                   10 _num_entities:: .db 0
   4034 36 40                11 _last_elem_ptr:: .dw _entity_array
   4036                      12 _entity_array::
   4036                      13     .ds max_entities*entity_size
                             14 
                             15 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             16 ;; Struct of entity
                             17 ;;
                             18 ;; tipo , x , y , vx , vy , w , h , color , (posible memory pointer value)
                             19 
                     0000    20 e_tipo      == 0
                     0001    21 e_x         == 1
                     0002    22 e_y         == 2
                     0003    23 e_vx        == 3
                     0004    24 e_vy        == 4
                     0005    25 e_w         == 5
                     0006    26 e_h         == 6
                     0007    27 e_color     == 7
                             28 
                             29 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             30 ;; Global Symbols
                             31 ;;
                             32 .globl entity_man_init
                             33 .globl entity_man_create
                             34 
                             35 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             36 ;; Code
                             37 ;;
                             38 .area _CODE
                             39 
   4086                      40 entity_man_init:
                             41     ;; Reset all component vector values
   4086 AF            [ 4]   42     xor a
   4087 32 33 40      [13]   43     ld  (_num_entities), a
                             44 
   408A 21 36 40      [10]   45     ld  hl, #_entity_array
   408D 22 34 40      [16]   46     ld  (_last_elem_ptr), hl
                             47     
   4090 C9            [10]   48     ret
                             49 
                             50 ;; Input
                             51 ;;   HL: pointer to entity initializer
   4091                      52 entity_man_create:
   4091 ED 5B 34 40   [20]   53     ld      de, (_last_elem_ptr)
   4095 01 08 00      [10]   54     ld      bc, #entity_size
   4098 ED B0         [21]   55     ldir                        ;; Copia desde donde apunta HL hasta el registro DE, tantos bytes como ponga en el registro BC
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 
   409A 3A 33 40      [13]   57     ld       a, (_num_entities)
   409D 3C            [ 4]   58     inc      a
   409E 32 33 40      [13]   59     ld       (_num_entities), a  
                             60 
   40A1 2A 34 40      [16]   61     ld      hl, (_last_elem_ptr)
   40A4 01 08 00      [10]   62     ld      bc, #entity_size  
   40A7 09            [11]   63     add     hl, bc
   40A8 22 34 40      [16]   64     ld      (_last_elem_ptr), hl
                             65 
   40AB C9            [10]   66     ret
                             67 
                             68 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             69 ;; Getters
                             70 ;;
   40AC                      71 entity_man_getArray::
   40AC DD 21 36 40   [14]   72     ld      ix, #_entity_array
   40B0 3A 33 40      [13]   73     ld       a, (_num_entities)
   40B3 C9            [10]   74     ret
