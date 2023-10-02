
.module Main
.include "cpctelera.h.s"

.area _DATA

.area _CODE

;;;;;;;;;;;;;;;;;;;;
;; GLOBAL SYMBOLS ;;
;;;;;;;;;;;;;;;;;;;;
   ;; cpct                                
      .globl cpct_disableFirmware_asm    
      .globl man_game_init
      .globl man_game_play       



;;;;;;;;;;;;;;;;;;
;; MAIN FUNCTION;;
;;;;;;;;;;;;;;;;;;
_main::
   ;; deshabilitamos el firmware
      call     cpct_disableFirmware_asm
   ;; llamamos al game init
      call man_game_init
   ;; llamamos al bucle del juego
      call man_game_play
   
