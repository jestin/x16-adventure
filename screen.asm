
;============================================================
; read_tile_map_mode_0
; This subroutine assumes you have set zp_map_pointer
; to the desired layer, as well as called +vset with
; the correct vram address and increment for the mapping
; Example:
;	+LoadW zp_map_pointer, home_layer_1
;	+vset $04000 | AUTO_INC_1
;	jsr read_tile_map_mode_0
;============================================================
read_tile_map_mode_0:

	ldx #0
	ldy #0

-	lda (zp_map_pointer)
	sta veradat
	+IncW zp_map_pointer
	lda (zp_map_pointer)
	sta veradat
	+IncW zp_map_pointer
	inx
	txa
	cmp #$7f	; 128
	bne -
	ldx #0
	iny
	tya
	cmp #$40	; 64
	beq +
	jmp -

+	rts

;============================================================
; init_layer_1_mode_0
; This subroutine assumes you have set the correct layer
; and increment to vram.
; Example:
;	+vset vreg_lay1 | AUTO_INC_1
;	jsr init_layer_1_mode_0
;============================================================
init_layer_1_mode_0:
	+vset vreg_lay1 | AUTO_INC_1
	lda #$01						; enable layer
	sta veradat
	lda #$06						; set MAPW/MAPH to 128x64
	sta veradat						; and TILEW/TILEH to 8x8
	lda #(<(LAYER_1_MAP) >> 2)
	sta veradat
	lda #(>(LAYER_1_MAP) >> 2)
	sta veradat						
	lda #(<(LAYER_1_TILES >> 2))
	sta veradat
	lda #(>(LAYER_1_TILES >> 2))
	sta veradat

	rts

;============================================================
; init_layer_2_mode_0
; This subroutine assumes you have set the correct layer
; and increment to vram.
; Example:
;	+vset vreg_lay1 | AUTO_INC_1
;	jsr init_layer_1_mode_0
;============================================================
init_layer_2_mode_0:
	lda #$01						; enable layer
	sta veradat
	lda #$06						; set MAPW/MAPH to 128x64
	sta veradat						; and TILEW/TILEH to 8x8
	lda #(<(LAYER_2_MAP) >> 2)
	sta veradat
	lda #(>(LAYER_2_MAP) >> 2)
	sta veradat						
	lda #(<(LAYER_2_TILES >> 2))
	sta veradat
	lda #(>(LAYER_2_TILES >> 2))
	sta veradat

	rts
