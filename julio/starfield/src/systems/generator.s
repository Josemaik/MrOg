;;;;;;;;;;;;;;;;;;;;;;;
;; Generator System
;;   Generator of new entities(stars)
;;
.module Generator_System

.include "cpctelera.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code
;;
.area _DATA
.area _CODE

generate_sys_newStar::

    ;; Comprobar si hay espacio libre (max_entities - _num_entities)

    ret