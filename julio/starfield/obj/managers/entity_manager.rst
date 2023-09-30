ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; Entity Manager
                              3 ;;   Definition of entity structure
                              4 ;; 
                              5 .module Entity_Manager
                              6 
                     000A     7 max_entities == 10
                     0005     8 entity_size  == 5
                              9 
   402A 00                   10 _num_entities:: .db 0
   402B 2D 40                11 _last_elem_ptr:: .dw _entity_array
   402D                      12 _entity_array::
   402D                      13     .ds max_entities*entity_size
                             14 
                             15 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             16 ;; Struct of entity
                             17 ;;
                             18 ;; tipo , x , y , vx , color
                             19 
                             20 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             21 ;; Global Symbols
                             22 ;;
                             23 .globl man_entity_init
                             24 .globl man_entity_create
                             25 
                             26 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             27 ;; Code
                             28 ;;
                             29 .area _CODE
                             30 
   405F                      31 man_entity_init:
   405F CD 63 40      [17]   32     call man_entity_create
   4062 C9            [10]   33     ret
                             34 
                             35 ;; Input
                             36 ;;   HL: pointer to entity initializer
   4063                      37 man_entity_create:
   4063 ED 5B 2B 40   [20]   38     ld      de, (_last_elem_ptr)
   4067 01 05 00      [10]   39     ld      bc, #entity_size
   406A ED B0         [21]   40     ldir                        ;; Copia desde donde apunta HL hasta el registro DE, tantos bytes como ponga en el registro BC
                             41 
   406C 3A 2A 40      [13]   42     ld       a, (_num_entities)
   406F 3C            [ 4]   43     inc      a
   4070 32 2A 40      [13]   44     ld       (_num_entities), a  
                             45 
   4073 2A 2B 40      [16]   46     ld      hl, (_last_elem_ptr)
   4076 01 05 00      [10]   47     ld      bc, #entity_size  
   4079 09            [11]   48     add     hl, bc
   407A 22 2B 40      [16]   49     ld      (_last_elem_ptr), hl
                             50 
   407D C9            [10]   51     ret
                             52 
                             53 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             54 ;; Getters
                             55 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   407E                      56 man_entity_getArray::
   407E DD 21 2D 40   [14]   57     ld      ix, #_entity_array
   4082 3A 2A 40      [13]   58     ld       a, (_num_entities)
   4085 C9            [10]   59     ret
