HOME_ID = 0

!src "screens/home/home_tiles.inc"
!src "screens/home/home_map.inc"

;============================================================
; HOME_init
;============================================================
HOME_init:
	jsr HOME_initialize_layers
	jsr HOME_write_tiles
	jsr HOME_write_maps
	rts

;============================================================
; HOME_write_tiles
;============================================================
HOME_initialize_layers:
	+vset vreg_lay1 | AUTO_INC_1
	jsr init_layer_1_mode_0

	+vset vreg_lay2 | AUTO_INC_1
	jsr init_layer_2_mode_0

	rts
;============================================================
; HOME_write_tiles
;============================================================
HOME_write_tiles:
	; write layer 1 tile data
	+vset LAYER_1_TILES | AUTO_INC_1
	ldx #0
-	lda home_tiles,x
	sta veradat
	inx
	cpx #24
	bne -

	; write layer 2 tile data
	+vset LAYER_2_TILES | AUTO_INC_1
	ldx #0
-	lda home_tiles,x
	sta veradat
	inx
	cpx #24
	bne -

	rts

;============================================================
; HOME_write_maps
;============================================================
HOME_write_maps:

	; write layer 1 map data
	+vset LAYER_1_MAP | AUTO_INC_1
	+LoadW zp_map_pointer, home_layer_1
	jsr read_tile_map_mode_0

	; write layer 2 map data
	+vset LAYER_2_MAP | AUTO_INC_1
	+LoadW zp_map_pointer, home_layer_2
	jsr read_tile_map_mode_0

+	rts
