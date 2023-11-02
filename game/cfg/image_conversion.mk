## 16 colours palette
PALETTE=0 2 3 4 6 9 12 13 15 16 17 18 20 24 25 26

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
$(eval $(call IMG2SP, CONVERT, assets/spritesheet.png , 16, 16, spr_spritesheet))
$(eval $(call IMG2SP, CONVERT, assets/burro.png , 16, 16, spr_burro))
$(eval $(call IMG2SP, CONVERT, assets/galleta.png , 16, 16, spr_galleta))
$(eval $(call IMG2SP, CONVERT, assets/helado.png , 16, 16, spr_helado))
$(eval $(call IMG2SP, CONVERT, assets/cauldron.png , 16, 16, spr_cauldron))
$(eval $(call IMG2SP, CONVERT, assets/amstrad.png , 16, 16, spr_amstrad))

$(eval $(call IMG2SP, CONVERT, assets/puerta_horizontal.png , 16, 8, spr_puerta_horizontal))
$(eval $(call IMG2SP, CONVERT, assets/puerta_vertical.png , 8, 16, spr_puerta_vertical))
$(eval $(call IMG2SP, CONVERT, assets/llave.png , 16, 16, spr_llave))
$(eval $(call IMG2SP, CONVERT, assets/llavehud.png , 8, 8, spr_llave_hud))
$(eval $(call IMG2SP, CONVERT, assets/llavehud_gris.png , 8, 8, spr_llave_hud_gris))
$(eval $(call IMG2SP, CONVERT, assets/efecto_comer.png , 16, 16, spr_comer))
$(eval $(call IMG2SP, CONVERT, assets/enemigos.png , 16, 16, spr_enemigo_flobier))
$(eval $(call IMG2SP, CONVERT, assets/vidas.png , 8, 8, spr_vidas))
$(eval $(call IMG2SP, SET_IMG_FORMAT  , zgtiles            ))
$(eval $(call IMG2SP, CONVERT         , assets/tiles.png , 8, 8, tiles))

$(eval $(call IMG2SP, SET_FOLDER, assets/screens/))
$(eval $(call IMG2SP, SET_IMG_FORMAT, screen))
$(eval $(call IMG2SP, SET_OUTPUT, bin))
$(eval $(call IMG2SP, CONVERT, assets/menu_screen.png , 0, 0, menu_screen))	
