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
   4024 00                   10 _num_entities:: .db 0
   4025 27 40                11 _last_elem_ptr:: .dw _entity_array
   4027                      12 _entity_array::
   4027                      13     .ds max_entities*entity_size
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
   4059                      31 man_entity_init:
   4059 CD 5D 40      [17]   32     call man_entity_create
   405C C9            [10]   33     ret
                             34 
                             35 ;; Input
                             36 ;;   HL: pointer to entity initializer
   405D                      37 man_entity_create:
   405D ED 5B 25 40   [20]   38     ld      de, (_last_elem_ptr)
   4061 01 05 00      [10]   39     ld      bc, #entity_size
   4064 ED B0         [21]   40     ldir                        ;; Copia desde donde apunta HL hasta el registro DE, tantos bytes como ponga en el registro BC
                             41 
   4066 3A 24 40      [13]   42     ld       a, (_num_entities)
   4069 3C            [ 4]   43     inc      a
   406A 32 24 40      [13]   44     ld       (_num_entities), a  
                             45 
   406D 2A 25 40      [16]   46     ld      hl, (_last_elem_ptr)
   4070 01 05 00      [10]   47     ld      bc, #entity_size  
   4073 09            [11]   48     add     hl, bc
   4074 22 25 40      [16]   49     ld      (_last_elem_ptr), hl
                             50 
   4077 C9            [10]   51     ret
                             52 
                             53 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             54 ;; Getters
                             55 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   4078                      56 man_entity_getEntityArray_IX::
   4078 DD 21 27 40   [14]   57     ld      ix, #_entity_array
   407C C9            [10]   58     ret
                             59 
   407D                      60 man_entity_getNumEntities_A::
   407D 3A 24 40      [13]   61     ld       a, (_num_entities)
   4080 C9            [10]   62     ret
