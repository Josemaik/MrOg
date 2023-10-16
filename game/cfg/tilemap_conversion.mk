#$(eval $(call TMX2DATA, SET_ASMVARPREFIX, yes       ))   { yes, no      }
#$(eval $(call TMX2DATA, SET_USEMACROS   , yes       ))   { yes, no      }
#$(eval $(call TMX2DATA, SET_OUTPUTS     , h c       ))   { bin hs h s c }
#$(eval $(call TMX2DATA, SET_BASE        , dec       ))   { dec hex bin }
#$(eval $(call TMX2DATA, SET_BITSPERITEM , 8         ))   { 1, 2, 4, 6, 8 }
#$(eval $(call TMX2DATA, SET_FOLDER      , src/      )) 
#$(eval $(call TMX2DATA, SET_EXTRAPAR    ,           ))	
# Conversion 
#$(eval $(call TMX2DATA, CONVERT, tmxfile, array )) 

$(eval $(call TMX2DATA, SET_OUTPUTS     , hs s       ))
$(eval $(call TMX2DATA, SET_FOLDER      , src/tilemaps/   )) 
$(eval $(call TMX2DATA, CONVERT, assets/mapa.tmx, tilemap_01 )) 

##
## OLD MACROS (For compatibility)
##

## TILEMAP CONVERSION EXAMPLES (Uncomment EVAL lines to use)
##

## Convert img/tilemap.tmx to src/tilemap.c and src/tilemap.h
##		This file contains a tilemap created with Tiled that uses tiles
## in img/tiles.png. This macro will convert the tilemap into a C-array
## named g_tilemap, containing all the IDs of the tiles that are located 
## at each given location of the C-array. 
##

#$(eval $(call TMX2C,img/tilemap.tmx,g_tilemap,src/,4))

## Convert img/level0b.tmx to src/levels/level0b.c and src/levels/level0b.h
##		This file contains another tilemap created with Tiled. This macro 
## will convert the tilemap into a C bitarray of 4-bits per item. The array
## will be named g_level0_4bit. For each tile ID included into the final 
## bitarray, only 4 bits will be used. Therefore, each byte of the array 
## will contain 2 tile IDs.
##

#$(eval $(call TMX2C,img/level0b.tmx,g_level0_4bit,src/levels/,4))


