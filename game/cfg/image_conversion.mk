## 16 colours palette
PALETTE=0 1 2 3 6 9 11 12 13 15 16 18 20 24 25 26

## Default values
#$(eval $(call IMG2SP, SET_MODE        , 0                  ))  { 0, 1, 2 }
#$(eval $(call IMG2SP, SET_MASK        , none               ))  { interlaced, none }
#$(eval $(call IMG2SP, SET_FOLDER      , src/               ))
#$(eval $(call IMG2SP, SET_EXTRAPAR    ,                    ))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))	{ sprites, zgtiles, screen }
#$(eval $(call IMG2SP, SET_OUTPUT      , c                  ))  { bin, c }
#$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)         ))
#$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette ))
#$(eval $(call IMG2SP, CONVERT         , img.png , w, h, array, palette, tileset))
$(eval $(call IMG2SP, SET_MODE, 0))
$(eval $(call IMG2SP, SET_FOLDER, src/sprites/))  
$(eval $(call IMG2SP, SET_OUTPUT, c))
$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)))
$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), main_palette ))
$(eval $(call IMG2SP, CONVERT, assets/sprite1_S.png , 16, 16, spr_sprite1_S))
$(eval $(call IMG2SP, CONVERT, assets/sprite2_S.png , 16, 16, spr_sprite2_S))
$(eval $(call IMG2SP, CONVERT, assets/sprite3_S.png , 16, 16, spr_sprite3_S))
$(eval $(call IMG2SP, CONVERT, assets/sprite4_S.png , 16, 16, spr_sprite4_S))
$(eval $(call IMG2SP, CONVERT, assets/sprite1_W.png , 16, 16, spr_sprite1_W))
$(eval $(call IMG2SP, CONVERT, assets/sprite2_W.png , 16, 16, spr_sprite2_W))
$(eval $(call IMG2SP, CONVERT, assets/sprite3_W.png , 16, 16, spr_sprite3_W))
$(eval $(call IMG2SP, CONVERT, assets/sprite4_W.png , 16, 16, spr_sprite4_W))
$(eval $(call IMG2SP, CONVERT, assets/sprite1_A.png , 16, 16, spr_sprite1_A))
$(eval $(call IMG2SP, CONVERT, assets/sprite2_A.png , 16, 16, spr_sprite2_A))
$(eval $(call IMG2SP, CONVERT, assets/sprite3_A.png , 16, 16, spr_sprite3_A))
$(eval $(call IMG2SP, CONVERT, assets/sprite4_A.png , 16, 16, spr_sprite4_A))

$(eval $(call IMG2SP, SET_IMG_FORMAT  , zgtiles            ))
$(eval $(call IMG2SP, CONVERT         , img/tiles.png , 8, 8, tiles))

##
## OLD MACROS (For compatibility)
##

## Example firmware palette definition as variable in cpct_img2tileset format

# PALETTE={0 1 3 4 7 9 10 12 13 16 19 20 21 24 25 26}

## AUTOMATED IMAGE CONVERSION EXAMPLE (Uncomment EVAL line to use)
##
##    This example would convert img/example.png into src/example.{c|h} files.
##    A C-array called pre_example[24*12*2] would be generated with the definition
##    of the image example.png in mode 0 screen pixel format, with interlaced mask.
##    The palette used for conversion is given through the PALETTE variable and
##    a pre_palette[16] array will be generated with the 16 palette colours as 
##	  hardware colour values.

#$(eval $(call IMG2SPRITES,img/example.png,0,pre,24,12,$(PALETTE),mask,src/,hwpalette))



############################################################################
##              DETAILED INSTRUCTIONS AND PARAMETERS                      ##
##------------------------------------------------------------------------##
##                                                                        ##
## Macro used for conversion is IMG2SPRITES, which has up to 9 parameters:##
##  (1): Image file to be converted into C sprite (PNG, JPG, GIF, etc)    ##
##  (2): Graphics mode (0,1,2) for the generated C sprite                 ##
##  (3): Prefix to add to all C-identifiers generated                     ##
##  (4): Width in pixels of each sprite/tile/etc that will be generated   ##
##  (5): Height in pixels of each sprite/tile/etc that will be generated  ##
##  (6): Firmware palette used to convert the image file into C values    ##
##  (7): (mask / tileset / zgtiles)                                       ##
##     - "mask":    generate interlaced mask for all sprites converted    ##
##     - "tileset": generate a tileset array with pointers to all sprites ##
##     - "zgtiles": generate tiles/sprites in Zig-Zag pixel order and     ##
##                  Gray Code row order                                   ##
##  (8): Output subfolder for generated .C/.H files (in project folder)   ##
##  (9): (hwpalette)                                                      ##
##     - "hwpalette": output palette array with hardware colour values    ##
## (10): Aditional options (you can use this to pass aditional modifiers  ##
##       to cpct_img2tileset)                                             ##
##                                                                        ##
## Macro is used in this way (one line for each image to be converted):   ##
##  $(eval $(call IMG2SPRITES,(1),(2),(3),(4),(5),(6),(7),(8),(9), (10))) ##
##                                                                        ##
## Important:                                                             ##
##  * Do NOT separate macro parameters with spaces, blanks or other chars.##
##    ANY character you put into a macro parameter will be passed to the  ##
##    macro. Therefore ...,src/sprites,... will represent "src/sprites"   ##
##    folder, whereas ...,  src/sprites,... means "  src/sprites" folder. ##
##                                                                        ##
##  * You can omit parameters but leaving them empty. Therefore, if you   ##
##  wanted to specify an output folder but do not want your sprites to    ##
##  have mask and/or tileset, you may omit parameter (7) leaving it empty ##
##     $(eval $(call IMG2SPRITES,imgs/1.png,0,g,4,8,$(PAL),,src/))        ##
############################################################################
