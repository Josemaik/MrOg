
.module Main
.include "cpctelera.h.s"

.area _DATA

.area _CODE

;;;;;;;;;;;;;;;;;;;;
;; GLOBAL SYMBOLS ;;
;;;;;;;;;;;;;;;;;;;;
   ;; cpct                                
      .globl cpct_disableFirmware_asm
   ;;manager
      .globl man_game_init    
      .globl man_game_play 
      .globl man_menu_init
      .globl man_menu_update



;;;;;;;;;;;;;;;;;;
;; MAIN FUNCTION;;
;;;;;;;;;;;;;;;;;;
_main::

   ;; disable firmware
      call     cpct_disableFirmware_asm

   ;; Game Menu
      call man_menu_init
   menu_loop:
      call man_menu_update
      jr    z, menu_loop

   ;; call game init
      call man_game_init
   ;; call game manager
      call man_game_play
