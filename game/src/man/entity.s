.module Entity_Manager

.include "cpctelera.h.s"
.include "entity.h.s"
.area _DATA


    m_entities::    ;;entities
        .ds #TOTAL_SPACE_4_ENTITIES
    m_zero_byte_end_entities:      ;;zero-byte to signal invalid entities
        .ds 1
    m_next_free_entity::    ;; pointer to next free entity
        .ds 2
    m_reserved_entites:: ;;number of reserved entities
        .ds 1   ;;u8

.area _CODE
;;;;;;;;;;;;;;;;;;;;;;
;; PUBLIC FUNCTIONS ;;
;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;; GENERAL INIT ;;
;;;;;;;;;;;;;;;;;;
_man_entity_init::

    ;; save the first element of entities
    ;;m_next_free_entity = m_entities;
        ld      hl, #m_entities
        ld      (m_next_free_entity),  hl

    ;; fill all the entitites with 0s -> cpct_memset_asm
    ;; IN =>         DE  -> pointer to the array to fill
    ;;               A   -> the new value
    ;;               BC  -> number of bytes to be filled
        ld      e, l
        ld      d, h
        ld      a, #0
        ld      bc, #TOTAL_SPACE_4_ENTITIES
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
;; CREATES AN ENTITY
;;;;;;;;;;;;;;;;;;;;;;;
;; OUT =>         DE  -> position in memory of the created entity            
_man_entity_create::  

    ;; save in DE the value of the pointer next entity
        ld      de, (m_next_free_entity)

    ;; set type on default
        ld      hl, #TYPE
        add     hl, de
        ld      (hl), #E_TYPE_DEFAULT
    ;; Set cmp to default
        ld hl, #CMPs
        add hl,de
        ld (hl), #E_CMP_DEFAULT

    ;; update the pointer to SPACE_4_ONE_ENTITY positons furthers (the next entity)
        ld      hl, #SPACE_4_ONE_ENTITY
        add     hl, de
        ld      (m_next_free_entity), hl

    ;; increase reserved entities
        ld      a, (m_reserved_entites)
        inc     a
        ld      (m_reserved_entites), a

    ret

;;;;;;;;;;;;;;;;;;;;;;;
;; CLONE AN ENTITY
;;;;;;;;;;;;;;;;;;;;;;;
;; IN =>         DE  -> position in memory of the entity to clone
;; OUT => DE -> position in memory of the cloned entity
;; Preconditions -> there must be free space for at least one more entity            
_man_entity_clone:: 
    ;; create entity
    ;; (2B DE) to	Pointer to the destination (first byte where bytes will be written)
    ;; (2B HL) from	Pointer to the source (first byte from which bytes will be read)
    ;;(2B BC) size	Number of bytes to be set (>= 1)
    ;; save entity to clone
    push de
    ;; create entity
    call _man_entity_create
    ;; retrieve de entity to clone in hl
    pop hl
    ;; size in bc
    ld      bc, #SPACE_4_ONE_ENTITY
    ;; save pinter to new entity
    push de
    ;; copy entity to clone in new entity
    call cpct_memcpy_asm
    ;; retrieve pointer to new entity
    pop de
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SET ENTITY FOR DESTRUCTION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IN =>   DE -> the entity to destroy               
;;
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SET AS INVALID AN ENTITY 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IN =>   DE -> the entity to destroy               
;;

man_entity_destroy::

        ;; copy the last entity to the dead one
        ;; IN =>    DE -> destination byte
        ;;          HL -> source byte
        ;;          BC -> size of data 

        ;; go to last entity -> _m_next_free_entity - SPACE_4_ONE_ENTITY
        ld      hl, (m_next_free_entity)
        ld      bc, #SPACE_4_ONE_ENTITY
        or      a
        sbc     hl, bc
    
    ;; save the last entity
        push    hl

    ;; last == de
    ;;conditional to copy
        or      a
        sbc     hl, de
        jr      z, man_if_not_copy  

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

;;;;;;;;;;;;;;;;;;;;;;
;; FOR ALL ENTITIES ;;
;;;;;;;;;;;;;;;;;;;;;;
;; IN =>   BC -> the function to call                       
;;
_man_entity_for_all::

    ;; stack opened
        ld      ix, #-2
        add     ix, sp
        ld      sp, ix

    ;; save the function to call
        ld      0(ix), c
        ld      1(ix), b

    ;; load first position of an entity
        ld      de, #m_entities     
        push de
    ;; while
    man_init_for:
        ;; if
            ;; go to type of entity
                ld      hl, #TYPE
                add     hl, de             

            ;; save in a the type and compare with #E_TYPE_INVALID
                ld      a, (hl)
                cp      #E_TYPE_INVALID    
                jr      z, man_end_for     

                ; push de
            ;; save returning point
                ld      hl, #_return_hear
                push    hl

            ;; call function
                ld      c, 0(ix)
                ld      b, 1(ix)
                push    bc                  
                ret                         

            _return_hear:
                    pop de
                    ld      hl, #SPACE_4_ONE_ENTITY
                    add     hl, de

                ;; HL<=>DE
                    ld      e, l              
                    ld      d, h

                    push de

                    jr      man_init_for       

    man_end_for:
        ;; close stack
            ld      ix, #2
            add     ix, sp
            ld      sp, ix
    
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FOR ALL MATCHING ENTITIES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IN =>   BC -> the function to call   
;;         HL -> the condition to call function                    
;;
_man_entity_for_all_matching::

    ;; stack opened
        ld      ix, #-6
        add     ix, sp
        ld      sp, ix

    ;; save the function to call
        ld      0(ix), c
        ld      1(ix), b
    ;; save the condition to call function
        ld      2(ix), l
        ld      3(ix), h

    ;; load first position of an entity
        ld      de, #m_entities     
        push de
    ;; while
    man_init_for_match:
    pop de
        ;; if
            ;; go to type of entity
                ld      hl, #TYPE
                add     hl, de             

            ;; save in a the type and compare with #E_TYPE_INVALID
                ld      a, (hl)
                cp      #E_TYPE_INVALID    
                jr      z, man_end_for_match     

                push de
                ld hl, #CMPs
                add hl,de
                ld a, (hl)
                ld l, 2(ix)
                ld h, 3(ix)
                and l
                cp  l
                jr nz, _return_hear_match

            ;; save returning point
                ld      hl, #_return_hear_match
                push    hl

            ;; call function
                ld      c, 0(ix)
                ld      b, 1(ix)
                push    bc                  
                ret                         
            ;; if entity is not movable continue here
            _return_hear_match:
                    pop de
                    ld      hl, #SPACE_4_ONE_ENTITY
                    add     hl, de

                ;; HL<=>DE
                    ld      e, l              
                    ld      d, h

                    push de

                    jr      man_init_for_match       

    man_end_for_match:
        ;; close stack
            ld      ix, #6
            add     ix, sp
            ld      sp, ix
    
    ret
borrar_entidades::
    ld c, #TOTAL_SPACE_4_ENTITIES ;; espacio total
    ld de, #m_entities + #SPACE_4_ONE_ENTITY
    bucle_borrar:
        ld a , c
        cp #0
        jr z, bucle_borrar_end
        ld a, #0x00
        ld (de) , a
        ;; incrementamos de
        inc de
        ;; decrementamos el total en 1
        ld a , c
        dec a
        ld c , a
        jr bucle_borrar
bucle_borrar_end:

ret
;; Intento de optimizacion
;
;_man_entity_for_all_matching::
;
;    ;; load first position of an entity
;    ld   ix, #m_entities
;
;    ;; while
;    man_init_for_match:
;        ;; if
;            ;; save in a the type and compare with #E_TYPE_INVALID
;            ld      a, TYPE(ix)
;            cp      #E_TYPE_INVALID    
;            jr      z, man_end_for_match     
;
;            ;; compare the condition
;            ld  a, CMPs(ix)
;            and l
;            cp  l
;            jr nz, _return_hear_match       
;
;            ;; save returning point
;            ld      hl, #_return_hear_match
;            push    hl
;
;            ;; call the function
;            push    bc                  
;            ret  
;
;            ;; if entity is not movable continue here
;            _return_hear_match:
;
;                ld    de, #SPACE_4_ONE_ENTITY
;                add   ix, de
;
;                jr      man_init_for_match       
;
;    man_end_for_match:
;    
;    ret

;;;;;;;;;;;;;;;;;;;;
;; MANAGER UPDATE ;;
;;;;;;;;;;;;;;;;;;;;
_man_entity_update::
    ;; load first position
        ld      de, #m_entities     

    ;; while
    man_update_init_for:
            ;; go to type of entity
                ld      hl, #TYPE
                add     hl, de             

            ;; save in a the type and compare with #E_TYPE_INVALID
                ld      a, (hl)
                cp      #E_TYPE_INVALID     
                jr      z, man_update_end_for   
                   
            ;;if is set for destruction
                and      #E_TYPE_DEAD
            
            ;; compare A with E_TYPE_DEAD
                cp      #E_TYPE_DEAD
                jr      z, man_update_destroy_entity 

                ld      a, (hl)
                cp #E_TYPE_PLAYER
                jr nz, continuar
                ;; compruebo si esta muerto
                ld a, (player_state)
                cp #1
                jr nz, continuar ;; si esta vivo sigo
                ;; jugador esta muerto
                ;;iniciar contador
                ld a, (time_anim_died)
                cp #0
                jr z, died_anim_end ;; animacion termina
                ;; decremento tiempo
                ld a, (time_anim_died)
                dec a
                ld (time_anim_died) , a
                jr continuar
                died_anim_end:
                    ld a, #0
                    ld (player_state) , a
                    call player_reaparition
                continuar:

                ld      hl, #TYPE
                add     hl, de   
                ld a, (hl)
                cp #E_TYPE_FOOD
                jr nz , continuar2
                ld hl, #CMPs
                add hl, de
                ld a, (hl)
                cp #E_CMP_RENDER | E_CMP_ANIMATED
                jr nz, continuar2
                ld a, (food_state)
                cp #1
                jr nz, continuar2
                ld a, (time_anim_eat)
                cp #0
                jr z, eat_anim_end
                ;; decremento tiempo
                ld a, (time_anim_eat)
                dec a
                ld (time_anim_eat) , a
                jr continuar2
                eat_anim_end:
                    ld a, #0
                    ld (food_state) , a
                    ld hl,#TYPE
                    add hl, de
                    ld (hl), #E_TYPE_DEAD
                    ; ld hl, #CMPs
                    ; add hl, de
                    ; ld (hl), #0x00
                    ld a, #0x1e
                    ld (time_anim_eat), a
                    ;; si consumibles es 0
                    ;; cambio de mapa
                    ld a, (consumibles_actuales)
                    cp #0
                    jr z, cambio_mapa
                continuar2:

                ;; add SPACE_4_ONE_ENTITY De <==> HL
                    ld      hl, #SPACE_4_ONE_ENTITY
                    add     hl, de

                ;;  HL<==>DE
                    ld      e, l              
                    ld      d, h

                ;; no destroy  
                    jr      man_update_not_destroy_entity
            
            man_update_destroy_entity:      
                call    man_entity_destroy        
            man_update_not_destroy_entity:  
                jr      man_update_init_for
            
            cambio_mapa:
                    call cambio_de_mapa

    man_update_end_for:
    ;; comprobar si no tengo vidas y volver a menu
    ld a, (lifes_available)
    cp #0
    jr z, goto_menu
    ret
    goto_menu:
        Ld a, #3
        ld (lifes_available), a
        call reset_hud
        ld bc, #_main
        push bc 
        ret
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RETURN THE AMOUNT OF FREE ENTITIES AVAILABLE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OUT => L -> the number of free entities     
;;
_man_entity_free_space::
    
    ld      a, #TOTAL_ENTITIES
    ld      bc, (m_reserved_entites)
    sub     c

    ld      l, a

    ret
