;;;;;;;;;;;;;;;;;;;;;;;
;; Input System
;;   Control input keyboard
;;
.module Input_System

.include "cpctelera.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code
;;
.area _DATA
.area _CODE

input_sys_init::
    ret

;; Input
;;   IX: Pointer to entity[0] - player
input_sys_update::
    ;; Reset velocities
    ld    e_vx(ix), #0
    ld    e_vy(ix), #0

    ;; Scan the keyboard
    call cpct_scanKeyboard_f_asm

    ;; Check for movement keys
    ld    hl, #Key_O
    call  cpct_isKeyPressed_asm
    jr    z, O_NotPressed
O_Pressed:
    ld    e_vx(ix), #-1
O_NotPressed:

    ld    hl, #Key_P
    call  cpct_isKeyPressed_asm
    jr    z, P_NotPressed
P_Pressed:
    ld    e_vx(ix), #1
P_NotPressed:


    ret