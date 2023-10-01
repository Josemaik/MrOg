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
   4035 00                   10 _num_entities:: .db 0
   4036 38 40                11 _last_elem_ptr:: .dw _entity_array
   4038                      12 _entity_array::
   4038                      13     .ds max_entities*entity_size
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
                             37 ;; Code
                             38 ;;
                             39 .area _CODE
                             40 
   4092                      41 entity_man_init:
                             42     ;; Reset all component vector values
   4092 AF            [ 4]   43     xor a
   4093 32 35 40      [13]   44     ld  (_num_entities), a
                             45 
   4096 21 38 40      [10]   46     ld  hl, #_entity_array
   4099 22 36 40      [16]   47     ld  (_last_elem_ptr), hl
                             48     
   409C C9            [10]   49     ret
                             50 
                             51 ;; Input
                             52 ;;   HL: pointer to entity initializer
   409D                      53 entity_man_create:
   409D ED 5B 36 40   [20]   54     ld      de, (_last_elem_ptr)
   40A1 01 09 00      [10]   55     ld      bc, #entity_size
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   40A4 ED B0         [21]   56     ldir                        ;; Copia desde donde apunta HL hasta el registro DE, tantos bytes como ponga en el registro BC
                             57 
   40A6 3A 35 40      [13]   58     ld       a, (_num_entities)
   40A9 3C            [ 4]   59     inc      a
   40AA 32 35 40      [13]   60     ld       (_num_entities), a  
                             61 
   40AD 2A 36 40      [16]   62     ld      hl, (_last_elem_ptr)
   40B0 01 09 00      [10]   63     ld      bc, #entity_size  
   40B3 09            [11]   64     add     hl, bc
   40B4 22 36 40      [16]   65     ld      (_last_elem_ptr), hl
                             66 
   40B7 C9            [10]   67     ret
                             68 
                             69 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             70 ;; Getters
                             71 ;;
   40B8                      72 entity_man_getArray::
   40B8 DD 21 38 40   [14]   73     ld      ix, #_entity_array
   40BC 3A 35 40      [13]   74     ld       a, (_num_entities)
   40BF C9            [10]   75     ret
