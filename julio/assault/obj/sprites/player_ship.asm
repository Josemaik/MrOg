;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module player_ship
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sp_player_ship
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
_sp_player_ship:
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x48	; 72	'H'
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xd0	; 208
	.db #0xc0	; 192
	.db #0x84	; 132
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x48	; 72	'H'
	.db #0xd0	; 208
	.db #0xda	; 218
	.db #0xc0	; 192
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xc0	; 192
	.db #0xe5	; 229
	.db #0xe0	; 224
	.db #0x84	; 132
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0xd0	; 208
	.db #0xcf	; 207
	.db #0xda	; 218
	.db #0xc0	; 192
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xc0	; 192
	.db #0xe5	; 229
	.db #0xcf	; 207
	.db #0xe0	; 224
	.db #0x0c	; 12
	.db #0x48	; 72	'H'
	.db #0xe5	; 229
	.db #0xe5	; 229
	.db #0xda	; 218
	.db #0x91	; 145
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x62	; 98	'b'
	.db #0xe5	; 229
	.db #0xda	; 218
	.db #0xda	; 218
	.db #0x84	; 132
	.db #0xd0	; 208
	.db #0xcf	; 207
	.db #0xe5	; 229
	.db #0xda	; 218
	.db #0x91	; 145
	.db #0xff	; 255
	.db #0x33	; 51	'3'
	.db #0x62	; 98	'b'
	.db #0xe5	; 229
	.db #0xda	; 218
	.db #0xcf	; 207
	.db #0xe0	; 224
	.db #0xc5	; 197
	.db #0xda	; 218
	.db #0xf0	; 240
	.db #0xe5	; 229
	.db #0xe0	; 224
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0xd0	; 208
	.db #0xda	; 218
	.db #0xf0	; 240
	.db #0xe5	; 229
	.db #0xca	; 202
	.db #0xc0	; 192
	.db #0xe5	; 229
	.db #0xe5	; 229
	.db #0xcf	; 207
	.db #0xda	; 218
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe5	; 229
	.db #0xcf	; 207
	.db #0xda	; 218
	.db #0xda	; 218
	.db #0xc0	; 192
	.db #0xd0	; 208
	.db #0xd0	; 208
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc5	; 197
	.db #0xe0	; 224
	.db #0xd0	; 208
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xe0	; 224
	.db #0xd0	; 208
	.db #0xca	; 202
	.db #0xd0	; 208
	.db #0xda	; 218
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xe5	; 229
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xda	; 218
	.db #0xc0	; 192
	.db #0xd0	; 208
	.db #0xe5	; 229
	.db #0xe0	; 224
	.db #0x48	; 72	'H'
	.db #0xe5	; 229
	.db #0xda	; 218
	.db #0xf0	; 240
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xe5	; 229
	.db #0xda	; 218
	.db #0x84	; 132
	.db #0x0c	; 12
	.db #0xd0	; 208
	.db #0xe5	; 229
	.db #0xcf	; 207
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xcf	; 207
	.db #0xda	; 218
	.db #0xe0	; 224
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x48	; 72	'H'
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x84	; 132
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x48	; 72	'H'
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xc0	; 192
	.db #0x84	; 132
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.area _INITIALIZER
	.area _CABS (ABS)
