
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



;;;;;;;;;;;;;;;;;;
;; MAIN FUNCTION;;
;;;;;;;;;;;;;;;;;;
_main::

   ;; disable firmware
      call     cpct_disableFirmware_asm
   ;; call game init
      call man_game_init
   ;; call game manager
      call man_game_play
