.module Entity_Manager

    .area _CODE

    .include "entities.inc"
    .include "cpctelera.h.s"

man_entity_init:
    reserved_entities = 0
    ret

man_entity_create:
    ret