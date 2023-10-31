   ;;;;;;;;;;;;;;;;;;;;
   ;; DEFINED VALUES ;;
   ;;;;;;;;;;;;;;;;;;;;
     
   ;; cpctelera
      .globl cpct_getScreenPtr_asm
      .globl cpct_drawSolidBox_asm
                              
   ;; managers                            
      .globl _man_entity_for_all_matching 
      .globl quitar_vida
      .globl borrar_llave
      .globl lifes_available
      .globl set_llave
      .globl player_state
      .globl MAN_ANIM_PLAYER_HIT_ENEMY
      .globl consumibles_actuales
   ;; systems   
      .globl stop_sprite                       
      .globl anim_player_died
      .globl anim_eat
      .globl time_anim_eat
      .globl food_state
   ;; sprites
      .globl cpct_drawSolidBox_asm

   ;; tilemap
      .globl _tilemap_01

   ;; render
      .globl sys_render_draw_solid_box_player

   ;; entity
      .globl m_entities

   ;; level
      .globl consumibles_actuales
      .globl cambio_de_mapa
      .globl mapa_actual
