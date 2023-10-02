.module Entity_Manager

.include "cpctelera.h.s"
.include "entity.h.s"
.area _DATA


    m_entities::
        .ds #MAX_SPACE_4_ENTITIES
    m_zero_byte_end_entities:      ;; this is for the while all entities
        .ds 1
    m_next_free_entity::
        .ds 2
    m_reserved_entites::
        .ds 1   ;;u8

.area _CODE
;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;; GENERAL INIT ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_man_entity_init::

    ;; save the first element of entities
    ;;m_next_free_entity = m_entities;
        ld      hl, #m_entities
        ld      (m_next_free_entity),  hl

    ;; fill all the entitites with 0s -> cpct_memset_asm
        ;; INPUTS ;; 
            ;; DE  -> pointer to the array to fill
            ;; A   -> the new value
            ;; BC  -> number of bytes to be filled
        ld      e, l
        ld      d, h
        ld      a, #0
        ld      bc, #MAX_SPACE_4_ENTITIES
        call    cpct_memset_asm
    
    ;; load a 0 in reserved_entities
        ld      a, #0
        ld      (m_reserved_entites), a
    
    ;; load invalid type in _m_zero_byte_end_entities
        ld      a, #E_TYPE_INVALID
        ld      (m_zero_byte_end_entities), a

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;
;; CREATES AN ENTITY ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; OUTPUTS ;;                                                   ;;
        ;; DE -> position in memory of the created entity           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_man_entity_create::  

    ;; save in DE the value of the pointer next entity
        ld      de, (m_next_free_entity)

    ;; set type on default
        ld      hl, #TYPE
        add     hl, de
        ld      (hl), #E_TYPE_DEFAULT

    ;; update the pointer to SPACE_4_ONE_ENTITY positons furthers (the next entity)
        ld      hl, #SPACE_4_ONE_ENTITY
        add     hl, de
        ld      (m_next_free_entity), hl

    ;; increase reserved entities
        ld      a, (m_reserved_entites)
        inc     a
        ld      (m_reserved_entites), a

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SET AN ENTITY FOR DESTRUCTION;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; INPUTS ;;                                        ;;
        ;; DE -> the entity to destroy                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_man_entity_set_for_destruction::

    ;; go to entity -> type
        ld      hl, #TYPE
        add     hl, de
    
    ;; save entity->type in a
        ld      a, (hl)
    
    ;; set entity for destruction
        or      #E_TYPE_DEAD
        ld      (hl), a

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SET AS INVALID AN ENTITY ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; INPUTS ;;                                        ;;
        ;; DE -> the entity to destroy                  ;;
    ;; NOTE ;;                                          ;;
        ;; next_free_entity point to end of entities    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_entity_destroy:

    ;; copy the last entity to the dead one -> cpct
        ;; INPUTS ;;
            ;; DE -> destination byte
            ;; HL -> source byte
            ;; BC -> size of data 

    ;; go to last entity -> _m_next_free_entity - SPACE_4_ONE_ENTITY
        ld      hl, (m_next_free_entity)
        ld      bc, #SPACE_4_ONE_ENTITY
        or      a
        sbc     hl, bc
    
    ;; save the last entity
        push    hl

    ;;conditional to copy
        or      a
        sbc     hl, de
        jr      z, man_if_not_copy  ;; last == de

    ;; retrieve and save last entity 
        pop     hl
        push    hl

    ;; call the function (last != de)
        call    cpct_memcpy_asm
    
    man_if_not_copy:
    ;; retrieve last entity 
        pop     hl

    ;; set last type to invalid
        ld      (hl), #E_TYPE_INVALID

    ;; set _m_next_free_entity to last
        ld      (m_next_free_entity), hl

    ;; decrease reserved entities
        ld      a, (m_reserved_entites)
        dec     a
        ld      (m_reserved_entites), a

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WHILE FOR ALL ENTITIES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; INPUTS ;;                                            ;;
        ;; BC -> the function to call                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; NOTE: inside function, DE can not change value       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_man_entity_for_all::

    ;; open stack
        ld      ix, #-2
        add     ix, sp
        ld      sp, ix

    ;; save the reference to the function to call
        ld      0(ix), c
        ld      1(ix), b

    ;; load the first position of an entity
        ld      de, #m_entities     

    ;; init of while
    man_init_for:
        ;; conditional: 
            ;; go to type of entity (_m_entities+TYPE)
                ld      hl, #TYPE
                add     hl, de             

            ;; save in a the type and compare with #E_INVALID_TYPE
                ld      a, (hl)
                cp      #E_TYPE_INVALID     ;; decrement invalid type, if it was invalid then the result is 0
                jr      z, man_end_for      ;; if 0 -> we end for

        ;; for continues:
            ;; set the returning point when coming after calling the function
                ld      hl, #_returning_code
                push    hl

            ;; call function
                ld      c, 0(ix)
                ld      b, 1(ix)
                push    bc                  ;; the function to go
                ret                         ;; call the function

            _returning_code:    ;; when the functions end it has to continue here
                ;; add SPACE_4_ONE_ENTITY to De in HL
                    ld      hl, #SPACE_4_ONE_ENTITY
                    add     hl, de

                ;; copy HL to DE
                    ld      e, l              
                    ld      d, h

                ;; redo for
                    jr      man_init_for       

    man_end_for:
        ;; reduce stack
            ld      ix, #2
            add     ix, sp
            ld      sp, ix

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;
;; MANAGER UPDATE ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_man_entity_update::
    ;; load the first position of an entity
        ld      de, #m_entities     

    ;; init of while
    man_update_init_for:
        ;; conditional: 
            ;; go to type of entity (_m_entities+TYPE)
                ld      hl, #TYPE
                add     hl, de             

            ;; save in a the type and compare with #E_INVALID_TYPE
                ld      a, (hl)
                cp      #E_TYPE_INVALID     ;; decrement invalid type, if it was invalid then the result is 0
                jr      z, man_update_end_for      ;; if 0 -> we go to the next entity

        ;; for continues:
            ;; A and deadType to know if is set for destruction
                and      #E_TYPE_DEAD
            
            ;; compare A with with deadType
                cp      #E_TYPE_DEAD
                jr      z, man_update_destroy_entity    ;; it was set for destruction (a == 0)

            ;; it was not set for destruction
                ;; add SPACE_4_ONE_ENTITY to De in HL
                    ld      hl, #SPACE_4_ONE_ENTITY
                    add     hl, de

                ;; copy HL to DE
                    ld      e, l              
                    ld      d, h

                ;; to no destroy     
                    jr      man_update_not_destroy_entity
            
            man_update_destroy_entity:      ;; destroy entity
                call    man_entity_destroy
            
            man_update_not_destroy_entity:  ;; no destroy
            ;; redo for
                jr      man_update_init_for       

    man_update_end_for:

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RETURN THE AMOUNT OF FREE ENTITIES AVAILABLE ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; OUTPUTS ;;                               ;;
        ;; L -> the number of free entities     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_man_entity_free_space::
    
    ld      a, #TOTAL_ENTITIES
    ld      bc, (m_reserved_entites)
    sub     c

    ld      l, a

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;