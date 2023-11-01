;;;;;;;;;;;;;;;;;;;;
;; GLOBAL SYMBOLS ;;
;;;;;;;;;;;;;;;;;;;;
   

   ;; Templates
   .globl flobier_entity
   .globl flobier_entity2
   .globl flobier_entity_patron
   .globl helado_entity
   .globl chocolate_entity
   .globl amstrad_entity
   .globl puerta_horizontal_entity
   .globl puerta_vertical_entity
   .globl llave_entity

   ;; Manager
   .globl man_game_create_template_entity
   .globl set_burro_animations
   .globl set_lord_animations
   .globl set_cauldron_animations
   .globl borrar_entidades
   .globl _man_entity_init
   .globl _inicialize_templates
   .globl _main
   .globl stop_score

   .globl reset_hud
   .globl save_points
   .globl man_levelscreen_update
   .globl man_levelscreen_init
   .globl cpct_akp_stop_asm
   .globl cpct_akp_musicPlay_asm
   ;;ia
   .globl anim_cauldron_up
   .globl anim_enemy_right
   ;; Render
   .globl sys_render_tilemap

   ;; Tilemap
   .globl _tilemap_01
   .globl tilemap_position
   .globl position_initial_player

   ;; Player
   .globl m_entities
   ;; ia
   .globl sys_ai_vertical_enemie
   ; .globl sys_ai_vertical_enemie_mapa2
   .globl sys_ia_patron_360